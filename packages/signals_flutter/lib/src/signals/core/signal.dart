import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

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
S bindSignal<T, S extends ReadonlySignal<T>>(
  BuildContext context,
  S target, {
  String? debugLabel,
}) {
  assert(context is StatefulElement, 'bindSignal must be called in a StatefulElement like State<T>');
  watchSignal<T>(context, target);
  return target;
}

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
Signal<T> createSignal<T>(
  BuildContext context,
  T value, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  assert(context is StatefulElement, 'createSignal must be called in a StatefulElement like State<T>');
  return bindSignal<T, Signal<T>>(
    context,
    signal<T>(
      value,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    ),
  );
}
