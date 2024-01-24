import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

final _signals = <WeakReference<Element>, Map<int, Signal>>{};

Signal<T> useSignal<T>(
  BuildContext context,
  T value, {
  String? debugLabel,
  SignalEquality<T>? equality,
}) {
  assert(context is Element);
  final key = (value, debugLabel).hashCode;
  final current = _signals.entries.firstWhere(
    (e) => e.key.target == context,
    orElse: () => MapEntry(WeakReference(context as Element), {}),
  );
  final result = current.value.entries.firstWhere(
    (e) => e.key == key,
    orElse: () {
      final s = signal<T>(
        value,
        debugLabel: debugLabel,
        equality: equality,
      );
      s.subscribe((value) {
        if (current.key.target != null && current.key.target!.mounted) {
          current.key.target!.markNeedsBuild();
        }
      });
      s.onDispose(() {
        current.value.remove(key);
      });
      current.value[key] = s;
      return MapEntry(key, s);
    },
  );
  _signals[current.key] = current.value;
  return result.value as Signal<T>;
}
