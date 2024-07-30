import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../../signals_core.dart';

/// Signals mixin for watching and disposing of signals
mixin SignalsMixin<T extends StatefulWidget> on State<T> {
  final _signals = HashMap.of(<int, (bool, ReadonlySignal<dynamic>)>{});
  EffectCleanup? _cleanup;
  final _effects = <EffectCleanup>[];

  void _setup() {
    final cb = effect(() {
      for (final s in _signals.values) {
        s.$2.value;
      }
      if (mounted) (context as Element).markNeedsBuild();
    });
    _cleanup?.call();
    _cleanup = cb;
  }

  void _watch(ReadonlySignal<dynamic> target, bool local) {
    if (_signals.containsKey(target.globalId)) return;
    _signals[target.globalId] = (local, target);
    _setup();
  }

  void _unwatch(ReadonlySignal<dynamic> target) {
    if (!_signals.containsKey(target.globalId)) return;
    _signals.remove(target.globalId);
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

  /// Watch signal value
  V watchSignal<V, S extends ReadonlySignal<V>>(S val) {
    return bindSignal(val).value;
  }

  /// Unbind an existing signal<T> changes
  S unbindSignal<V, S extends ReadonlySignal<V>>(S val) {
    _unwatch(val);
    return val;
  }

  /// Unwatch an existing signal<T> value changes
  V unwatchSignal<V, S extends ReadonlySignal<V>>(S val) {
    return unbindSignal(val).value;
  }

  /// Create a effect
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

  @override
  void dispose() {
    _cleanup?.call();
    for (final s in _signals.values.where((e) => e.$1).map((e) => e.$2)) {
      s.dispose();
    }
    for (final cb in _effects) {
      cb();
    }
    super.dispose();
  }
}
