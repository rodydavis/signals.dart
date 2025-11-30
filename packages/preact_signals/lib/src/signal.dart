import 'package:meta/meta.dart';

import 'batch.dart';
import 'globals.dart';
import 'node.dart';
import 'readonly.dart';

/// Instance of a new plain signal
/// A signal that can be mutated.
class Signal<T> with ReadonlySignal<T> {
  @override
  final int globalId;

  /// Check if the value is set and not a lazy signal
  bool get isInitialized => _isInitialized;
  bool _isInitialized;

  @internal
  set isInitialized(bool val) {
    _isInitialized = val;
  }

  late T _internalValue;

  @override
  T get internalValue => _internalValue;

  @internal
  set internalValue(T value) {
    _internalValue = value;
    _isInitialized = true;
  }

  /// Create a new signal with the given value.
  Signal(this._internalValue)
      : version = 0,
        globalId = ++lastGlobalId,
        _isInitialized = true;

  /// Create a new lazy signal.
  Signal.lazy()
      : version = 0,
        globalId = ++lastGlobalId,
        _isInitialized = false;

  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  @override
  int version;

  @override
  bool internalRefresh() {
    return true;
  }

  @override
  void subscribeToNode(Node node) {
    internalSubscribe(node);
  }

  @override
  void unsubscribeFromNode(Node node) {
    signalUnsubscribe(node);
  }

  @override
  void Function() subscribe(void Function(T value) fn) {
    return signalSubscribe(fn);
  }

  @override
  T get value {
    final node = addDependency();
    if (node != null) {
      node.version = version;
    }
    return internalValue;
  }

  /// Set the current value by a setter
  /// Set the value of the signal.
  set value(T value) => set(value);

  /// Set the current value by a method
  bool set(
    T val, {
    /// Skip equality check and update the value
    bool force = false,
  }) {
    if (force || !isInitialized || val != internalValue) {
      internalSetValue(val);
      return true;
    }
    return false;
  }

  /// Set the value of the signal internally
  @internal
  void internalSetValue(T val) {
    if (batchIteration > 100) {
      throw Exception('Cycle detected');
    }

    internalValue = val;
    version++;
    globalVersion++;

    startBatch();
    try {
      for (var node = targets; node != null; node = node.nextTarget) {
        node.target.notify();
      }
    } finally {
      endBatch();
    }
  }
}

/// Create a new plain signal
Signal<T> signal<T>(
  /// The initial value for the signal
  T value,
) {
  return Signal<T>(value);
}
