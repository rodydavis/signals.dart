import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

/// Create and watch a computed signal and rebuild on changes.
///
/// ```dart
/// class State extends ... {
///  late final count = createSignal(context, 0);
///  late final isEven = createComputed(context, () => count().isEven);
///  late final isOdd = createComputed(context, () => count().isOdd);
///
///  @override
///  Widget build(BuildContext context) {
///    return Row(
///     children: [
///       IconButton(icon: Icon(Icons.remove), onPressed: () => count.value--),
///       Text('$count, even=$isEven, odd=$isOdd'),
///       IconButton(icon: Icon(Icons.add), onPressed: () => count.value++),
///    ],
///   );
///  }
/// }
/// ```
Computed<T> createComputed<T, S extends StatefulWidget>(
  State<S> widget,
  T Function() compute, {
  String? debugLabel,
  SignalEquality<T>? equality,
  bool autoDispose = false,
  dynamic Function(Computed<T>)? onDispose,
}) {
  final target = computed<T>(
    compute,
    debugLabel: debugLabel,
    equality: equality,
    autoDispose: autoDispose,
  );
  return bindComputed(
    widget,
    target,
    debugLabel: debugLabel,
    equality: equality,
    autoDispose: autoDispose,
    onDispose: onDispose,
  );
}

/// Bind an existing computed to a widget.
///
/// ```dart
/// class State extends ... {
///  late final count = createSignal(context, 0);
///  late final isEven = computed(() => count().isEven);
///  late final even = bindComputed(context, isEven);
///
///  @override
///  Widget build(BuildContext context) {
///    return Row(
///     children: [
///       IconButton(icon: Icon(Icons.remove), onPressed: () => count.value--),
///       Text('$count, even=$even'),
///       IconButton(icon: Icon(Icons.add), onPressed: () => count.value++),
///    ],
///   );
///  }
/// }
/// ```
Computed<T> bindComputed<T, S extends StatefulWidget>(
  State<S> widget,
  Computed<T> target, {
  String? debugLabel,
  SignalEquality<T>? equality,
  bool autoDispose = false,
  dynamic Function(Computed<T>)? onDispose,
}) {
  final label = '${target.globalId}|${target.debugLabel}';
  final dispose = createEffect(
    widget,
    () {
      target.value;
      final context = widget.context;
      if (context is Element && context.mounted && !context.dirty) {
        context.markNeedsBuild();
      }
    },
    debugLabel: '$label=>createComputed=>effect',
    onDispose: () => onDispose?.call(target),
  );
  target.onDispose(dispose);
  return target;
}
