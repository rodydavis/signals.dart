part of 'value.dart';

/// A reactive [Signal] that holds an [Iterable] and implements the [Iterable] interface.
///
/// [IterableSignal] allows you to listen to changes on an iterable collection reactively. It
/// exposes all standard [Iterable] properties and methods (like `length`, `first`, `map`, `where`, etc.)
/// directly on the signal itself. Calling these methods inside a reactive context (like an `effect`
/// or `computed` block) will automatically track them as dependencies.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// void main() {
///   final items = iterableSignal<int>([1, 2, 3]);
///
///   effect(() {
///     print('Items length: ${items.length}, First: ${items.first}');
///   }); // Prints: "Items length: 3, First: 1"
///
///   // Update the signal by assigning a new iterable
///   items.value = [10, 20, 30, 40]; // Prints: "Items length: 4, First: 10"
/// }
/// ```
///
/// :::caution
/// Direct mutation of the items inside the iterable will NOT trigger updates. To reactively mutate collections,
/// use specialized signals like [ListSignal], [SetSignal], or [MapSignal].
/// :::
class IterableSignal<E> extends Signal<Iterable<E>>
    with IterableSignalMixin<E, Iterable<E>>
    implements Iterable<E> {
  /// Creates a [IterableSignal] with the given [value].
  IterableSignal(
    super.value, {
    IterableSignalOptions<E>? options,
    @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: IterableSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              IterableSignalOptions<E>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        );

  @override
  bool operator ==(Object other) {
    return other is IterableSignal<E> && peek() == other.peek();
  }

  @override
  int get hashCode {
    final val = peek();
    return Object.hashAll([
      globalId.hashCode,
      val.hashCode,
      for (final item in val) item.hashCode,
    ]);
  }
}

/// Creates an [IterableSignal] holding the provided [iterable].
///
/// This is a convenience function that instantiates an [IterableSignal], which delegates
/// all standard [Iterable] operations reactively and tracks changes.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final s = iterableSignal([1, 2, 3]);
/// print(s.length); // 3
/// ```
IterableSignal<T> iterableSignal<T>(
  Iterable<T> iterable, {
  IterableSignalOptions<T>? options,
  @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: IterableSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return IterableSignal<T>(
    iterable,
    options: options ??
        IterableSignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Utility extension methods on [Iterable] to convert them to [IterableSignal]s.
extension SignalIterableUtils<T> on Iterable<T> {
  /// Convert an existing [Iterable] to an [IterableSignal].
  ///
  /// This returns an [IterableSignal] initialized with the current collection.
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final numbers = [1, 2, 3];
  /// final signal = numbers.toSignal();
  /// ```
  IterableSignal<T> toSignal({
    IterableSignalOptions<T>? options,
    @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: IterableSignalOptions(name: ...) instead')
    String? debugLabel,
  }) {
    return IterableSignal<T>(
      this,
      options: options ??
          IterableSignalOptions<T>(
            autoDispose: autoDispose ?? false,
            name: debugLabel,
          ),
    );
  }
}

/// Configuration options for a [IterableSignal].
class IterableSignalOptions<E> extends SignalOptions<Iterable<E>> {
  /// Creates a new [IterableSignalOptions] instance.
  const IterableSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
    super.equality = const SignalDeepEquality(),
  });

  @override
  IterableSignalOptions<E> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
    SignalEquality<Iterable<E>>? equality,
  }) {
    return IterableSignalOptions<E>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
      equality: equality ?? equalityCheck,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IterableSignalOptions<E> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched &&
        other.equalityCheck == equalityCheck;
  }

  @override
  int get hashCode =>
      Object.hash(name, autoDispose, watched, unwatched, equalityCheck);
}
