import 'effect.dart';
import 'options.dart';
import 'listenable.dart';

abstract class ReadonlySignal<T> {
  ReadonlySignalOptions<T> get options;

  T get value;

  @override
  String toString() => value.toString();

  /// Convert value to JSON
  dynamic toJson() => value;

  /// Return the value when invoked
  T call() => value;

  /// Helper method to get the current value
  T get() => value;

  /// In the rare instance that you have an effect that should write to another signal based on the previous value, but you _don't_ want the effect to be subscribed to that signal, you can read a signals's previous value via `signal.peek()`.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final effectCount = signal(0);
  ///
  /// effect(() {
  /// 	print(counter.value);
  ///
  /// 	// Whenever this effect is triggered, increase `effectCount`.
  /// 	// But we don't want this signal to react to `effectCount`
  /// 	effectCount.value = effectCount.peek() + 1;
  /// });
  /// ```
  ///
  /// Note that you should only use `signal.peek()` if you really need it. Reading a signal's value via `signal.value` is the preferred way in most scenarios.
  T peek();

  /// Subscribe to value changes with a dispose function
  EffectCleanup subscribe(void Function(T value) fn);

  bool isDirty();

  Iterable<Listenable> get listenables;

  void addListenable(Listenable listenable);

  void removeListenable(Listenable listenable);
}

class ReadonlySignalOptions<T> extends SignalsOptions {
  const ReadonlySignalOptions({
    super.debugLabel,
  });
}
