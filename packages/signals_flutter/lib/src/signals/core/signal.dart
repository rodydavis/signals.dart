import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

final _signals = <WeakReference<Element>, Map<int, Signal>>{};

/// Create and watch a signal in a build method
///
/// ```dart
/// class MyWidget extends ... {
///  @override
///  Widget build(BuildContext context) {
///    final count = useSignal(context, 0);
///    return Row(
///     children: [
///       IconButton(icon: Icon(Icons.remove), onPressed: () => count.value--),
///       Text(count.value.toString()),
///       IconButton(icon: Icon(Icons.add), onPressed: () => count.value++),
///    ],
///   );
///  }
/// }
/// ```
/// 
/// If you are defining multiple signals in a widget with the same type you
/// need to give it a label to differentiate them:
/// 
/// ```dart
/// class MyWidget extends ... {
///  @override
///  Widget build(BuildContext context) {
///    final count = useSignal(context, 0);
///    final count2 = useSignal(context, 0, debugLabel: 'count2');
///    return Row(
///     children: [
///       IconButton(icon: Icon(Icons.remove), onPressed: () => count.value--),
///       Text(count.value.toString()),
///       IconButton(icon: Icon(Icons.add), onPressed: () => count.value++),
///    ],
///   );
///  }
/// }
/// ```
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