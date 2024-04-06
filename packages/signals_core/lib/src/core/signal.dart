part of 'signals.dart';

/// Read only signals can just retrieve a value but not update or cause mutations
abstract class ReadonlySignal<T> {
  /// Throws and error if read after dispose and can be
  /// disposed on last unsubscribe.
  bool get autoDispose;

  /// Returns true if dispose has been called and will throw and
  /// error on value read
  bool get disposed;

  Iterable<_Listenable> get _allTargets;

  /// Debug label for Debug Mode
  String? get debugLabel;

  /// Global ID of the signal
  int get globalId;

  /// Compute the current value
  T get value;

  @override
  String toString();

  /// Convert value to JSON
  T toJson();

  /// Return the value when invoked
  T call();

  /// Get the current value
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

  /// Dispose the signal
  void dispose();

  /// Add a cleanup function to be called when the signal is disposed
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final effectCount = signal(0);
  ///
  /// final cleanup = counter.onDispose(() {
  ///  print('Counter has been disposed');
  /// });
  ///
  /// // Remove the cleanup function
  /// cleanup();
  /// ```
  EffectCleanup onDispose(void Function() cleanup);

  /// Value that the signal was created with
  T get initialValue;

  /// Previous value that was set before the current
  T? get previousValue;
}

/// {@template signal}
/// The `signal` function creates a new signal. A signal is a container for a value that can change over time. You can read a signal's value or subscribe to value updates by accessing its `.value` property.
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
/// Signals can be created globally, inside classes or functions. It's up to you how you want to structure your app.
///
/// It is not recommended to create signals inside effects or computed, as this will create a new signal every time the effect or computed is triggered. This can lead to unexpected behavior.
///
/// In Flutter do not create signals inside `build` methods, as this will create a new signal every time the widget is rebuilt.
///
/// ## Writing to a signal
///
/// Writing to a signal is done by setting its `.value` property. Changing a signal's value synchronously updates every [computed](/core/computed) and [effect](/core/effect) that depends on that signal, ensuring your app state is always consistent.
///
/// ## .peek()
///
/// In the rare instance that you have an effect that should write to another signal based on the previous value, but you _don't_ want the effect to be subscribed to that signal, you can read a signals's previous value via `signal.peek()`.
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
/// Note that you should only use `signal.peek()` if you really need it. Reading a signal's value via `signal.value` is the preferred way in most scenarios.
///
/// ## .value
///
/// The `.value` property of a signal is used to read or write to the signal. If used inside an effect or computed, it will subscribe to the signal and trigger the effect or computed whenever the signal's value changes.
///
/// ```dart
/// final counter = signal(0);
///
/// effect(() {
/// 	print(counter.value);
/// });
///
/// counter.value = 1;
/// ```
///
/// ## .previousValue
///
/// The `.previousValue` property of a signal is used to read the previous value of the signal. If used inside an effect or computed, it will not subscribe to the signal and not trigger the effect or computed whenever the signal's value changes.
///
/// ```dart
/// final counter = signal(0);
///
/// effect(() {
/// 	print('Current value: ${counter.value}');
/// 	print('Previous value: ${counter.previousValue}');
/// });
///
/// counter.value = 1;
/// ```
///
/// ## Force Update
///
/// If you want to force an update for a signal, you can call the `.set(..., force: true)` method. This will trigger all effects and mark all computed as dirty.
///
/// ```dart
/// final counter = signal(0);
/// counter.set(1, force: true);
/// ```
///
/// ## Disposing
///
/// ### Auto Dispose
///
/// If a signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.
///
/// ```dart
/// final s = signal(0, autoDispose: true);
/// s.onDispose(() => print('Signal destroyed'));
/// final dispose = s.subscribe((_) {});
/// dispose();
/// final value = s.value; // 0
/// // prints: Signal destroyed
/// ```
///
/// A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.
///
/// ```dart
/// final s = signal(0);
/// s.dispose();
/// final c = computed(() => s.value);
/// // c will not react to changes in s
/// ```
///
/// You can check if a signal is disposed by calling the `.disposed` method.
///
/// ```dart
/// final s = signal(0);
/// print(s.disposed); // false
/// s.dispose();
/// print(s.disposed); // true
/// ```
///
/// ### On Dispose Callback
///
/// You can attach a callback to a signal that will be called when the signal is destroyed.
///
/// ```dart
/// final s = signal(0);
/// s.onDispose(() => print('Signal destroyed'));
/// s.dispose();
/// ```
///
/// ## Flutter
///
/// In Flutter if you want to create a signal that automatically disposes itself when the widget is removed from the widget tree and rebuilds the widget when the signal changes, you can use the `createSignal` inside a stateful widget.
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:signals/signals_flutter.dart';
///
/// class CounterWidget extends StatefulWidget {
///   @override
///   _CounterWidgetState createState() => _CounterWidgetState();
/// }
///
/// class _CounterWidgetState extends State<CounterWidget> with SignalsAutoDisposeMixin {
///   late final counter = createSignal(this, 0);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Text('Counter: $counter'),
///             ElevatedButton(
///               onPressed: () => counter.value++,
///               child: Text('Increment'),
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// No `Watch` widget or extension is needed, the signal will automatically dispose itself when the widget is removed from the widget tree.
///
/// The `SignalsAutoDisposeMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.
///
/// ## Testing
///
/// Testing signals is possible by converting a signal to a stream and testing it like any other stream in Dart.
///
/// ```dart
/// test('test as stream', () {
///   final s = signal(0);
///   final stream = s.toStream(); // create a stream of values
///
///   s.value = 1;
///   s.value = 2;
///   s.value = 3;
///
///   expect(stream, emitsInOrder([0, 1, 2, 3]));
/// });
/// ```
///
/// `emitsInOrder` is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.
///
/// You can also override the initial value of a signal when testing. This is is useful for mocking and testing specific value implementations.
///
/// ```dart
/// test('test with override', () {
///   final s = signal(0).overrideWith(-1);
///
///   final stream = s.toStream();
///
///   s.value = 1;
///   s.value = 2;
///   s.value = 3;
///
///   expect(stream, emitsInOrder([-1, 1, 2, 3]));
/// });
/// ```
///
/// `overrideWith` returns a new signal with the same global id sets the value as if it was created with it. This can be useful when using async signals or global signals used for dependency injection.
/// @link https://dartsignals.dev/core/signal
/// {@endtemplate}
class Signal<T> implements ReadonlySignal<T> {
  late T _initialValue;
  T? _previousValue;

