import 'dart:async';
import 'dart:collection';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../signals_core.dart';
import '../core/options.dart';
import '../core/signal.dart' show FlutterSignal;
import '../core/computed.dart' show FlutterComputed;

typedef _SignalMetadata = ({
  bool? local,
  ReadonlySignal<dynamic> target,
  ({Function cb, EffectCleanup cleanup})? listener,
});

/// Signals mixin that will automatically rebuild the widget tree when any of
/// the signals change and dispose of any signals and effects created locally.
///
/// ```dart
/// class MyWidget extends StatefulWidget {
///  ...
/// }
///
/// class _MyWidget extends State<MyWidget> with SignalsMixin {
///   late var _signal = this.createSignal(0);
///   late var _computed = this.createComputed(() => _signal() * 2);
///
///   @override
///   void initState() {
///     super.initState();
///     this.createEffect(() {
///       print('count: $_signal, double: $_computed');
///     });
///   }
///   ...
/// }
/// ```
mixin SignalsMixin<T extends StatefulWidget> on State<T> {
  final _signals = HashMap.of(<int, _SignalMetadata>{});
  EffectCleanup? _cleanup;
  final _effects = <EffectCleanup>[];

  /// Dispose and remove signal
  void disposeSignal(int id) {
    final s = _signals.remove(id);
    if (s == null) return;
    s.target.dispose();
    s.listener?.cleanup();
  }

  Future<void> _rebuild() async {
    if (!mounted) return;

    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return;
    }

    setState(() {});
    return;
  }

  void _setup() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cb = effect(() {
        for (final s in _signals.values.where((e) => e.local != null)) {
          s.target.value;
        }
        _rebuild();
      });
      _cleanup?.call();
      _cleanup = cb;
    });
  }

  void _watch(ReadonlySignal<dynamic> target, bool local) {
    if (_signals[target.globalId]?.local != null) {
      return;
    }
    final listener = _signals[target.globalId]?.listener;
    _signals[target.globalId] = (
      local: local,
      target: target,
      listener: listener,
    );
    _setup();
  }

  void _unwatch(ReadonlySignal<dynamic> target) {
    if (!_signals.containsKey(target.globalId)) return;
    final listener = _signals[target.globalId]?.listener;
    _signals[target.globalId] = (
      local: null,
      target: target,
      listener: listener,
    );
    _setup();
  }

  /// Async Computed is syntax sugar around [FutureSignal].
  ///
  /// _Inspired by [computedFrom](https://ngxtension.netlify.app/utilities/signals/computed-from/) from Angular NgExtension._
  ///
  /// computedFrom takes a list of [signals] and a [callback] function to
  /// compute the value of the signal every time one of the [signals] changes.
  ///
  /// ```dart
  /// final movieId = signal('id');
  /// late final movie = computedFrom(args, ([movieId]) => fetchMovie(args.first));
  /// ```
  ///
  /// Since all dependencies are passed in as arguments there is no need to worry about calling the signals before any async gaps with await.
  /// Async Computed is syntax sugar around [FutureSignal].
  ///
  /// _Inspired by [computedFrom](https://ngxtension.netlify.app/utilities/signals/computed-from/) from Angular NgExtension._
  ///
  /// computedFrom takes a list of [signals] and a [callback] function to
  /// compute the value of the signal every time one of the [signals] changes.
  ///
  /// ```dart
  /// final movieId = signal('id');
  /// late final movie = computedFrom(args, ([movieId]) => fetchMovie(args.first));
  /// ```
  ///
  /// Since all dependencies are passed in as arguments there is no need to worry about calling the signals before any async gaps with await.
  /// Async Computed is syntax sugar around [FutureSignal].
  ///
  /// _Inspired by [computedFrom](https://ngxtension.netlify.app/utilities/signals/computed-from/) from Angular NgExtension._
  ///
  /// computedFrom takes a list of [signals] and a [callback] function to
  /// compute the value of the signal every time one of the [signals] changes.
  ///
  /// ```dart
  /// final movieId = signal('id');
  /// late final movie = computedFrom(args, ([movieId]) => fetchMovie(args.first));
  /// ```
  ///
  /// Since all dependencies are passed in as arguments there is no need to worry about calling the signals before any async gaps with await.
  FutureSignal<S> createComputedFrom<S, A>(
    List<ReadonlySignal<A>> signals,
    Future<S> Function(List<A> args) fn, {
    StreamSignalOptions<S>? options,
  }) {
    return _bindLocal(
      computedFrom<S, A>(
        signals,
        fn,
        options: options,
      ),
    );
  }

  /// Async Computed is syntax sugar around [FutureSignal].
  ///
  /// _Inspired by [computedAsync](https://ngxtension.netlify.app/utilities/signals/computed-async/) from Angular NgExtension._
  ///
  /// computedAsync takes a [callback] function to compute the value
  /// of the signal. This callback is converted into a [Computed] signal.
  ///
  /// ```dart
  /// final movieId = signal('id');
  /// late final movie = computedAsync(() => fetchMovie(movieId()));
  /// ```
  ///
  /// **It is important that signals are called before any async gaps with await.**
  ///
  /// Any signal that is read inside the callback will be tracked as a dependency and the computed signal will be re-evaluated when any of the dependencies change.
  FutureSignal<S> createComputedAsync<S>(
    Future<S> Function() fn, {
    StreamSignalOptions<S>? options,
  }) {
    return _bindLocal(
      computedAsync<S>(
        fn,
        options: options,
      ),
    );
  }

  /// Create a signal from a future
  FutureSignal<S> createFutureSignal<S>(
    Future<S> Function() fn, {
    StreamSignalOptions<S>? options,
  }) {
    return _bindLocal(
      futureSignal<S>(
        fn,
        options: options,
      ),
    );
  }

  /// Create a signals from a stream
  StreamSignal<S> createStreamSignal<S>(
    Stream<S> Function() callback, {
    StreamSignalOptions<S>? options,
  }) {
    return _bindLocal(
      streamSignal<S>(
        callback,
        options: options,
      ),
    );
  }

  /// Create a signal holding an async value
  AsyncSignal<S> createAsyncSignal<S>(
    AsyncState<S> value, {
    SignalOptions<AsyncState<S>>? options,
  }) {
    return _bindLocal(
      asyncSignal<S>(
        value,
        options: options,
      ),
    );
  }

  /// Create a signal<T> and watch for changes
  FlutterSignal<V> createSignal<V>(
    V val, {
    FlutterSignalOptions<V>? options,
  }) {
    return _bindLocal(
      signal<V>(
        val,
        options: options,
      ),
    );
  }

  /// Create a [ListSignal]<T> and watch for changes
  ListSignal<V> createListSignal<V>(
    List<V> list, {
    SignalOptions<List<V>>? options,
  }) {
    return _bindLocal(
      ListSignal<V>(
        list,
        options: options,
      ),
    );
  }

  /// Create a [SetSignal]<T> and watch for changes
  SetSignal<V> createSetSignal<V>(
    Set<V> set, {
    SignalOptions<Set<V>>? options,
  }) {
    return _bindLocal(
      SetSignal<V>(
        set,
        options: options,
      ),
    );
  }

  /// Create a [QueueSignal]<T> and watch for changes
  QueueSignal<V> createQueueSignal<V>(
    Queue<V> queue, {
    SignalOptions<Queue<V>>? options,
  }) {
    return _bindLocal(
      QueueSignal<V>(
        queue,
        options: options,
      ),
    );
  }

  /// Create a [MapSignal]<T> and watch for changes
  MapSignal<K, V> createMapSignal<K, V>(
    Map<K, V> value, {
    SignalOptions<Map<K, V>>? options,
  }) {
    return _bindLocal(
      MapSignal<K, V>(
        value,
        options: options,
      ),
    );
  }

  /// Create a computed<T> and watch for changes
  FlutterComputed<V> createComputed<V>(
    V Function() cb, {
    FlutterSignalOptions<V>? options,
  }) {
    return _bindLocal(
      computed<V>(
        cb,
        options: options,
      ),
    );
  }

  S _bindLocal<V, S extends ReadonlySignal<V>>(S val) {
    _watch(val, true);
    return val;
  }

  /// Bind an existing `signal<T>` and watch for changes
  S bindSignal<V, S extends ReadonlySignal<V>>(S val) {
    _watch(val, false);
    return val;
  }

  /// Unbind an existing `signal<T>` changes
  S unbindSignal<V, S extends ReadonlySignal<V>>(S val) {
    _unwatch(val);
    return val;
  }

  /// Watch signal value
  V watchSignal<V, S extends ReadonlySignal<V>>(S val) {
    return bindSignal(val).value;
  }

  /// Unwatch an existing `signal<T>` value changes
  V unwatchSignal<V, S extends ReadonlySignal<V>>(S val) {
    return unbindSignal(val).value;
  }

  /// Watch signal value
  void listenSignal(
    ReadonlySignal<dynamic> target,
    void Function() callback, {
    String? debugLabel,
  }) {
    final current = _signals[target.globalId];
    if (current?.listener?.cb.hashCode == callback.hashCode) return;
    current?.listener?.cleanup();
    final cb = createEffect(
      callback,
      options: EffectOptions(name: debugLabel),
    );
    _signals[target.globalId] = (
      local: current?.local,
      target: target,
      listener: (cb: callback, cleanup: cb),
    );
  }

  /// Stop listening to a signal value
  void unlistenSignal(
    ReadonlySignal<dynamic> target,
    void Function() callback,
  ) {
    final current = _signals[target.globalId];
    if (current != null) {
      current.listener?.cleanup();
      _signals[target.globalId] = (
        local: current.local,
        target: target,
        listener: null,
      );
    }
  }

  /// Create a effect.
  ///
  /// Do not call inside the build method.
  ///
  /// Calling this method in build() will create a new
  /// effect every render.
  EffectCleanup createEffect(
    dynamic Function() cb, {
    EffectOptions? options,
    dynamic Function()? onDispose,
  }) {
    final s = effect(
      cb,
      options: options,
      onDispose: onDispose,
    );
    _effects.add(s);
    return () {
      _effects.remove(s);
      s();
    };
  }

  /// Reset all stored signals and effects
  void clearSignalsAndEffects() {
    _cleanup?.call();
    _cleanup = null;
    final local = _signals //
        .values
        .where((e) => e.local == true)
        .map((e) => e.target);
    for (final s in local) {
      s.dispose();
    }
    for (final cb in _effects) {
      cb();
    }
    _effects.clear();
    _signals.clear();
  }

  @override
  void dispose() {
    clearSignalsAndEffects();
    super.dispose();
  }
}
