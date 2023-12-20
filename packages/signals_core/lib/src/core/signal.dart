part of 'signals.dart';

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

  /// Get the value the signal was created with
  T get initialValue;

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

  void dispose();

  void onDispose(SignalCleanup cleanup);
}

/// Cleanup function for signal dispose
typedef SignalCleanup = void Function();

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

class _Signal<T> implements Signal<T> {
  @override
  final int globalId;

  @override
  final String? debugLabel;

  _Signal(this._value, {this.debugLabel})
      : _version = 0,
        _previousValue = _value,
        _initialValue = _value,
        brand = identifier,
        globalId = ++_lastGlobalId {
    _onSignalCreated(this);
  }

  // @internal
  T _value;
  T _previousValue;
  final T _initialValue;

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
  T get initialValue => this._initialValue;

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
    if (_callDepth > _maxCallDepth) {
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

  final _disposeCallbacks = <SignalCleanup>{};

  @override
  void onDispose(SignalCleanup cleanup) {
    _disposeCallbacks.add(cleanup);
  }

  @override
  void dispose() {
    for (final cleanup in _disposeCallbacks) {
      cleanup();
    }
    _disposeCallbacks.clear();
    if (_node != null) _unsubscribe(_node!);
    _value = _initialValue;
    _previousValue = _initialValue;
  }
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

/// Create a read only signal
ReadonlySignal<T> readonlySignal<T>(T value, {String? debugLabel}) {
  return _Signal<T>(
    value,
    debugLabel: debugLabel,
  );
}
