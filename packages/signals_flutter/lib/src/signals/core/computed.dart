import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

final _store = <WeakReference<Element>, Map<int, Computed>>{};

/// Create and watch a computed signal in a build method
///
/// ```dart
/// class MyWidget extends ... {
///  @override
///  Widget build(BuildContext context) {
///    final count = useSignal(context, 0);
///    final isEven = useComputed(context, () => count.value % 2 == 0);
///    return Row(
///     children: [
///       IconButton(icon: Icon(Icons.remove), onPressed: () => count.value--),
///       Text('$count event=$isEven),
///       IconButton(icon: Icon(Icons.add), onPressed: () => count.value++),
///    ],
///   );
///  }
/// }
/// ```
Computed<T> useComputed<T>(
  BuildContext context,
  T Function() value, {
  String? debugLabel,
  SignalEquality<T>? equality,
}) {
  assert(context is Element);
  final key = (value, debugLabel).hashCode;
  final current = _store.entries.firstWhere(
    (e) => e.key.target == context,
    orElse: () => MapEntry(WeakReference(context as Element), {}),
  );
  final result = current.value.entries.firstWhere(
    (e) => e.key == key,
    orElse: () {
      final s = computed<T>(
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
  _store[current.key] = current.value;
  return result.value as Computed<T>;
}
