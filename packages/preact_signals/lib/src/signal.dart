part of 'signals.dart';

class Signal<T> extends ReadonlySignal<T> {
  @override
  final int globalId;

  Signal(this._value)
      : version = 0,
        globalId = ++_lastGlobalId;

  // @internal
  T _value;

  /// @internal
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
    return this._value;
  }

  set value(T val) {
    if (val != this._value) {
      _updateValue(val);
    }
  }

  void forceUpdate(T val) {
    _updateValue(val);
  }

  void _updateValue(T val) {
    if (batchIteration > 100) {
      throw Exception('Cycle detected');
    }

    this._value = val;
    this.version++;
    globalVersion++;

    startBatch();
    try {
      for (var node = targets; node != null; node = node.nextTarget) {
        node.target._notify();
      }
    } finally {
      endBatch();
    }
  }
}

/// Create a new plain signal.
///
/// @param value The initial value for the signal.
/// @returns A new signal.
Signal<T> signal<T>(T value) {
  return Signal<T>(value);
}
