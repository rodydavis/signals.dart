import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

/// Create and watch a signal and rebuild on changes.
///
/// ```dart
/// class State extends ... {
///  late final count = createSignal(this, 0);
///
///  @override
///  Widget build(BuildContext context) {
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
Signal<T> createSignal<T, S extends StatefulWidget>(
  State<S> widget,
  T value, {
  String? debugLabel,
  SignalEquality<T>? equality,
  bool autoDispose = false,
  dynamic Function(Signal<T>)? onDispose,
}) {
  final target = signal<T>(
    value,
    debugLabel: debugLabel,
    equality: equality,
    autoDispose: autoDispose,
  );
  return bindSignal(
    widget,
    target,
    debugLabel: debugLabel,
    equality: equality,
    autoDispose: autoDispose,
    onDispose: onDispose,
  );
}

/// Bind an existing signal to a widget.
///
/// ```dart
/// class State extends ... {
///  final source = signal(0);
///  late final count = bindSignal(this, source);
///
///  @override
///  Widget build(BuildContext context) {
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
Signal<T> bindSignal<T, S extends StatefulWidget>(
  State<S> widget,
  Signal<T> target, {
  String? debugLabel,
  SignalEquality<T>? equality,
  bool autoDispose = false,
  dynamic Function(Signal<T>)? onDispose,
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
    debugLabel: '$label=>createSignal=>effect',
    onDispose: () => onDispose?.call(target),
  );
  target.onDispose(dispose);
  return target;
}
