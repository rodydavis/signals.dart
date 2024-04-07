part of 'signals.dart';

/// {@template computed}
/// Data is often derived from other pieces of existing data. The `computed` function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.
///
/// > `Computed` class extends the [`Signal`](/core/signal/) class, so you can use it anywhere you would use a signal.
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
/// Any signal that is accessed inside the `computed`'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.
///
/// > Computed signals are both lazily evaluated and memoized
///
/// ## Force Re-evaluation
///
/// You can force a computed signal to re-evaluate by calling its `.recompute` method. This will re-run the computed callback and update the computed signal's value.
///
/// ```dart
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// fullName.recompute(); // Re-runs the computed callback
/// ```
///
/// ## Disposing
///
/// ### Auto Dispose
///
/// If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.
///
/// ```dart
/// final s = computed(() => 0, autoDispose: true);
/// s.onDispose(() => print('Signal destroyed'));
/// final dispose = s.subscribe((_) {});
/// dispose();
/// final value = s.value; // 0
/// // prints: Signal destroyed
/// ```
///
/// A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.
///
/// This means that it will no longer react to changes in its dependencies.
///
/// ```dart
/// final s = computed(() => 0);
/// s.dispose();
/// final value = s.value; // 0
/// final b = computed(() => s.value); // 0
/// // b will not react to changes in s
/// ```
///
/// You can check if a signal is disposed by calling the `.disposed` method.
///
/// ```dart
/// final s = computed(() => 0);
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
/// final s = computed(() => 0);
/// s.onDispose(() => print('Signal destroyed'));
/// s.dispose();
/// ```
///
///
/// ## Flutter
///
/// In Flutter if you want to create a signal that automatically disposes itself when the widget is removed from the widget tree and rebuilds the widget when the signal changes, you can use the `createComputed` inside a stateful widget.
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
///   late final isEven = createComputed(this, () => counter.value.isEven);
///   late final isOdd = createComputed(this, () => counter.value.isOdd);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Text('Counter: even=$isEven, odd=$isOdd'),
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
/// Testing computed signals is possible by converting a computed to a stream and testing it like any other stream in Dart.
///
/// ```dart
/// test('test as stream', () {
///     final a = signal(0);
///     final s = computed(() => a());
///     final stream = s.toStream();
///
///     a.value = 1;
///     a.value = 2;
///     a.value = 3;
///
///     expect(stream, emitsInOrder([0, 1, 2, 3]));
/// });
/// ```
///
/// `emitsInOrder` is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.
///
/// You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.
///
/// ```dart
/// test('test with override', () {
///     final a = signal(0);
///     final s = computed(() => a()).overrideWith(-1);
///
///     final stream = s.toStream();
///
///     a.value = 1;
///     a.value = 2;
///     a.value = 2; // check if skipped
///     a.value = 3;
///
///     expect(stream, emitsInOrder([-1, 1, 2, 3]));
/// });
/// ```
///
/// `overrideWith` returns a new computed signal with the same global id sets the value as if the computed callback returned it.
/// @link https://dartsignals.dev/core/computed
/// {@endtemplate}
class Computed<T> extends ReadonlySignal<T> implements _Listenable {
  /// {@template computed}
  /// Data is often derived from other pieces of existing data. The `computed` function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.
  ///
  /// > `Computed` class extends the [`Signal`](/core/signal/) class, so you can use it anywhere you would use a signal.
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
  /// Any signal that is accessed inside the `computed`'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.
  ///
  /// > Computed signals are both lazily evaluated and memoized
  ///
  /// ## Force Re-evaluation
  ///
  /// You can force a computed signal to re-evaluate by calling its `.recompute` method. This will re-run the computed callback and update the computed signal's value.
  ///
  /// ```dart
  /// final name = signal("Jane");
  /// final surname = signal("Doe");
  /// final fullName = computed(() => name.value + " " + surname.value);
  ///
  /// fullName.recompute(); // Re-runs the computed callback
  /// ```
  ///
  /// ## Disposing
  ///
  /// ### Auto Dispose
  ///
  /// If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.
  ///
  /// ```dart
  /// final s = computed(() => 0, autoDispose: true);
  /// s.onDispose(() => print('Signal destroyed'));
  /// final dispose = s.subscribe((_) {});
  /// dispose();
  /// final value = s.value; // 0
  /// // prints: Signal destroyed
  /// ```
  ///
  /// A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.
  ///
  /// This means that it will no longer react to changes in its dependencies.
  ///
  /// ```dart
  /// final s = computed(() => 0);
  /// s.dispose();
  /// final value = s.value; // 0
  /// final b = computed(() => s.value); // 0
  /// // b will not react to changes in s
  /// ```
  ///
  /// You can check if a signal is disposed by calling the `.disposed` method.
  ///
  /// ```dart
  /// final s = computed(() => 0);
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
  /// final s = computed(() => 0);
  /// s.onDispose(() => print('Signal destroyed'));
  /// s.dispose();
  /// ```
  ///
  ///
  /// ## Flutter
  ///
  /// In Flutter if you want to create a signal that automatically disposes itself when the widget is removed from the widget tree and rebuilds the widget when the signal changes, you can use the `createComputed` inside a stateful widget.
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
  ///   late final isEven = createComputed(this, () => counter.value.isEven);
  ///   late final isOdd = createComputed(this, () => counter.value.isOdd);
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       body: Center(
  ///         child: Column(
  ///           mainAxisAlignment: MainAxisAlignment.center,
  ///           children: [
  ///             Text('Counter: even=$isEven, odd=$isOdd'),
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
  /// Testing computed signals is possible by converting a computed to a stream and testing it like any other stream in Dart.
  ///
  /// ```dart
  /// test('test as stream', () {
  ///     final a = signal(0);
  ///     final s = computed(() => a());
  ///     final stream = s.toStream();
  ///
  ///     a.value = 1;
  ///     a.value = 2;
  ///     a.value = 3;
  ///
  ///     expect(stream, emitsInOrder([0, 1, 2, 3]));
  /// });
  /// ```
  ///
  /// `emitsInOrder` is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.
  ///
  /// You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.
  ///
  /// ```dart
  /// test('test with override', () {
  ///     final a = signal(0);
  ///     final s = computed(() => a()).overrideWith(-1);
  ///
  ///     final stream = s.toStream();
  ///
  ///     a.value = 1;
  ///     a.value = 2;
  ///     a.value = 2; // check if skipped
  ///     a.value = 3;
  ///
  ///     expect(stream, emitsInOrder([-1, 1, 2, 3]));
  /// });
  /// ```
  ///
  /// `overrideWith` returns a new computed signal with the same global id sets the value as if the computed callback returned it.
  /// @link https://dartsignals.dev/core/computed
  /// {@endtemplate}
  Computed(
    ComputedCallback<T> compute, {
    super.debugLabel,
    super.autoDispose,
  })  : _compute = compute,
        _globalVersion = globalVersion - 1,
        _flags = OUTDATED,
        super._(globalId: ++_lastGlobalId) {
    assert(() {
      SignalsObserver.instance?.onComputedCreated(this);
      return true;
    }());
  }

  final ComputedCallback<T> _compute;

  @override
  _Node? _sources;

  int _globalVersion;

  @override
  int _flags;

  Object? _error;

  late T _value;

  Iterable<ReadonlySignal> get _allSources sync* {
    for (var node = _sources; node != null; node = node._nextSource) {
      yield node._source;
    }
  }

  /// Override the current signal with a new value as if it was created with it
  ///
  /// This does not trigger any updates
  ///
  /// ```dart
  /// var counter = computed(() => 0);
  ///
  /// // Override the signal with a new value
  /// counter = counter.overrideWith(1);
  /// ```
  Computed<T> overrideWith(T value) {
    this._reset(value);
    return this;
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
    final needsUpdate = _needsToRecompute(this);
    if (_version > 0 && !needsUpdate) {
      this._flags &= ~RUNNING;
      return true;
    }

    final prevContext = _evalContext;
    try {
      _prepareSources(this);
      _evalContext = this;
      final val = _compute();
      if ((this._flags & HAS_ERROR) != 0 || needsUpdate || _version == 0) {
        if (_version == 0 || val != _value) {
          if (_version == 0) {
            _initialValue = val;
          } else {
            _previousValue = _value;
          }
          _value = val;
          _flags &= ~HAS_ERROR;
          _version++;
          assert(() {
            SignalsObserver.instance?.onComputedUpdated(this, val);
            return true;
          }());
        }
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
    super._subscribe(node);
  }

  @override
  void _unsubscribe(_Node node) {
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
    if (autoDispose && _allTargets.isEmpty) {
      dispose();
    }
  }

  /// Call the computed function and update the value
  void recompute() {
    value;
    _previousValue = _value;
    _value = _compute();
  }

  @override
  void _notify() {
    if (!((_flags & NOTIFIED) != 0)) {
      _flags |= OUTDATED | NOTIFIED;
      _notifyAllTargets();
    }
  }

  @override
  T peek() {
    if (!_refresh()) {
      _cycleDetected();
    }
    if ((_flags & HAS_ERROR) != 0) {
      throw _error!;
    }
    return _value;
  }

  @override
  T get value {
    if (disposed) {
      print(
          'computed warning: [$globalId|$debugLabel] has been read after disposed: ${StackTrace.current}');
      return this._value;
    }

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
    return this._value;
  }

  @override
  void dispose() {
    super.dispose();
    _flags |= DISPOSED;
  }

  void _reset(T? value) {
    _refresh();
    if (value != null) {
      _value = value;
      _initialValue = value;
      _previousValue = null;
    }
  }

  @override
  T get initialValue => _initialValue;
  late T _initialValue;

  /// Returns a readonly signal
  ReadonlySignal<T> readonly() => this;
}

/// A callback that is executed inside a computed.
typedef ComputedCallback<T> = T Function();

/// {@template computed}
/// Data is often derived from other pieces of existing data. The `computed` function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.
///
/// > `Computed` class extends the [`Signal`](/core/signal/) class, so you can use it anywhere you would use a signal.
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
/// Any signal that is accessed inside the `computed`'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.
///
/// > Computed signals are both lazily evaluated and memoized
///
/// ## Force Re-evaluation
///
/// You can force a computed signal to re-evaluate by calling its `.recompute` method. This will re-run the computed callback and update the computed signal's value.
///
/// ```dart
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// fullName.recompute(); // Re-runs the computed callback
/// ```
///
/// ## Disposing
///
/// ### Auto Dispose
///
/// If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.
///
/// ```dart
/// final s = computed(() => 0, autoDispose: true);
/// s.onDispose(() => print('Signal destroyed'));
/// final dispose = s.subscribe((_) {});
/// dispose();
/// final value = s.value; // 0
/// // prints: Signal destroyed
/// ```
///
/// A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.
///
/// This means that it will no longer react to changes in its dependencies.
///
/// ```dart
/// final s = computed(() => 0);
/// s.dispose();
/// final value = s.value; // 0
/// final b = computed(() => s.value); // 0
/// // b will not react to changes in s
/// ```
///
/// You can check if a signal is disposed by calling the `.disposed` method.
///
/// ```dart
/// final s = computed(() => 0);
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
/// final s = computed(() => 0);
/// s.onDispose(() => print('Signal destroyed'));
/// s.dispose();
/// ```
///
///
/// ## Flutter
///
/// In Flutter if you want to create a signal that automatically disposes itself when the widget is removed from the widget tree and rebuilds the widget when the signal changes, you can use the `createComputed` inside a stateful widget.
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
///   late final isEven = createComputed(this, () => counter.value.isEven);
///   late final isOdd = createComputed(this, () => counter.value.isOdd);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Text('Counter: even=$isEven, odd=$isOdd'),
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
/// Testing computed signals is possible by converting a computed to a stream and testing it like any other stream in Dart.
///
/// ```dart
/// test('test as stream', () {
///     final a = signal(0);
///     final s = computed(() => a());
///     final stream = s.toStream();
///
///     a.value = 1;
///     a.value = 2;
///     a.value = 3;
///
///     expect(stream, emitsInOrder([0, 1, 2, 3]));
/// });
/// ```
///
/// `emitsInOrder` is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.
///
/// You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.
///
/// ```dart
/// test('test with override', () {
///     final a = signal(0);
///     final s = computed(() => a()).overrideWith(-1);
///
///     final stream = s.toStream();
///
///     a.value = 1;
///     a.value = 2;
///     a.value = 2; // check if skipped
///     a.value = 3;
///
///     expect(stream, emitsInOrder([-1, 1, 2, 3]));
/// });
/// ```
///
/// `overrideWith` returns a new computed signal with the same global id sets the value as if the computed callback returned it.
/// @link https://dartsignals.dev/core/computed
/// {@endtemplate}
Computed<T> computed<T>(
  ComputedCallback<T> compute, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return Computed<T>(
    compute,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
