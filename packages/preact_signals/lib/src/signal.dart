import 'package:meta/meta.dart';

import 'batch.dart';
import 'globals.dart';
import 'node.dart';
import 'readonly.dart';

/// Instance of a new plain signal
class Signal<T> extends ReadonlySignal<T> {
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

  Signal(this._internalValue)
      : version = 0,
        globalId = ++lastGlobalId,
        _isInitialized = true;

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
    ReadonlySignal.internalSubscribe(this, node);
  }

  @override
  void unsubscribeFromNode(Node node) {
    signalUnsubscribe(this, node);
  }

  @override
  void Function() subscribe(void Function(T value) fn) {
    return signalSubscribe(this, fn);
  }

  @override
  T get value {
    final node = addDependency(this);
    if (node != null) {
      node.version = this.version;
    }
    return this.internalValue;
  }

  /// Set the current value by a setter
  set value(T val) => set(val);

  /// Set the current value by a method
  bool set(
    T val, {
    /// Skip equality check and update the value
    bool force = false,
  }) {
    if (force || !isInitialized || val != this.internalValue) {
      internalSetValue(val);
      return true;
    }
    return false;
  }

  @internal
  void internalSetValue(T val) {
    if (batchIteration > 100) {
      throw Exception('Cycle detected');
    }

    this.internalValue = val;
    this.version++;
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
