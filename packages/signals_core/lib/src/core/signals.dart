// ignore_for_file: constant_identifier_names
import '../devtool.dart';
import '../utils/constants.dart';
import 'dart:developer' as developer;

part 'observer.dart';
part 'effect.dart';
part 'listenable.dart';
part 'computed.dart';
part 'signal.dart';
part 'batch.dart';
part 'untracked.dart';
part 'readonly.dart';

// A global version number for signals, used for fast-pathing repeated
// computed.peek()/computed.value calls when nothing has changed globally.
int globalVersion = 0;

// coverage:ignore-start
const _maxCallDepth = 100;

void _cycleDetected() {
  throw EffectCycleDetectionError();
}

void _mutationDetected() {
  throw MutationDetectedError();
}

/// Flags for Computed and Effect.
const _RUNNING = 1 << 0;
const _NOTIFIED = 1 << 1;
const _OUTDATED = 1 << 2;
const _DISPOSED = 1 << 3;
const _HAS_ERROR = 1 << 4;
const _TRACKING = 1 << 5;

// A linked list node used to track dependencies (sources) and dependents (targets).
// Also used to remember the source's last version number that the target saw.
class _Node {
  // A source whose value the target depends on.
  final ReadonlySignal _source;
  _Node? _prevSource;
  _Node? _nextSource;

  // A target that depends on the source and should be notified when the source changes.
  final SignalListenable _target;
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
    required SignalListenable target,
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

// Currently evaluated computed or effect.
SignalListenable? _evalContext;

// Effects collected into a batch.
Effect? _batchedEffect;
int _batchDepth = 0;
int _callDepth = 0;

int _lastGlobalId = 0;

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
    if ((_evalContext!._flags & _TRACKING) != 0) {
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

bool _needsToRecompute(SignalListenable target) {
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

void _prepareSources(SignalListenable target) {
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

void _cleanupSources(SignalListenable target) {
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

/// Signal usage error
class SignalsError extends Error {
  /// Signals error pretty print message
  final String message;

  /// Signal usage error
  SignalsError(this.message);

  @override
  String toString() => message;
}

/// Error to throw if a signal is read after it is disposed
class SignalsReadAfterDisposeError extends SignalsError {
  /// Error to throw if a signal is read after it is disposed
  SignalsReadAfterDisposeError(ReadonlySignal instance)
      : super(
          'A ${instance.runtimeType} signal was read after being disposed.\n'
          'Once you have called dispose() on a signal, it can no longer be used.',
        );
}

Effect? _currentEffect;

void _cleanupEffect(Effect effect) {
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
      effect._flags &= ~_RUNNING;
      effect._flags |= _DISPOSED;
      _disposeEffect(effect);
      rethrow;
    } finally {
      _evalContext = prevContext;
      _endBatch();
    }
  }
}

void _disposeEffect(Effect effect) {
  for (var node = effect._sources; node != null; node = node._nextSource) {
    node._source._unsubscribe(node);
  }
  effect._compute = null;
  effect._sources = null;

  _cleanupEffect(effect);
}

void _endEffect(Effect effect, SignalListenable? prevContext) {
  if (_evalContext != effect) {
    throw Exception('Out-of-order effect');
  }
  _cleanupSources(effect);
  _evalContext = prevContext;

  effect._flags &= ~_RUNNING;
  if ((effect._flags & _DISPOSED) != 0) {
    _disposeEffect(effect);
  }
  _endBatch();
}

// coverage:ignore-end

/// Error to throw if a signal is written to after it is disposed
class SignalsWriteAfterDisposeError extends SignalsError {
  /// Error to throw if a signal is written to after it is disposed
  SignalsWriteAfterDisposeError(ReadonlySignal instance)
      : super(
          'A ${instance.runtimeType} signal was written after being disposed.\n'
          'Once you have called dispose() on a signal, it can no longer be used.',
        );
}

/// Cycle detection usually means you have updated
/// a signal inside an effect and are reading by value.
class EffectCycleDetectionError extends Error {}

/// Mutation detection usually means you have updated
/// a signal inside a computed.
///
/// Computed cannot have side-effects
class MutationDetectedError extends Error {}
