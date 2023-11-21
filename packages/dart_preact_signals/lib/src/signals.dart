// ignore_for_file: prefer_final_fields, constant_identifier_names

void cycleDetected() {
  throw Exception('Cycle detected');
}

void mutationDetected() {
  throw Exception('Computed cannot have side-effects');
}

const identifier = Symbol('preact-signals');

// Flags for Computed and Effect.
const RUNNING = 1 << 0;
const NOTIFIED = 1 << 1;
const OUTDATED = 1 << 2;
const DISPOSED = 1 << 3;
const HAS_ERROR = 1 << 4;
const TRACKING = 1 << 5;

// A linked list node used to track dependencies (sources) and dependents (targets).
// Also used to remember the source's last version number that the target saw.
class Node {
  // A source whose value the target depends on.
  Signal _source;
  Node? _prevSource;
  Node? _nextSource;

  // A target that depends on the source and should be notified when the source changes.
  Listenable _target;
  Node? _prevTarget;
  Node? _nextTarget;

  // The version number of the source that target has last seen. We use version numbers
  // instead of storing the source value, because source values can take arbitrary amount
  // of memory, and computeds could hang on to them forever because they're lazily evaluated.
  // Use the special value -1 to mark potentially unused but recyclable nodes.
  int _version;

  // Used to remember & roll back the source's previous `._node` value when entering &
  // exiting a new evaluation context.
  Node? _rollbackNode;

  Node({
    required Signal source,
    Node? prevSource,
    Node? nextSource,
    required Listenable target,
    Node? prevTarget,
    Node? nextTarget,
    required int version,
    Node? rollbackNode,
  })  : _source = source,
        _prevSource = prevSource,
        _nextSource = nextSource,
        _target = target,
        _prevTarget = prevTarget,
        _nextTarget = nextTarget,
        _version = version,
        _rollbackNode = rollbackNode;
}

void startBatch() {
  batchDepth++;
}

void endBatch() {
  if (batchDepth > 1) {
    batchDepth--;
    return;
  }

  Object? error;
  bool hasError = false;

  while (batchedEffect != null) {
    Effect? effect = batchedEffect;
    batchedEffect = null;

    batchIteration++;

    while (effect != null) {
      final Effect? next = effect._nextBatchedEffect;
      effect._nextBatchedEffect = null;
      effect._flags &= ~NOTIFIED;

      if (!((effect._flags & DISPOSED) != 0) && needsToRecompute(effect)) {
        try {
          effect._callback();
        } catch (err) {
          if (!hasError) {
            error = err;
            hasError = true;
          }
        }
      }
      effect = next;
    }
  }
  batchIteration = 0;
  batchDepth--;

  if (hasError) {
    throw error!;
  }
}

typedef BatchCallback<T> = T Function();

T batch<T>(BatchCallback<T> callback) {
  if (batchDepth > 0) {
    return callback();
  }
  startBatch();
  try {
    return callback();
  } finally {
    endBatch();
  }
}

// Currently evaluated computed or effect.
Listenable? evalContext;

int untrackedDepth = 0;

typedef UntrackedCallback<T> = T Function();

T untracked<T>(UntrackedCallback<T> callback) {
  if (untrackedDepth > 0) {
    return callback();
  }
  final prevContext = evalContext;
  evalContext = null;
  untrackedDepth++;
  try {
    return callback();
  } finally {
    untrackedDepth--;
    evalContext = prevContext;
  }
}

// Effects collected into a batch.
Effect? batchedEffect;
int batchDepth = 0;
int batchIteration = 0;

// A global version number for signals, used for fast-pathing repeated
// computed.peek()/computed.value calls when nothing has changed globally.
int globalVersion = 0;

