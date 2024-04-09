import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

/// Bind an existing computed to a widget.
///
/// ```dart
/// class State extends ... {
///  late final count = createSignal(this, 0);
///  late final isEven = computed(() => count().isEven);
///  late final even = bindComputed(this, isEven);
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
Computed<T> bindComputed<T>(
  BuildContext context,
  Computed<T> target, {
  String? debugLabel,
}) {
  assert(context is StatefulElement, 'bindComputed must be called in a StatefulElement like State<T>');
  return bindSignal<T, Computed<T>>(
    context,
    target,
    debugLabel: debugLabel,
  );
}

/// Create and watch a computed signal and rebuild on changes.
///
/// ```dart
/// class State extends ... {
///  late final count = createSignal(this, 0);
///  late final isEven = createComputed(this, () => count().isEven);
///  late final isOdd = createComputed(this, () => count().isOdd);
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
Computed<T> createComputed<T>(
  BuildContext context,
  T Function() compute, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  assert(context is StatefulElement, 'createComputed must be called in a StatefulElement like State<T>');
  return bindComputed(
    context,
    computed<T>(
      compute,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    ),
  );
}
