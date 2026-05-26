part of 'value.dart';

/// A reactive [Signal] that holds a [List] and implements the [List] interface.
///
/// [ListSignal] lets you listen to changes on a list reactively and mutate it directly using
/// standard list operations (like `add`, `addAll`, `remove`, operators `[]` and `[]=`, etc.).
/// Any mutations automatically trigger reactive updates to all active listeners (e.g., inside an
/// [effect] or [computed]).
///
/// Additionally, [ListSignal] defines convenient operators:
/// - `<<` injects/adds all items from an iterable into the list.
/// - `&` forks/concatenates the list with an iterable into a new [ListSignal].
/// - `|` pipes/concatenates the list with another signal holding an iterable into a new [ListSignal].
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// void main() {
///   final numbers = listSignal<int>([1, 2, 3]);
///
///   effect(() {
///     print('List content: $numbers, Length: ${numbers.length}');
///   }); // Prints: "List content: [1, 2, 3], Length: 3"
///
///   // Standard mutation (triggers updates)
///   numbers.add(4); // Prints: "List content: [1, 2, 3, 4], Length: 4"
///
///   // Update via index operator (triggers updates)
///   numbers[0] = 10; // Prints: "List content: [10, 2, 3, 4], Length: 4"
///
///   // Injection operator (triggers updates)
///   numbers << [5, 6]; // Prints: "List content: [10, 2, 3, 4, 5, 6], Length: 6"
/// }
/// ```
///
/// :::tip
/// Mutating the collection directly calls the reactive set() routine under the hood automatically. You
/// do not need to assign `numbers.value = ...` manually!
/// :::
class ListSignal<E> extends Signal<List<E>>
    with IterableSignalMixin<E, List<E>>, ListSignalMixin<E, List<E>>
    implements List<E> {
  /// Creates a [ListSignal] with the given [value].
  ListSignal(
    super.value, {
    ListSignalOptions<E>? options,
    @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: ListSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              ListSignalOptions<E>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        );

  /// Inject: Update current signal value with iterable
  ListSignal<E> operator <<(Iterable<E> other) {
    value.addAll(other);
    set(value, force: true);
    return this;
  }

  /// Fork: create a new signal which value is the concatenation of source signal and iterable parameter
  ListSignal<E> operator &(Iterable<E> other) {
    final rs = List<E>.from(peek())..addAll(other);
    return ListSignal(rs);
  }

  /// Pipe: create a new signal by sending value from source to other
  ListSignal<E> operator |(Signal<Iterable<E>> other) {
    final rs = List<E>.from(peek())..addAll(other.peek());
    return ListSignal(rs);
  }

  @override
  bool operator ==(Object other) {
    return other is ListSignal<E> && peek() == other.peek();
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

/// Creates a [ListSignal] initialized with the provided [list].
///
/// This is a convenience helper function for creating reactive list signals.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final list = listSignal([1, 2, 3]);
/// ```
ListSignal<T> listSignal<T>(
  List<T> list, {
  ListSignalOptions<T>? options,
  @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: ListSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return ListSignal<T>(
    list,
    options: options ??
        ListSignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Utility extension methods on [List] to convert them to [ListSignal]s.
extension SignalListUtils<T> on List<T> {
  /// Convert this existing [List] to a reactive [ListSignal].
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final myList = [1, 2, 3];
  /// final signal = myList.toSignal();
  /// ```
  ListSignal<T> toSignal({
    ListSignalOptions<T>? options,
    @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: ListSignalOptions(name: ...) instead')
    String? debugLabel,
  }) {
    return ListSignal<T>(
      this,
      options: options ??
          ListSignalOptions<T>(
            autoDispose: autoDispose ?? false,
            name: debugLabel,
          ),
    );
  }
}

/// Configuration options for a [ListSignal].
class ListSignalOptions<E> extends SignalOptions<List<E>> {
  /// Creates a new [ListSignalOptions] instance.
  const ListSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
    super.equality = const SignalDeepEquality(),
  });

  @override
  ListSignalOptions<E> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
    SignalEquality<List<E>>? equality,
  }) {
    return ListSignalOptions<E>(
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
    return other is ListSignalOptions<E> &&
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