Node? addDependency(Signal signal) {
  if (evalContext == null) {
    return null;
  }

  var node = signal._node;
  if (node == null || node._target != evalContext) {
    /**
		 * `signal` is a new dependency. Create a new dependency node, and set it
		 * as the tail of the current context's dependency list. e.g:
		 *
		 * { A <-> B       }
		 *         ↑     ↑
		 *        tail  node (new)
		 *               ↓
		 * { A <-> B <-> C }
		 *               ↑
		 *              tail (evalContext._sources)
		 */
    node = Node(
      version: 0,
      source: signal,
      prevSource: evalContext!._sources,
      nextSource: null,
      target: evalContext!,
      prevTarget: null,
      nextTarget: null,
      rollbackNode: node,
    );

    if (evalContext!._sources != null) {
      evalContext!._sources!._nextSource = node;
    }
    evalContext!._sources = node;
    signal._node = node;

    // Subscribe to change notifications from this dependency if we're in an effect
    // OR evaluating a computed signal that in turn has subscribers.
    if ((evalContext!._flags & TRACKING) != 0) {
      signal._subscribe(node);
    }
    return node;
  } else if (node._version == -1) {
    // `signal` is an existing dependency from a previous evaluation. Reuse it.
    node._version = 0;

    /**
		 * If `node` is not already the current tail of the dependency list (i.e.
		 * there is a next node in the list), then make the `node` the new tail. e.g:
		 *
		 * { A <-> B <-> C <-> D }
		 *         ↑           ↑
		 *        node   ┌─── tail (evalContext._sources)
		 *         └─────│─────┐
		 *               ↓     ↓
		 * { A <-> C <-> D <-> B }
		 *                     ↑
		 *                    tail (evalContext._sources)
		 */
    if (node._nextSource != null) {
      node._nextSource!._prevSource = node._prevSource;

      if (node._prevSource != null) {
        node._prevSource!._nextSource = node._nextSource;
      }

      node._prevSource = evalContext!._sources;
      node._nextSource = null;

      evalContext!._sources!._nextSource = node;
      evalContext!._sources = node;
    }

    // We can assume that the currently evaluated effect / computed signal is already
    // subscribed to change notifications from `signal` if needed.
    return node;
  }
  return null;
}

abstract class ReadonlySignal<T> {
  T get value;

  @override
  String toString();

  T toJson();

  T call();

  T peek();

  EffectCleanup subscribe(void Function(T value) fn);
}

abstract class MutableSignal<T> extends ReadonlySignal<T> {
  set value(T value);
}

class Signal<T extends dynamic> extends MutableSignal<T> {
  final String? debugLabel;

  // @internal
  T _value;

  /// @internal
  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  int _version;

  // @internal
  Node? _node;

  // @internal
  Node? _targets;

  Signal(this._value, {this.debugLabel}) : _version = 0;

  bool _refresh() {
    return true;
  }

  void _subscribe(Node node) {
    if (this._targets != node && node._prevTarget == null) {
      node._nextTarget = this._targets;
      if (this._targets != null) {
        this._targets!._prevTarget = node;
      }
      this._targets = node;
    }
  }

  void _unsubscribe(Node node) {
    // Only run the unsubscribe step if the signal has any subscribers to begin with.
    if (this._targets != null) {
      final prev = node._prevTarget;
      final next = node._nextTarget;
      if (prev != null) {
        prev._nextTarget = next;
        node._prevTarget = null;
      }
      if (next != null) {
        next._prevTarget = prev;
        node._nextTarget = null;
      }
      if (node == this._targets) {
        this._targets = next;
      }
    }
  }

  @override
  EffectCleanup subscribe(void Function(T value) fn) {
    final signal = this;
    return effect(() {
      final effect = currentEffect!;
      final value = signal.value;
      final flag = effect._flags & TRACKING;
      effect._flags &= ~TRACKING;
      try {
        fn(value);
      } finally {
        effect._flags |= flag;
      }
    });
  }

  @override
  T call() => this.value;

  @override
  String toString() => '$value';

  @override
  T toJson() => value;

  @override
  T peek() => this._value;

  Symbol brand = identifier;

  @override
  T get value {
    final node = addDependency(this);
    if (node != null) {
      node._version = this._version;
    }
    return this._value;
  }

  @override
  set value(T val) {
    if (evalContext is Computed) {
      mutationDetected();
    }

    if (val != this._value) {
      if (batchIteration > 100) {
        cycleDetected();
      }

      this._value = val;
      this._version++;
      globalVersion++;

      startBatch();
      try {
        for (var node = this._targets; node != null; node = node._nextTarget) {
          node._target._notify();
        }
      } finally {
        endBatch();
      }
    }
  }
}

MutableSignal<T> signal<T>(T value, {String? debugLabel}) {
  return Signal<T>(value, debugLabel: debugLabel);
}

abstract class Listenable {
  Node? _sources;
  int get _flags;
  void _notify();
}

bool needsToRecompute(Listenable target) {
  // Check the dependencies for changed values. The dependency list is already
  // in order of use. Therefore if multiple dependencies have changed values, only
  // the first used dependency is re-evaluated at this point.
  for (var node = target._sources; node != null; node = node._nextSource) {
    // If there's a new version of the dependency before or after refreshing,
    // or the dependency has something blocking it from refreshing at all (e.g. a
    // dependency cycle), then we need to recompute.
    if (node._source._version != node._version ||
        !node._source._refresh() ||
        node._source._version != node._version) {
      return true;
    }
  }
  // If none of the dependencies have changed values since last recompute then
  // there's no need to recompute.
  return false;
}

