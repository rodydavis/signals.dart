import 'dart:async';
import 'dart:collection';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../signals_core.dart';

typedef _SignalMetadata = ({
  bool? local,
  ReadonlySignal<dynamic> target,
  ({Function cb, EffectCleanup cleanup})? listener,
});

/// Signals mixin for watching and disposing of signals
mixin SignalsMixin<T extends StatefulWidget> on State<T> {
  final _signals = HashMap.of(<int, _SignalMetadata>{});
  EffectCleanup? _cleanup;
  final _effects = <EffectCleanup>[];

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
    final cb = effect(() {
      for (final s in _signals.values.where((e) => e.local != null)) {
        s.target.value;
      }
      _rebuild();
    });
    _cleanup?.call();
    _cleanup = cb;
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

  /// Create a signal<T> and watch for changes
  Signal<V> createSignal<V>(
    V val, {
    String? debugLabel,
    bool autoDispose = true,
  }) {
    final s = signal<V>(
      val,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
    _watch(s, true);
    return s;
  }

  /// Create a computed<T> and watch for changes
  Computed<V> createComputed<V>(
    V Function() cb, {
    String? debugLabel,
    bool autoDispose = true,
  }) {
    final s = computed<V>(
      cb,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
    _watch(s, true);
    return s;
  }

  /// Bind an existing signal<T> and watch for changes
  S bindSignal<V, S extends ReadonlySignal<V>>(S val) {
    _watch(val, false);
    return val;
  }

  /// Unbind an existing signal<T> changes
  S unbindSignal<V, S extends ReadonlySignal<V>>(S val) {
    _unwatch(val);
    return val;
  }

  /// Watch signal value
  V watchSignal<V, S extends ReadonlySignal<V>>(S val) {
    return bindSignal(val).value;
  }

  /// Unwatch an existing signal<T> value changes
  V unwatchSignal<V, S extends ReadonlySignal<V>>(S val) {
    return unbindSignal(val).value;
  }

  /// Watch signal value
  void listenSignal(
    ReadonlySignal<dynamic> target,
    void Function() callback, {
    String? debugLabel,
  }) {
    final current = _signals[target.globalId]?.listener;
    if (current?.cb.hashCode == callback.hashCode) return;
    current?.cleanup();
    final cb = createEffect(
      callback,
      debugLabel: debugLabel,
    );
    _signals[target.globalId] = (
      local: null,
      target: target,
      listener: (cb: callback, cleanup: cb),
    );
  }

  /// Stop listening to a signal value
  void unlistenSignal(
    ReadonlySignal<dynamic> target,
    void Function() callback,
  ) {
    final current = _signals[target.globalId]?.listener;
    current?.cleanup();
  }

  /// Create a effect.
  /// 
  /// Do not call inside the build method.
  /// 
  /// Calling this method in build() will create a new
  /// effect every render.
  EffectCleanup createEffect(
    dynamic Function() cb, {
    String? debugLabel,
    dynamic Function()? onDispose,
  }) {
    final s = effect(
      cb,
      debugLabel: debugLabel,
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
