part of 'value.dart';

/// A reactive [Signal] that holds a [Set] and implements the [Set] interface.
///
/// [SetSignal] lets you listen to changes on a set reactively and mutate it directly using
/// standard set operations (like `add`, `addAll`, `remove`, `clear`, etc.). Any mutations
/// automatically trigger reactive updates to all active listeners (e.g., inside an [effect]
/// or [computed]).
///
/// Additionally, [SetSignal] defines convenient operators:
/// - `<<` injects/adds all items from another set into the current set.
/// - `&` forks/unions the set with another set into a new [SetSignal].
/// - `|` pipes/unions the set with another signal holding an iterable into a new [SetSignal].
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// void main() {
///   final numbers = setSignal<int>({1, 2, 3});
///
///   effect(() {
///     print('Set content: $numbers, Length: ${numbers.length}');
///   }); // Prints: "Set content: {1, 2, 3}, Length: 3"
///
///   // Standard mutation (triggers updates)
///   numbers.add(4); // Prints: "Set content: {1, 2, 3, 4}, Length: 4"
///
///   // Removing an element (triggers updates)
///   numbers.remove(1); // Prints: "Set content: {2, 3, 4}, Length: 3"
///
///   // Set intersection (reactive query)
///   final common = numbers.intersection({3, 4, 5});
///   print(common); // Prints: {3, 4}
/// }
/// ```
///
/// :::tip
/// Mutating the collection directly calls the reactive set() routine under the hood automatically. You
/// do not need to assign `numbers.value = ...` manually!
/// :::
class SetSignal<E> extends Signal<Set<E>>
    with IterableSignalMixin<E, Set<E>>, SetSignalMixin<E, Set<E>>
    implements Set<E> {
  /// Creates a [SetSignal] with the given [value].
  SetSignal(
    super.value, {
    SetSignalOptions<E>? options,
    @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: SetSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              SetSignalOptions<E>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        );

  /// Inject: Update current signal value with iterable
  SetSignal<E> operator <<(Set<E> other) {
    final list = value;
    list.addAll(other);
    set(list, force: true);
    return SetSignal(list);
  }

  /// Fork: create a new signal with value is the concatenation of source signal and iterable parameter
  SetSignal<E> operator &(Set<E> other) {
    final list = value;
    final rs = Set<E>.from(list)..addAll(other);
    return SetSignal(rs);
  }

  /// Pipe: create a new signal by sending value from source to other
  SetSignal<E> operator |(Signal<Iterable<E>> other) {
    final list = value;
    final rs = Set<E>.from(list)..addAll(other.peek());
    return SetSignal(rs);
  }

  @override
  bool operator ==(Object other) {
    return other is SetSignal<E> && peek() == other.peek();
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

/// Creates a [SetSignal] initialized with the provided [set].
///
/// This is a convenience helper function for creating reactive set signals.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final mySet = setSignal({1, 2, 3});
/// ```
SetSignal<T> setSignal<T>(
  Set<T> list, {
  SetSignalOptions<T>? options,
  @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: SetSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return SetSignal<T>(
    list,
    options: options ??
        SetSignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Utility extension methods on [Set] to convert them to [SetSignal]s.
extension SignalSetUtils<T> on Set<T> {
  /// Convert this existing [Set] to a reactive [SetSignal].
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final mySet = {1, 2, 3};
  /// final signal = mySet.toSignal();
  /// ```
  SetSignal<T> toSignal({
    SetSignalOptions<T>? options,
    @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: SetSignalOptions(name: ...) instead')
    String? debugLabel,
  }) {
    return SetSignal(
      this,
      options: options ??
          SetSignalOptions<T>(
            autoDispose: autoDispose ?? false,
            name: debugLabel,
          ),
    );
  }
}

/// Configuration options for a [SetSignal].
class SetSignalOptions<E> extends SignalOptions<Set<E>> {
  /// Creates a new [SetSignalOptions] instance.
  const SetSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
    super.equality = const SignalDeepEquality(),
  });

  @override
  SetSignalOptions<E> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
    SignalEquality<Set<E>>? equality,
  }) {
    return SetSignalOptions<E>(
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
    return other is SetSignalOptions<E> &&
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
