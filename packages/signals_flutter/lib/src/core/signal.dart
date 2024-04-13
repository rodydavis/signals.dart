import 'package:flutter/material.dart';

import '../../signals_flutter.dart';

/// Bind an existing signal to a widget.
///
/// ```dart
/// class State extends ... {
///  final source = signal(0);
///  late final count = bindSignal(context, source);
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
  watchSignal<T>(
    context,
    target,
    debugLabel: debugLabel,
  );
  return target;
}

/// Create and watch a signal and rebuild on changes.
///
/// ```dart
/// class State extends ... {
///  late final count = createSignal(context, 0);
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
  assert(
    allowSignalsCreatedInBuildContext ? true : context is StatefulElement,
    'createSignal must be called in a StatefulElement like State<T>',
  );
  Signal<T> result;
  if (allowSignalsCreatedInBuildContext) {
    final key = (value, debugLabel, autoDispose).hashCode;
    if (_signals[key]?.target == null || _signals[key]?.target is! Signal<T>) {
      _signals.remove(key);
    }
    final target = _signals[key] ??= () {
      final source = signal<T>(
        value,
        debugLabel: debugLabel,
        autoDispose: autoDispose,
      );
      final ref = WeakReference(source);
      source.onDispose(() => _signals.remove(key));
      return ref;
    }();
    result = target.target as Signal<T>;
  } else {
    result = signal<T>(
      value,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
  return bindSignal<T, Signal<T>>(context, result);
}

final _signals = <int, WeakReference<Signal>>{};

/// If true it would allow creating signals inside the build method.
///
/// This comes at the cost of needing to be unique with the starting value,
/// debug label and auto dispose flag
bool allowSignalsCreatedInBuildContext = false;
