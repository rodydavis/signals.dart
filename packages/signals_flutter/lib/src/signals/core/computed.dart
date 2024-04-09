import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

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
Computed<T> bindComputed<T>(
  BuildContext context,
  Computed<T> target, {
  String? label,
}) {
  return bindSignal<T, Computed<T>>(
    context,
    target,
    label: label,
  );
}

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
Computed<T> createComputed<T>(
  BuildContext context,
  T Function() compute, {
  String? label,
  bool autoDispose = false,
}) {
  assert(
    allowSignalsCreatedInBuildContext ? true : context is StatefulElement,
    'createComputed must be called in a StatefulElement like State<T>',
  );
  Computed<T> result;
  if (allowSignalsCreatedInBuildContext) {
    final key = (compute, label, autoDispose).hashCode;
    if (_signals[key]?.target == null || _signals[key]?.target is! Signal<T>) {
      _signals.remove(key);
    }
    final target = _signals[key] ??= () {
      final source = computed<T>(
        compute,
        debugLabel: label,
        autoDispose: autoDispose,
      );
      final ref = WeakReference(source);
      source.onDispose(() => _signals.remove(key));
      return ref;
    }();
    result = target.target as Computed<T>;
  } else {
    result = computed<T>(
      compute,
      debugLabel: label,
      autoDispose: autoDispose,
    );
  }
  return bindComputed(context, result);
}

final _signals = <int, WeakReference<Computed>>{};
