part of 'signals.dart';

/// Instance of a new plain signal
class Signal<T> extends ReadonlySignal<T> {
  @override
  final int globalId;

  @internal
  late T internalValue;

  Signal(this.internalValue)
      : version = 0,
        globalId = ++lastGlobalId;

  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  @override
  int version;

  @override
  bool refresh() {
    return true;
  }

  @override
  void subscribeToNode(Node node) {
    ReadonlySignal.__subscribe(this, node);
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
  void set(
    T val, {
    /// Skip equality check and update the value
    bool force = false,
  }) {
    if (force || val != this.internalValue) {
      setValue(val);
    }
  }

  @internal
  void setValue(T val) {
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
