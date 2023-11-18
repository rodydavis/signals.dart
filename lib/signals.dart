library dart_signals;

import 'src/signals.dart';
export 'src/signals.dart';

/// Creates a [Signal] with the given [initialValue].
///
/// ```dart
/// final count = signal(0);
/// final multiplier = signal(2);
/// ```
Signal<T> signal<T>(T initialValue) {
  return Signal<T>(initialValue);
}

/// Creates a [Computed] with the given [computeFn].
/// 
/// ```dart
/// final multipliedCount = computed(() {
///  return count.value * multiplier.value;
/// });
Computed<T> computed<T>(ComputedCallback<T> computeFn) {
  return Computed<T>(computeFn);
}

/// Creates an [Effect] with the given [effectFn].
/// 
/// ```dart
/// effect(() {
///  print(
///   'Effect called: Count is ${count.value} and multiplier is ${multiplier.value}');
/// });
/// ```
Effect effect(EffectCallback effectFn) {
  return Effect(effectFn);
}