void prepareSources(Listenable target) {
  /**
	 * 1. Mark all current sources as re-usable nodes (version: -1)
	 * 2. Set a rollback node if the current node is being used in a different context
	 * 3. Point 'target._sources' to the tail of the doubly-linked list, e.g:
	 *
	 *    { undefined <- A <-> B <-> C -> undefined }
	 *                   ↑           ↑
	 *                   │           └──────┐
	 * target._sources = A; (node is head)  │
	 *                   ↓                  │
	 * target._sources = C; (node is tail) ─┘
	 */
  for (var node = target._sources; node != null; node = node._nextSource) {
    final rollbackNode = node._source._node;
    if (rollbackNode != null) {
      node._rollbackNode = rollbackNode;
    }
    node._source._node = node;
    node._version = -1;

    if (node._nextSource == null) {
      target._sources = node;
      break;
    }
  }
}

void cleanupSources(Listenable target) {
  var node = target._sources;
  Node? head;

  /**
	 * At this point 'target._sources' points to the tail of the doubly-linked list.
	 * It contains all existing sources + new sources in order of use.
	 * Iterate backwards until we find the head node while dropping old dependencies.
	 */
  while (node != null) {
    final prev = node._prevSource;

    /**
		 * The node was not re-used, unsubscribe from its change notifications and remove itself
		 * from the doubly-linked list. e.g:
		 *
		 * { A <-> B <-> C }
		 *         ↓
		 *    { A <-> C }
		 */
    if (node._version == -1) {
      node._source._unsubscribe(node);

      if (prev != null) {
        prev._nextSource = node._nextSource;
      }
      if (node._nextSource != null) {
        node._nextSource!._prevSource = prev;
      }
    } else {
      /**
			 * The new head is the last node seen which wasn't removed/unsubscribed
			 * from the doubly-linked list. e.g:
			 *
			 * { A <-> B <-> C }
			 *   ↑     ↑     ↑
			 *   │     │     └ head = node
			 *   │     └ head = node
			 *   └ head = node
			 */
      head = node;
    }

    node._source._node = node._rollbackNode;
    if (node._rollbackNode != null) {
      node._rollbackNode = null;
    }

    node = prev;
  }

  target._sources = head;
}

class Computed<T extends Object> extends Signal<dynamic> implements Listenable {
  ComputedCallback<T> _compute;

  final String? debugLabel;

  @override
  Node? _sources;

  int _globalVersion;

  @override
  int _flags;

  Computed(ComputedCallback<T> compute, {this.debugLabel})
      : _compute = compute,
        _globalVersion = globalVersion - 1,
        _flags = OUTDATED,
        super(null);

  @override
  bool _refresh() {
    this._flags &= ~NOTIFIED;

    if ((this._flags & RUNNING) != 0) {
      return false;
    }

    // If this computed signal has subscribed to updates from its dependencies
    // (TRACKING flag set) and none of them have notified about changes (OUTDATED
    // flag not set), then the computed value can't have changed.
    if ((this._flags & (OUTDATED | TRACKING)) == TRACKING) {
      return true;
    }
    this._flags &= ~OUTDATED;

    if (this._globalVersion == globalVersion) {
      return true;
    }
    this._globalVersion = globalVersion;

    // Mark this computed signal running before checking the dependencies for value
    // changes, so that the RUNNING flag can be used to notice cyclical dependencies.
    this._flags |= RUNNING;
    if (_version > 0 && !needsToRecompute(this)) {
      this._flags &= ~RUNNING;
      return true;
    }

    final prevContext = evalContext;
    try {
      prepareSources(this);
      evalContext = this;
      final value = this._compute();
      if ((this._flags & HAS_ERROR) != 0 || _value != value || _version == 0) {
        _value = value;
        _flags &= ~HAS_ERROR;
        _version++;
      }
    } catch (err) {
      _value = err as dynamic; // <- TODO: Weird but ok
      _flags |= HAS_ERROR;
      _version++;
    }
    evalContext = prevContext;
    cleanupSources(this);
    _flags &= ~RUNNING;
    return true;
  }

  @override
  void _subscribe(Node node) {
    if (_targets == null) {
      _flags |= OUTDATED | TRACKING;

      // A computed signal subscribes lazily to its dependencies when the it
      // gets its first subscriber.
      for (var node = _sources; node != null; node = node._nextSource) {
        node._source._subscribe(node);
      }
    }
    super._subscribe(node);
  }