  @override
  T get initialValue => _initialValue;

  @override
  T? get previousValue => _previousValue;

  @override
  final int globalId;

  @override
  final String? debugLabel;

  @override
  final bool autoDispose;

  @override
  bool disposed = false;

  /// Core signal type
  Signal(
    T val, {
    this.debugLabel,
    this.autoDispose = false,
  })  : _version = 0,
        _value = val,
        globalId = ++_lastGlobalId {
    assert(() {
      SignalsObserver.instance?.onSignalCreated(this);
      return true;
    }());
    _initialValue = val;
  }

  /// Force update a value
  @Deprecated('Use .set(..., force: true) instead')
  void forceUpdate([T? val]) {
    this.set(val ?? value, force: true);
  }

  // @internal
  T _value;

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
  void _unsubscribe(_Node node) {
    __unsubscribe(this, node);
    if (autoDispose && _allTargets.isEmpty) {
      dispose();
    }
  }

  @override
  EffectCleanup subscribe(void Function(T value) fn) {
    return __signalSubscribe(this, fn);
  }

  @override
  Iterable<_Listenable> get _allTargets sync* {
    _Node? root = _targets;
    for (var node = root; node != null; node = node._nextTarget) {
      yield node._target;
    }
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

  /// Update the current value.
  ///
  /// `force` an update if needed (if the update would
  /// not pass the == check)
  void set(T value, {bool force = false}) {
    _set(value, force);
  }

  /// Set the current value
  set value(T val) {
    if (disposed) {
      throw SignalsWriteAfterDisposeError(this);
    }
    set(val);
  }

  @override
  T get value {
    if (disposed) {
      if (kDebugMode) {
        print(
            'signal warning: [$globalId|$debugLabel] has been read after disposed: ${StackTrace.current}');
      }
      return this._value;
    }

    final node = _addDependency(this);
    if (node != null) {
      node._version = this._version;
    }
    return this._value;
  }

  void _set(T val, bool force) {
    if (_evalContext is Computed) {
      _mutationDetected();
    }

    if (val != _value || force) {
      _updateValue(val);
    }
  }

  void _updateValue(T val) {
    if (_callDepth > _maxCallDepth) {
      _cycleDetected();
    }
    _previousValue = _value ?? _initialValue;
    _value = val;
    _version++;
    globalVersion++;

    _startBatch();
    try {
      for (var node = _targets; node != null; node = node._nextTarget) {
        node._target._notify();
      }
    } finally {
      _endBatch();
    }

    assert(() {
      SignalsObserver.instance?.onSignalUpdated(this, val);
      return true;
    }());
  }

  @override
  _Node? _node;

  @override
  _Node? _targets;

  final _disposeCallbacks = <void Function()>{};

  @override
  EffectCleanup onDispose(void Function() cleanup) {
    _disposeCallbacks.add(cleanup);

    return () {
      _disposeCallbacks.remove(cleanup);
    };
  }

  @override
  void dispose() {
    if (disposed) return;
    for (final cleanup in _disposeCallbacks) {
      cleanup();
    }
    disposed = true;
  }

  void _reset(T? value) {
    if (value != null) {
      _value = value;
      _initialValue = value;
      _previousValue = null;
    }
    _version = 0;
  }

  /// Returns a readonly signal
  ReadonlySignal<T> readonly() => this;

  /// Override the current signal with a new value as if it was created with it
  ///
  /// This does not trigger any updates
  ///
  /// ```dart
  /// var counter = signal(0);
  ///
  /// // Override the signal with a new value
  /// counter = counter.overrideWith(1);
  /// ```
  Signal<T> overrideWith(T value) {
    this._reset(value);
    return this;
  }
}

// /// A signal that tracks the previous value
// class _Signal<T> extends _SignalBase<T> implements TrackedReadonlySignal<T> {
//   /// Create a signal that tracks the previous value
//   _Signal(
//     super.val, {
//     super.debugLabel,
//     super.equality,
//     super.autoDispose,
//   }) : _initialValue = val;

//   T _initialValue;
//   T? _previousValue;

//   @override
//   void _updateValue(T val) {
//     _previousValue = _value;
//     super._updateValue(val);
//   }

//   /// Get the value the signal was created with
//   @override
//   T get initialValue => _initialValue;

//   /// Get the previous value if present
//   @override
//   T? get previousValue => _previousValue;

//   @override
//   void _reset(T? value) {
//     _previousValue = value ?? _initialValue;
//     _initialValue = value ?? _initialValue;
//     super._reset(value);
//   }
// }

/// {@template signal}
/// The `signal` function creates a new signal. A signal is a container for a value that can change over time. You can read a signal's value or subscribe to value updates by accessing its `.value` property.
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
/// Signals can be created globally, inside classes or functions. It's up to you how you want to structure your app.
///
/// It is not recommended to create signals inside effects or computed, as this will create a new signal every time the effect or computed is triggered. This can lead to unexpected behavior.
///
/// In Flutter do not create signals inside `build` methods, as this will create a new signal every time the widget is rebuilt.
///
/// ## Writing to a signal
///
/// Writing to a signal is done by setting its `.value` property. Changing a signal's value synchronously updates every [computed](/core/computed) and [effect](/core/effect) that depends on that signal, ensuring your app state is always consistent.
///
/// ## .peek()
///
/// In the rare instance that you have an effect that should write to another signal based on the previous value, but you _don't_ want the effect to be subscribed to that signal, you can read a signals's previous value via `signal.peek()`.
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
/// Note that you should only use `signal.peek()` if you really need it. Reading a signal's value via `signal.value` is the preferred way in most scenarios.
///
/// ## .value
///
/// The `.value` property of a signal is used to read or write to the signal. If used inside an effect or computed, it will subscribe to the signal and trigger the effect or computed whenever the signal's value changes.
///
/// ```dart
/// final counter = signal(0);
///
/// effect(() {
/// 	print(counter.value);
/// });
///
/// counter.value = 1;
/// ```
///
/// ## .previousValue
///
/// The `.previousValue` property of a signal is used to read the previous value of the signal. If used inside an effect or computed, it will not subscribe to the signal and not trigger the effect or computed whenever the signal's value changes.
///
/// ```dart
/// final counter = signal(0);
///
/// effect(() {
/// 	print('Current value: ${counter.value}');
/// 	print('Previous value: ${counter.previousValue}');
/// });
///
/// counter.value = 1;
/// ```
///
/// ## Force Update
///
/// If you want to force an update for a signal, you can call the `.set(..., force: true)` method. This will trigger all effects and mark all computed as dirty.
///
/// ```dart
/// final counter = signal(0);
/// counter.set(1, force: true);
/// ```
///
/// ## Disposing
///
/// ### Auto Dispose
///
/// If a signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.
///
/// ```dart
/// final s = signal(0, autoDispose: true);
/// s.onDispose(() => print('Signal destroyed'));
/// final dispose = s.subscribe((_) {});
/// dispose();
/// final value = s.value; // 0
/// // prints: Signal destroyed
/// ```
///
/// A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.
///
/// ```dart
/// final s = signal(0);
/// s.dispose();
/// final c = computed(() => s.value);
/// // c will not react to changes in s
/// ```
///
/// You can check if a signal is disposed by calling the `.disposed` method.
///
/// ```dart
/// final s = signal(0);
/// print(s.disposed); // false
/// s.dispose();
/// print(s.disposed); // true
/// ```
///
/// ### On Dispose Callback
///
/// You can attach a callback to a signal that will be called when the signal is destroyed.
///
/// ```dart
/// final s = signal(0);
/// s.onDispose(() => print('Signal destroyed'));
/// s.dispose();
/// ```
///
/// ## Flutter
///
/// In Flutter if you want to create a signal that automatically disposes itself when the widget is removed from the widget tree and rebuilds the widget when the signal changes, you can use the `createSignal` inside a stateful widget.
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:signals/signals_flutter.dart';
///
/// class CounterWidget extends StatefulWidget {
///   @override
///   _CounterWidgetState createState() => _CounterWidgetState();
/// }
///
/// class _CounterWidgetState extends State<CounterWidget> with SignalsAutoDisposeMixin {
///   late final counter = createSignal(this, 0);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Text('Counter: $counter'),
///             ElevatedButton(
///               onPressed: () => counter.value++,
///               child: Text('Increment'),
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// No `Watch` widget or extension is needed, the signal will automatically dispose itself when the widget is removed from the widget tree.
///
/// The `SignalsAutoDisposeMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.
///
/// ## Testing
///
/// Testing signals is possible by converting a signal to a stream and testing it like any other stream in Dart.
///
/// ```dart
/// test('test as stream', () {
///   final s = signal(0);
///   final stream = s.toStream(); // create a stream of values
///
///   s.value = 1;
///   s.value = 2;
///   s.value = 3;
///
///   expect(stream, emitsInOrder([0, 1, 2, 3]));
/// });
/// ```
///
/// `emitsInOrder` is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.
///
/// You can also override the initial value of a signal when testing. This is is useful for mocking and testing specific value implementations.
///
/// ```dart
/// test('test with override', () {
///   final s = signal(0).overrideWith(-1);
///
///   final stream = s.toStream();
///
///   s.value = 1;
///   s.value = 2;
///   s.value = 3;
///
///   expect(stream, emitsInOrder([-1, 1, 2, 3]));
/// });
/// ```
///
/// `overrideWith` returns a new signal with the same global id sets the value as if it was created with it. This can be useful when using async signals or global signals used for dependency injection.
/// @link https://dartsignals.dev/core/signal
/// {@endtemplate}
Signal<T> signal<T>(
  T value, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return Signal<T>(
    value,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

/// Alias for Signal
@Deprecated('Use Signal<T> instead')
typedef ValueSignal<T> = Signal<T>;

/// Wrapper signal for a reference to an object
@Deprecated('Use Signal<T> instead')
ValueSignal<T> valueSignal<T>(
  T value, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return ValueSignal<T>(
    value,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
