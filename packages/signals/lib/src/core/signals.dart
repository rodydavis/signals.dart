// ignore_for_file: public_member_api_docs, constant_identifier_names
import 'dart:convert';
import 'dart:developer' as developer;

import 'observer.dart';
import '../utils/constants.dart';

part 'devtool.dart';

const _maxCallDepth = 100;

/// Cycle detection usually means you have updated
/// a signal inside an effect and are reading by value.
class EffectCycleDetectionError extends Error {}

void _cycleDetected() {
  throw EffectCycleDetectionError();
}

/// Mutation detection usually means you have updated
/// a signal inside a computed.
///
/// Computed cannot have side-effects
class MutationDetectedError extends Error {}

void _mutationDetected() {
  throw MutationDetectedError();
}

const identifier = Symbol('signals');

// Flags for Computed and Effect.
const RUNNING = 1 << 0;
const NOTIFIED = 1 << 1;
const OUTDATED = 1 << 2;
const DISPOSED = 1 << 3;
const HAS_ERROR = 1 << 4;
const TRACKING = 1 << 5;

// A linked list node used to track dependencies (sources) and dependents (targets).
// Also used to remember the source's last version number that the target saw.
class _Node {
  // A source whose value the target depends on.
  final ReadonlySignal _source;
  _Node? _prevSource;
  _Node? _nextSource;

  // A target that depends on the source and should be notified when the source changes.
  final _Listenable _target;
  _Node? _prevTarget;
  _Node? _nextTarget;

  // The version number of the source that target has last seen. We use version numbers
  // instead of storing the source value, because source values can take arbitrary amount
  // of memory, and computeds could hang on to them forever because they're lazily evaluated.
  // Use the special value -1 to mark potentially unused but recyclable nodes.
  int _version;

  // Used to remember & roll back the source's previous `._node` value when entering &
  // exiting a new evaluation context.
  _Node? _rollbackNode;

  _Node({
    required ReadonlySignal source,
    _Node? prevSource,
    _Node? nextSource,
    required _Listenable target,
    _Node? prevTarget,
    _Node? nextTarget,
    required int version,
    _Node? rollbackNode,
  })  : _source = source,
        _prevSource = prevSource,
        _nextSource = nextSource,
        _target = target,
        _prevTarget = prevTarget,
        _nextTarget = nextTarget,
        _version = version,
        _rollbackNode = rollbackNode;
}

void _startBatch() {
  _batchDepth++;
}

