part of 'value.dart';

/// A reactive [Signal] that records its history of values, allowing undo and redo operations.
///
/// [ChangeStackSignal] stores successive values of the signal in a double-ended queue.
/// This allows you to revert back to previous values using [undo] and re-apply undone values
/// using [redo]. You can also specify an optional [limit] parameter to cap the history queue size.
///
/// :::note
/// If you only need access to the initial and immediate previous values of a signal (without a full
/// history stack or undo/redo mechanisms), use the lightweight [TrackedSignalMixin] instead.
/// :::
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// void main() {
///   final counter = ChangeStackSignal<int>(0, limit: 5);
///
///   effect(() {
///     print('Counter: ${counter.value}');
///   }); // Prints: "Counter: 0"
///
///   counter.value = 1; // Prints: "Counter: 1"
///   counter.value = 2; // Prints: "Counter: 2"
///
///   print('Can Undo: ${counter.canUndo}'); // Prints: "Can Undo: true"
///
///   // Perform undo operation (automatically triggers reactive updates)
///   counter.undo(); // Prints: "Counter: 1"
///   counter.undo(); // Prints: "Counter: 0"
///
///   // Perform redo operation
///   counter.redo(); // Prints: "Counter: 1"
/// }
/// ```
///
/// :::caution
/// This class works best with values that are immutable or copied when updated.
/// If you mutate an object in-place directly without assigning a new value using the `.value`
/// setter or `set(...)`, the history queue will store references to the same mutated object, and
/// undo/redo operations will not reflect changes correctly.
/// :::
class ChangeStackSignal<T> extends Signal<T> with ChangeStackSignalMixin<T> {
  /// Creates a [ChangeStackSignal] initialized with the provided [value].
  ChangeStackSignal(
    super.value, {
    int? limit,
    ChangeSignalOptions<T>? options,
    @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: ChangeSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              ChangeSignalOptions<T>(
                limit: limit,
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        ) {
    this.limit = limit ?? options?.limit;
  }
}

/// Creates a [ChangeStackSignal] initialized with the provided [value].
///
/// This is a convenience helper function for creating reactive undo/redo history signals.
/// You can pass a [limit] to restrict the maximum history stack size.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final s = changeStack(0, limit: 10);
/// s.value = 1;
/// s.undo(); // Returns to 0
/// ```
ChangeStackSignal<T> changeStack<T>(
  T value, {
  int? limit,
  ChangeSignalOptions<T>? options,
  @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: ChangeSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return ChangeStackSignal<T>(
    value,
    limit: limit,
    options: options ??
        ChangeSignalOptions<T>(
          limit: limit,
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Configuration options for a [ChangeStackSignal].
typedef ChangeStackSignalOptions<T> = ChangeSignalOptions<T>;

/// Configuration options for a [ChangeStackSignal].
class ChangeSignalOptions<T> extends SignalOptions<T> {
  /// The limit of changes to keep in the undo/redo stack.
  final int? limit;

  /// Creates a new [ChangeSignalOptions] instance.
  const ChangeSignalOptions({
    this.limit,
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
  });

  @override
  ChangeSignalOptions<T> copyWith({
    int? limit,
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return ChangeSignalOptions<T>(
      limit: limit ?? this.limit,
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChangeSignalOptions<T> &&
        other.limit == limit &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(limit, name, autoDispose, watched, unwatched);
}
