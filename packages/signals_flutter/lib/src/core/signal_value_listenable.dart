import 'package:flutter/foundation.dart';

import '../../signals_flutter.dart';

part 'signal_value_notifier.dart';

/// [Signal] + [ValueListenable]
class SignalValueListenable<T, N extends ValueListenable<T>,
        S extends ReadonlySignal<T>> extends WrappedReadonlySignal<T, S>
    implements ValueListenable<T> {
  /// Internal value notifier
  final N notifier;

  /// [Signal] + [ValueListenable]
  SignalValueListenable._(this.notifier, super.source) {
    _SetSource? target;

    source.subscribe((val) {
      if (target == _SetSource.signal) return;
      target = _SetSource.signal;
      if (notifier is ValueNotifier<T>) {
        (notifier as ValueNotifier<T>).value = val;
      }
      target = null;
    });

    void update() {
      if (target == _SetSource.notifier) return;
      target = _SetSource.notifier;
      if (source is Signal<T>) {
        (source as Signal<T>).value = notifier.value;
      }
      target = null;
    }

    notifier.addListener(update);
    source.onDispose(() => notifier.removeListener(update));
  }

  /// [SignalValueListenable] from value
  factory SignalValueListenable(
    T val, {
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return SignalValueListenable._(
      ValueNotifier<T>(val) as N,
      signal<T>(
        val,
        debugLabel: debugLabel,
        autoDispose: autoDispose,
      ) as S,
    );
  }

  /// [SignalValueListenable] from [ReadonlySignal]
  factory SignalValueListenable.fromSignal(S val) {
    return SignalValueListenable._(
      ValueNotifier<T>(val.value) as N,
      val,
    );
  }

  /// [SignalValueListenable] from [ValueListenable]
  factory SignalValueListenable.fromValueListenable(
    N val, {
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return SignalValueListenable._(
      val,
      signal<T>(
        val.value,
        debugLabel: debugLabel,
        autoDispose: autoDispose,
      ) as S,
    );
  }

  VoidCallback? _cleanup;

  @override
  void dispose() {
    _cleanup?.call();
    super.dispose();
  }

  @override
  void addListener(VoidCallback listener) {
    return notifier.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    return notifier.removeListener(listener);
  }
}

/// [Signal] + [ValueListenable]
SignalValueListenable<T, ValueListenable<T>, ReadonlySignal<T>>
    signalValueListenable<T>(
  T val, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return SignalValueListenable<T, ValueListenable<T>, ReadonlySignal<T>>(
    val,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

enum _SetSource { signal, notifier }