void _endBatch() {
  if (_batchDepth > 1) {
    _batchDepth--;
    return;
  }

  dynamic error;
  bool hasError = false;

  while (_batchedEffect != null) {
    _Effect? effect = _batchedEffect;
    _batchedEffect = null;

    _++;

    while (effect != null) {
      final _Effect? next = effect._nextBatchedEffect;
      effect._nextBatchedEffect = null;
      effect._flags &= ~NOTIFIED;

      if (!((effect._flags & DISPOSED) != 0) && _needsToRecompute(effect)) {
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
  _ = 0;
  _batchDepth--;

  if (hasError) {
    throw error;
  }
}

typedef BatchCallback<T> = T Function();

/// The `batch` function allows you to combine multiple signal writes into one
/// single update that is triggered at the end when the callback completes.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// effect(() => print(fullName.value));
///
/// // Combines both signal writes into one update. Once the callback
/// // returns the `effect` will trigger and we'll log "Foo Bar"
/// batch(() {
/// 	name.value = "Foo";
/// 	surname.value = "Bar";
/// });
/// ```
///
/// When you access a signal that you wrote to earlier inside the callback,
/// or access a computed signal that was invalidated by another signal, we'll
/// only update the necessary dependencies to get the current value for the
/// signal you read from. All other invalidated signals will update at the
/// end of the callback function.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final counter = signal(0);
/// final _double = computed(() => counter.value * 2);
/// final _triple = computed(() => counter.value * 3);
///
/// effect(() => print(_double.value, _triple.value));
///
/// batch(() {
/// 	counter.value = 1;
/// 	// Logs: 2, despite being inside batch, but `triple`
/// 	// will only update once the callback is complete
/// 	print(_double.value);
/// });
/// // Now we reached the end of the batch and call the effect
/// ```
///
/// Batches can be nested and updates will be flushed when the outermost
/// batch call completes.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final counter = signal(0);
/// effect(() => print(counter.value));
///
/// batch(() {
/// 	batch(() {
/// 		// Signal is invalidated, but update is not flushed because
/// 		// we're still inside another batch
/// 		counter.value = 1;
/// 	});
///
/// 	// Still not updated...
/// });
/// // Now the callback completed and we'll trigger the effect.
/// ```
T batch<T>(BatchCallback<T> callback) {
  if (_batchDepth > 0) {
    return callback();
  }
  _startBatch();
  try {
    return callback();
  } finally {
    _endBatch();
  }
}

// Currently evaluated computed or effect.
_Listenable? _evalContext;

int _untrackedDepth = 0;

typedef UntrackedCallback<T> = T Function();

/// In case when you're receiving a callback that can read some signals,
/// but you don't want to subscribe to them, you can use `untracked` to
/// prevent any subscriptions from happening.
///
/// ```dart
/// final counter = signal(0);
/// final effectCount = signal(0);
/// final fn = () => effectCount.value + 1;
///
/// effect(() {
/// 	print(counter.value);
///
/// 	// Whenever this effect is triggered, run `fn` that gives new value
/// 	effectCount.value = untracked(fn);
/// });
/// ```
T untracked<T>(UntrackedCallback<T> callback) {
  if (_untrackedDepth > 0) {
    return callback();
  }
  final prevContext = _evalContext;
  _evalContext = null;
  _untrackedDepth++;
  try {
    return callback();
  } finally {
    _untrackedDepth--;
    _evalContext = prevContext;
  }
}

// Effects collected into a batch.
_Effect? _batchedEffect;
int _batchDepth = 0;
int _ = 0;

// A global version number for signals, used for fast-pathing repeated
// computed.peek()/computed.value calls when nothing has changed globally.
int globalVersion = 0;

_Node? _addDependency(ReadonlySignal signal) {
  if (_evalContext == null) {
    return null;
  }

  var node = signal._node;
  if (node == null || node._target != _evalContext) {
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
    node = _Node(
      version: 0,
      source: signal,
      prevSource: _evalContext!._sources,
      nextSource: null,
      target: _evalContext!,
      prevTarget: null,
      nextTarget: null,
      rollbackNode: node,
    );

    if (_evalContext!._sources != null) {
      _evalContext!._sources!._nextSource = node;
    }
    _evalContext!._sources = node;
    signal._node = node;

    // Subscribe to change notifications from this dependency if we're in an effect
    // OR evaluating a computed signal that in turn has subscribers.
    if ((_evalContext!._flags & TRACKING) != 0) {
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

      node._prevSource = _evalContext!._sources;
      node._nextSource = null;

      _evalContext!._sources!._nextSource = node;
      _evalContext!._sources = node;
    }

    // We can assume that the currently evaluated effect / computed signal is already
    // subscribed to change notifications from `signal` if needed.
    return node;
  }
  return null;
}

int _lastGlobalId = 0;

abstract class ReadonlySignal<T> {
  List<_Listenable> get _allTargets;

  /// Debug label for Debug Mode
  String? get debugLabel;

  /// Global ID of the signal
  int get globalId;

  /// Compute the current value
  T get value;

  /// Get the last value before the last update or the initial value
  ///
  /// This does not subscribe in an effect and is the equivalent to peek()
  T get previousValue;

  @override
  String toString();

  /// Convert value to JSON
  T toJson();

  /// Return the value when invoked
  T call();

  T get();

  /// In the rare instance that you have an effect that should write to
  /// another signal based on the previous value, but you _don't_ want the
  /// effect to be subscribed to that signal, you can read a signals's
  /// previous value via `signal.peek()`.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final effectCount = signal(0);
  ///
  /// effect(() {
  /// 	print(counter.value);
  ///
  /// 	// Whenever this effect is triggered, increase `effectCount`.
  /// 	// But we don't want this signal to react to `effectCount`
  /// 	effectCount.value = effectCount.peek() + 1;
  /// });
  /// ```
  ///
  /// Note that you should only use `signal.peek()` if you really need it.
  /// Reading a signal's value via `signal.value` is the preferred way in most scenarios.
  T peek();

  /// Subscribe to value changes
  EffectCleanup subscribe(void Function(T value) fn);

  void _subscribe(_Node node);

  void _unsubscribe(_Node node);

  /// @internal
  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  int get _version;

  // @internal
  _Node? _node;

  // @internal
  _Node? _targets;

  bool _refresh();
}

/// The `signal` function creates a new signal. A signal is a container for
/// a value that can change over time. You can read a signal's value or
/// subscribe to value updates by accessing its `.value` property.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final counter = signal(0);
///
/// // Read value from signal, logs: 0
/// print(counter.value);
///
/// // Write to a signal
/// counter.value = 1;
/// ```
///
/// Writing to a signal is done by setting its `.value` property.
/// Changing a signal's value synchronously updates every `computed`
/// and `effect` that depends on that signal, ensuring your app state
/// is always consistent.

abstract class Signal<T> implements ReadonlySignal<T> {
  /// Update the current value
  set value(T value);

  /// Set the current value
  void set(T value);
}

/// Signal that can read and write a value
@Deprecated('Use `Signal` instead')
typedef MutableSignal<T> = Signal<T>;

/// Signal that can be extended and used as a class
class ValueSignal<T> extends _Signal<T> {
  ValueSignal(super.value, {super.debugLabel});

  /// Should only be called to update the value of a signal if checks for equality
  /// have already been made.
  ///
  /// This is primarily used by the `ValueSignal` class to update the value
  /// since the reference is always the same.
  void forceUpdate(T val) {
    _updateValue(val);
  }
}

class _Signal<T> implements Signal<T> {
  @override
  final int globalId;

  @override
  final String? debugLabel;

  _Signal(this._value, {this.debugLabel})
      : _version = 0,
        _previousValue = _value,
        brand = identifier,
        globalId = ++_lastGlobalId {
    _onSignalCreated(this);
  }

  // @internal
  T _value;
  T _previousValue;

  /// @internal
  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  @override
  int _version;

  @override
  bool _refresh() {
    return true;
  }

  @override
  bool operator ==(Object other) {
    return other is Signal<T> && value == other.value;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      globalId.hashCode,
      value.hashCode,
    ]);
  }

  static void __subscribe(ReadonlySignal signal, _Node node) {
    if (signal._targets != node && node._prevTarget == null) {
      node._nextTarget = signal._targets;
      if (signal._targets != null) {
        signal._targets!._prevTarget = node;
      }
      signal._targets = node;
    }
  }

  @override
  void _subscribe(_Node node) => __subscribe(this, node);

  static void __unsubscribe(ReadonlySignal signal, _Node node) {
    // Only run the unsubscribe step if the signal has any subscribers to begin with.
    if (signal._targets != null) {
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
      if (node == signal._targets) {
        signal._targets = next;
      }
    }
  }

  @override
  void _unsubscribe(_Node node) => __unsubscribe(this, node);

  @override
  EffectCleanup subscribe(void Function(T value) fn) {
    return __signalSubscribe(this, fn);
  }

  @override
  List<_Listenable> get _allTargets {
    final results = <_Listenable>[];
    _Node? root = _targets;
    for (var node = root; node != null; node = node._nextTarget) {
      results.add(node._target);
    }
    return results;
  }

  static EffectCleanup __signalSubscribe<T>(
    ReadonlySignal<T> signal,
    void Function(T value) fn,
  ) {
    return effect(() {
      final effect = _currentEffect!;
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

  @override
  T get() => value;

  @override
  void set(T value) => this.value = value;

  final Symbol brand;

  @override
  T get value {
    final node = _addDependency(this);
    if (node != null) {
      node._version = this._version;
    }
    return this._value;
  }

  @override
  T get previousValue => this._previousValue;

  @override
  set value(T val) {
    if (_evalContext is Computed) {
      _mutationDetected();
    }

    if (val != this._value) {
      _updateValue(val);
    }
  }

  void _updateValue(T val) {
    if (_ > _maxCallDepth) {
      _cycleDetected();
    }

    this._previousValue = _value;
    this._value = val;
    this._version++;
    globalVersion++;

    _startBatch();
    try {
      for (var node = _targets; node != null; node = node._nextTarget) {
        node._target._notify();
      }
    } finally {
      _endBatch();
    }

    _onSignalUpdated(this, val);
  }

  @override
  _Node? _node;

  @override
  _Node? _targets;
}

/// The `signal` function creates a new signal. A signal is a container
/// for a value that can change over time. You can read a signal's
/// value or subscribe to value updates by accessing its `.value` property.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final counter = signal(0);
///
/// // Read value from signal, logs: 0
/// print(counter.value);
///
/// // Write to a signal
/// counter.value = 1;
/// ```
///
/// Writing to a signal is done by setting its `.value` property.
/// Changing a signal's value synchronously updates every `computed`
/// and `effect` that depends on that signal, ensuring your app state is
/// always consistent.
Signal<T> signal<T>(T value, {String? debugLabel}) {
  return _Signal<T>(
    value,
    debugLabel: debugLabel,
  );
}

abstract class _Listenable {
  _Node? _sources;

  int get _flags;

  /// Debug label for Debug Mode
  String? get debugLabel;

  /// Global ID of the signal
  int get globalId;

  void _notify();
}

bool _needsToRecompute(_Listenable target) {
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

void _prepareSources(_Listenable target) {
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

void _cleanupSources(_Listenable target) {
  var node = target._sources;
  _Node? head;

  /**
   * At this point 'target._sources' points to the tail of the doubly-linked list.
   * It contains all existing sources + new sources in order of use.
   * Iterate backwards until we find the head node while dropping old dependencies.
   */
  while (node != null) {
    final prev = node._prevSource;

    /**
     * The node was not re-used, unsubscribe from its change notifications 
     * and remove itself from the doubly-linked list. e.g:
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

/// Data is often derived from other pieces of existing data. The `computed`
/// function lets you combine the values of multiple signals into a new
/// signal that can be reacted to, or even used by additional computeds.
/// When the signals accessed from within a computed callback change, the
/// computed callback is re-executed and its new return value becomes the
/// computed signal's value.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
///
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// print(fullName.value);
///
/// // Updates flow through computed, but only if someone
/// // subscribes to it. More on that later.
/// name.value = "John";
/// // Logs: "John Doe"
/// print(fullName.value);
/// ```
///
/// Any signal that is accessed inside the `computed`'s callback
/// function will be automatically subscribed to and tracked as a
/// dependency of the computed signal.
abstract class Computed<T> implements ReadonlySignal<T> {
  List<ReadonlySignal> get _allSources;
  @override
  List<_Listenable> get _allTargets;
}

class _Computed<T> implements Computed<T>, _Listenable {
  final ComputedCallback<T> _compute;

  @override
  final int globalId;

  @override
  final String? debugLabel;

  @override
  _Node? _sources;

  int _globalVersion;

  @override
  int _flags;

  Object? _error;

  bool _initialized = false;
  late T _value, _previousValue;

  @override
  bool operator ==(Object other) {
    return other is Signal<T> && value == other.value;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      globalId.hashCode,
      value.hashCode,
    ]);
  }

  @override
  List<ReadonlySignal> get _allSources {
    final results = <ReadonlySignal>[];
    _Node? root = _sources;
    for (var node = root; node != null; node = node._nextSource) {
      results.add(node._source);
    }
    return results;
  }

  @override
  List<_Listenable> get _allTargets {
    final results = <_Listenable>[];
    _Node? root = _targets;
    for (var node = root; node != null; node = node._nextTarget) {
      results.add(node._target);
    }
    return results;
  }

  _Computed(ComputedCallback<T> compute, {this.debugLabel})
      : _compute = compute,
        _globalVersion = globalVersion - 1,
        _flags = OUTDATED,
        _version = 0,
        brand = identifier,
        globalId = ++_lastGlobalId {
    _onComputedCreated(this);
  }

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
    if (_version > 0 && !_needsToRecompute(this)) {
      this._flags &= ~RUNNING;
      return true;
    }

    final prevContext = _evalContext;
    try {
      _prepareSources(this);
      _evalContext = this;
      final value = _compute();
      if ((this._flags & HAS_ERROR) != 0 ||
          !_initialized ||
          _value != value ||
          _version == 0) {
        if (!_initialized) {
          _previousValue = value;
        } else {
          _previousValue = _value;
        }
        _value = value;
        if (!_initialized) _initialized = true;
        _flags &= ~HAS_ERROR;
        _version++;
      }
    } catch (err) {
      _error = err;
      _flags |= HAS_ERROR;
      _version++;
    }
    _evalContext = prevContext;
    _cleanupSources(this);
    _flags &= ~RUNNING;
    return true;
  }

  @override
  void _subscribe(_Node node) {
    if (_targets == null) {
      _flags |= OUTDATED | TRACKING;

      // A computed signal subscribes lazily to its dependencies when the it
      // gets its first subscriber.
      for (var node = _sources; node != null; node = node._nextSource) {
        node._source._subscribe(node);
      }
    }
    _Signal.__subscribe(this, node);
  }

  @override
  void _unsubscribe(_Node node) {
    // Only run the unsubscribe step if the computed signal has any subscribers.
    if (_targets != null) {
      _Signal.__unsubscribe(this, node);

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
      _cycleDetected();
    }
    if ((_flags & HAS_ERROR) != 0) {
      throw _value!;
    }
    return _value;
  }

  @override
  T get() => value;

  @override
  T get value {
    if ((_flags & RUNNING) != 0) {
      _cycleDetected();
    }
    final node = _addDependency(this);
    _refresh();
    if (node != null) {
      node._version = _version;
    }
    if ((_flags & HAS_ERROR) != 0) {
      throw _error!;
    }
    _onComputedUpdated(this, this._value);
    return this._value;
  }

  @override
  T get previousValue => this._previousValue;

  @override
  T call() => this.value;

  @override
  String toString() => '$value';

  @override
  T toJson() => value;

  @override
  _Node? _node;

  @override
  _Node? _targets;

  @override
  int _version;

  final Symbol brand;

  @override
  EffectCleanup subscribe(void Function(T value) fn) {
    return _Signal.__signalSubscribe(this, fn);
  }
}

typedef ComputedCallback<T> = T Function();

/// Data is often derived from other pieces of existing data. The `computed`
/// function lets you combine the values of multiple signals into a new signal
/// that can be reacted to, or even used by additional computeds. When the
/// signals accessed from within a computed callback change, the computed
/// callback is re-executed and its new return value becomes the computed
/// signal's value.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
///
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// print(fullName.value);
///
/// // Updates flow through computed, but only if someone
/// // subscribes to it. More on that later.
/// name.value = "John";
/// // Logs: "John Doe"
/// print(fullName.value);
/// ```
///
/// Any signal that is accessed inside the `computed`'s callback function
/// will be automatically subscribed to and tracked as a dependency of the
/// computed signal.
Computed<T> computed<T>(
  ComputedCallback<T> compute, {
  String? debugLabel,
}) {
  return _Computed<T>(
    compute,
    debugLabel: debugLabel,
  );
}

void _cleanupEffect(_Effect effect) {
  final cleanup = effect._cleanup;
  effect._cleanup = null;

  if (cleanup != null) {
    _startBatch();

    // Run cleanup functions always outside of any context.
    final prevContext = _evalContext;
    _evalContext = null;
    try {
      cleanup();
    } catch (e) {
      effect._flags &= ~RUNNING;
      effect._flags |= DISPOSED;
      _disposeEffect(effect);
      rethrow;
    } finally {
      _evalContext = prevContext;
      _endBatch();
    }
  }
}

void _disposeEffect(_Effect effect) {
  for (var node = effect._sources; node != null; node = node._nextSource) {
    node._source._unsubscribe(node);
  }
  effect._compute = null;
  effect._sources = null;

  _cleanupEffect(effect);
}

void _endEffect(_Effect effect, _Listenable? prevContext) {
  if (_evalContext != effect) {
    throw Exception('Out-of-order effect');
  }
  _cleanupSources(effect);
  _evalContext = prevContext;

  effect._flags &= ~RUNNING;
  if ((effect._flags & DISPOSED) != 0) {
    _disposeEffect(effect);
  }
  _endBatch();
}

/// Clean up function to stop subscriptions from updating the callback
typedef EffectCleanup = void Function();

/// Function called when signals in the callback change
typedef EffectCallback = Function();

_Effect? _currentEffect;

class _Effect implements _Listenable {
  EffectCallback? _compute;

  @override
  final String? debugLabel;

  @override
  final int globalId;

  Function? _cleanup;

  @override
  _Node? _sources;

  _Effect? _nextBatchedEffect;

  @override
  int _flags;

  @override
  bool operator ==(Object other) {
    return other is _Effect && globalId == other.globalId;
  }

  @override
  int get hashCode {
    return globalId.hashCode;
  }

  _Effect(
    EffectCallback compute, {
    this.debugLabel,
  })  : _flags = TRACKING,
        _compute = compute,
        _cleanup = null,
        globalId = ++_lastGlobalId {
    _onEffectCreated(this);
  }

  List<ReadonlySignal> get _allSources {
    final results = <ReadonlySignal>[];
    _Node? root = _sources;
    for (var node = root; node != null; node = node._nextSource) {
      results.add(node._source);
    }
    return results;
  }

  void _callback() {
    final finish = _start();
    try {
      if ((_flags & DISPOSED) != 0) return;
      if (_compute == null) return;
      _currentEffect = this;
      final cleanup = _compute!();
      _currentEffect = null;
      if (cleanup is Function) {
        _cleanup = cleanup;
      }
    } finally {
      finish();
    }
    _onEffectCalled(this);
  }

  EffectCleanup _start() {
    if ((_flags & RUNNING) != 0) {
      _cycleDetected();
    }
    _flags |= RUNNING;
    _flags &= ~DISPOSED;
    _cleanupEffect(this);
    _prepareSources(this);

    _startBatch();
    final prevContext = _evalContext;
    _evalContext = this;
    return () => _endEffect(this, prevContext);
  }

  @override
  void _notify() {
    if (!((_flags & NOTIFIED) != 0)) {
      _flags |= NOTIFIED;
      _nextBatchedEffect = _batchedEffect;
      _batchedEffect = this;
    }
  }

  void _dispose() {
    _flags |= DISPOSED;
    if (!((_flags & RUNNING) != 0)) {
      _disposeEffect(this);
    }
  }
}

/// The `effect` function is the last piece that makes everything reactive.
/// When you access a signal inside its callback function, that signal and
/// every dependency of said signal will be activated and subscribed to.
/// In that regard it is very similar to `computed`. By
/// default all updates are lazy, so nothing will update until you access
/// a signal inside `effect`.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// effect(() => print(fullName.value));
///
/// // Updating one of its dependencies will automatically trigger
/// // the effect above, and will print "John Doe" to the console.
/// name.value = "John";
/// ```
///
/// You can destroy an effect and unsubscribe from all signals it was
/// subscribed to, by calling the returned function.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// final dispose = effect(() => print(fullName.value));
///
/// // Destroy effect and subscriptions
/// dispose();
///
/// // Update does nothing, because no one is subscribed anymore.
/// // Even the computed `fullName` signal won't change, because it knows
/// // that no one listens to it.
/// surname.value = "Doe 2";
/// ```
EffectCleanup effect(EffectCallback compute, {String? debugLabel}) {
  final effect = _Effect(compute, debugLabel: debugLabel);
  try {
    effect._callback();
  } catch (e) {
    effect._dispose();
    _onEffectRemoved(effect);
    rethrow;
  }
  // Return a bound function instead of a wrapper like `() => effect._dispose()`,
  // because bound functions seem to be just as fast and take up a lot less memory.
  return () {
    effect._dispose();
    _onEffectRemoved(effect);
  };
}