  @override
  void _unsubscribe(Node node) {
    // Only run the unsubscribe step if the computed signal has any subscribers.
    if (_targets != null) {
      super._unsubscribe(node);

      // Computed signal unsubscribes from its dependencies when it loses its last subscriber.
      // This makes it possible for unreferences subgraphs of computed signals to get garbage collected.
      if (_targets == null) {
        _flags &= ~TRACKING;

        for (var node = _sources; node != null; node = node._nextSource) {
          node._source._unsubscribe(node);
        }
      }
    }
  }

  @override
  void _notify() {
    if (!((_flags & NOTIFIED) != 0)) {
      _flags |= OUTDATED | NOTIFIED;

      for (var node = _targets; node != null; node = node._nextTarget) {
        node._target._notify();
      }
    }
  }

  @override
  T peek() {
    if (!_refresh()) {
      cycleDetected();
    }
    if ((_flags & HAS_ERROR) != 0) {
      throw _value!;
    }
    return _value!;
  }

  @override
  T get value {
    if ((_flags & RUNNING) != 0) {
      cycleDetected();
    }

    final node = addDependency(this);
    _refresh();
    if (node != null) {
      node._version = _version;
    }
    if ((_flags & HAS_ERROR) != 0) {
      throw _value!;
    }
    return _value!;
  }

  @override
  T call() => this.value;

  @override
  String toString() => '$value';

  @override
  T toJson() => value;
}

typedef ComputedCallback<T> = T Function();

ReadonlySignal<T> computed<T extends Object>(
  ComputedCallback<T> compute, {
  String? debugLabel,
}) {
  return Computed<T>(compute, debugLabel: debugLabel) as ReadonlySignal<T>;
}

void cleanupEffect(Effect effect) {
  final cleanup = effect._cleanup;
  effect._cleanup = null;

  if (cleanup != null) {
    startBatch();

    // Run cleanup functions always outside of any context.
    final prevContext = evalContext;
    evalContext = null;
    try {
      cleanup();
    } catch (e) {
      effect._flags &= ~RUNNING;
      effect._flags |= DISPOSED;
      disposeEffect(effect);
      rethrow;
    } finally {
      evalContext = prevContext;
      endBatch();
    }
  }
}

void disposeEffect(Effect effect) {
  for (var node = effect._sources; node != null; node = node._nextSource) {
    node._source._unsubscribe(node);
  }
  effect._compute = null;
  effect._sources = null;

  cleanupEffect(effect);
}

void endEffect(Effect effect, Listenable? prevContext) {
  if (evalContext != effect) {
    throw Exception('Out-of-order effect');
  }
  cleanupSources(effect);
  evalContext = prevContext;

  effect._flags &= ~RUNNING;
  if ((effect._flags & DISPOSED) != 0) {
    disposeEffect(effect);
  }
  endBatch();
}

typedef EffectCleanup = void Function();
typedef EffectCallback = Function();

Effect? currentEffect;

class Effect implements Listenable {
  EffectCallback? _compute;
  String? debugLabel;

  Function? _cleanup;

  @override
  Node? _sources;

  Effect? _nextBatchedEffect;

  @override
  int _flags;

  Effect(EffectCallback compute, {this.debugLabel})
      : _flags = TRACKING,
        _compute = compute,
        _cleanup = null;

  void _callback() {
    final finish = _start();
    try {
      if ((_flags & DISPOSED) != 0) return;
      if (_compute == null) return;
      currentEffect = this;
      final cleanup = _compute!();
      currentEffect = null;
      if (cleanup is Function) {
        _cleanup = cleanup;
      }
    } finally {
      finish();
    }
  }

  EffectCleanup _start() {
    if ((_flags & RUNNING) != 0) {
      cycleDetected();
    }
    _flags |= RUNNING;
    _flags &= ~DISPOSED;
    cleanupEffect(this);
    prepareSources(this);

    startBatch();
    final prevContext = evalContext;
    evalContext = this;
    return () => endEffect(this, prevContext);
  }

  @override
  void _notify() {
    if (!((_flags & NOTIFIED) != 0)) {
      _flags |= NOTIFIED;
      _nextBatchedEffect = batchedEffect;
      batchedEffect = this;
    }
  }

  void _dispose() {
    _flags |= DISPOSED;
    if (!((_flags & RUNNING) != 0)) {
      disposeEffect(this);
    }
  }
}

EffectCleanup effect(EffectCallback compute, {String? debugLabel}) {
  final effect = Effect(compute, debugLabel: debugLabel);
  try {
    effect._callback();
  } catch (e) {
    effect._dispose();
    rethrow;
  }
  // Return a bound function instead of a wrapper like `() => effect._dispose()`,
  // because bound functions seem to be just as fast and take up a lot less memory.
  return () => effect._dispose();
}
