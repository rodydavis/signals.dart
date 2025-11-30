import 'package:meta/meta.dart';

import 'batch.dart';
import 'globals.dart';
import 'node.dart';
import 'options.dart';
import 'readonly.dart';

/// Instance of a new plain signal
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

  /// Signal name
  final String? name;
  final void Function()? _watched;
  final void Function()? _unwatched;

  @override
  /// Callback when the signal is watched
  void Function()? get watched => _watched;

  @override
  /// Callback when the signal is unwatched
  void Function()? get unwatched => _unwatched;

  /// Create a new signal
  Signal(
    this._internalValue, {
    SignalOptions<T>? options,
  })  : version = 0,
        globalId = ++lastGlobalId,
        _isInitialized = true,
        _watched = options?.watched,
        _unwatched = options?.unwatched,
        name = options?.name {
    afterCreate(_internalValue);
  }

  /// Create a new lazy signal
  Signal.lazy({
    SignalOptions<T>? options,
  })  : version = 0,
        globalId = ++lastGlobalId,
        _isInitialized = false,
        _watched = options?.watched,
        _unwatched = options?.unwatched,
        name = options?.name;

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
  set value(T val) => set(val);

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

  @internal

  /// Set the internal value and notify listeners
  void internalSetValue(T val) {
    if (batchIteration > 100) {
      throw Exception('Cycle detected');
    }

    beforeUpdate(val);
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
  T value, {
  SignalOptions<T>? options,
}) {
  return Signal<T>(
    value,
    options: options,
  );
}
