/// Error builder for [MutationState].
///
/// The `Function` below stands for one of three types:
/// - () -> E
/// - (dynamic) -> E
/// - (dynamic, StackTrace) -> E
typedef MutationErrorBuilder<E> = Function;

/// Value builder for [MutationState] success states. Receives the resolved
/// value of type `T`.
typedef MutationDataBuilder<E, T> = E Function(T value);

/// Generic no-argument builder for [MutationState] (idle and pending branches).
typedef MutationStateBuilder<E> = E Function();

/// {@template mutation_state}
/// A sealed union representing the lifecycle states of an imperative mutation
/// (a side-effecting async operation triggered on demand, e.g. submitting a
/// form or calling a `POST`/`PUT`/`DELETE` endpoint).
///
/// `MutationState<T>` is wrapped by [MutationSignal]. Unlike
/// [AsyncState] (which has no "not started yet" representation because a future
/// or stream begins executing immediately), a mutation begins in a [MutationIdle]
/// state and only transitions once it has been run.
///
/// ### State Hierarchy
/// - [MutationIdle]: The mutation has not been run yet (the extra state on top of
///   the standard loading/data/error lifecycle).
/// - [MutationPending]: The mutation is currently running.
/// - [MutationSuccess]: The mutation completed successfully with a value of type `T`.
/// - [MutationError]: The mutation failed with an error and stack trace.
///
/// ### Pattern Matching & Switch Expressions
/// ```dart
/// final label = switch (mutation.value) {
///   MutationIdle<int>() => 'Not run yet',
///   MutationPending<int>() => 'Saving...',
///   MutationSuccess<int>(:final value) => 'Saved: $value',
///   MutationError<int>(:final error) => 'Failed: $error',
/// };
/// ```
///
/// ### Standard Branching Methods (`map` and `maybeMap`)
/// ```dart
/// mutation.value.map(
///   idle: () => 'Not run yet',
///   pending: () => 'Saving...',
///   data: (value) => 'Saved: $value',
///   error: (error, stackTrace) => 'Failed: $error',
/// );
/// ```
///
/// @link https://dartsignals.dev/async/mutation
/// {@endtemplate}
sealed class MutationState<T> {
  /// Const constructor for [MutationState] subclasses.
  const MutationState();

  /// Create an [MutationIdle] state (the mutation has not been run yet).
  factory MutationState.idle() => MutationIdle<T>();

  /// Create a [MutationPending] state (the mutation is running).
  factory MutationState.pending() => MutationPending<T>();

  /// Create a [MutationSuccess] state with a resolved value.
  factory MutationState.data(T data) => MutationSuccess<T>(data);

  /// Create a [MutationError] state with an error and optional stack trace.
  factory MutationState.error(Object error, [StackTrace? stackTrace]) {
    return MutationError<T>(error, stackTrace ?? StackTrace.current);
  }

  /// Returns true if the mutation has not been run yet.
  bool get isIdle;

  /// Returns true if the mutation is currently running.
  bool get isPending;

  /// Returns true if the state holds a resolved value.
  bool get hasValue;

  /// Returns true if the state holds an error.
  bool get hasError;

  /// Returns the resolved value of the state, or null.
  T? get value;

  /// Returns the error of the state, or null.
  Object? get error;

  /// Returns the stack trace of the state, or null.
  StackTrace? get stackTrace;

  /// Force unwrap the value of the state.
  ///
  /// Throws an [UnsupportedError] if the state does not hold a value.
  T get requireValue;

  /// Map the state to a value, handling every branch.
  ///
  /// The error `Function` can be one of three types:
  /// - () -> E
  /// - (dynamic) -> E
  /// - (dynamic, StackTrace) -> E
  E map<E>({
    required MutationStateBuilder<E> idle,
    required MutationStateBuilder<E> pending,
    required MutationDataBuilder<E, T> data,
    required MutationErrorBuilder<E> error,
  }) {
    if (hasValue) return data(value as T);
    if (hasError) {
      if (error is Function(Object, StackTrace?)) {
        return error(this.error as Object, stackTrace);
      } else if (error is Function(Object)) {
        return error(this.error as Object);
      } else {
        return error();
      }
    }
    if (isPending) return pending();
    return idle();
  }

  /// Map the state to a value with an [orElse] fallback for unhandled branches.
  ///
  /// The error `Function` can be one of three types:
  /// - () -> E
  /// - (dynamic) -> E
  /// - (dynamic, StackTrace) -> E
  E maybeMap<E>({
    MutationStateBuilder<E>? idle,
    MutationStateBuilder<E>? pending,
    MutationDataBuilder<E, T>? data,
    MutationErrorBuilder<E>? error,
    required MutationStateBuilder<E> orElse,
  }) {
    if (hasValue) if (data != null) return data(value as T);
    if (hasError) {
      if (error != null) {
        if (error is Function(Object, StackTrace?)) {
          return error(this.error as Object, stackTrace);
        } else if (error is Function(Object)) {
          return error(this.error as Object);
        } else {
          return error();
        }
      }
    }
    if (isPending) if (pending != null) return pending();
    if (isIdle) if (idle != null) return idle();
    return orElse();
  }

  @override
  bool operator ==(covariant MutationState<T> other);

  @override
  int get hashCode;
}

/// The mutation has not been run yet.
class MutationIdle<T> extends MutationState<T> {
  /// The mutation has not been run yet.
  const MutationIdle();

  @override
  bool get isIdle => true;

  @override
  bool get isPending => false;

  @override
  bool get hasValue => false;

  @override
  bool get hasError => false;

  @override
  T? get value => null;

  @override
  Object? get error => null;

  @override
  StackTrace? get stackTrace => null;

  @override
  T get requireValue =>
      throw UnsupportedError('Idle state does not have a value');

  @override
  bool operator ==(covariant MutationState<T> other) =>
      other is MutationIdle<T>;

  @override
  int get hashCode => 0;
}

/// The mutation is currently running.
class MutationPending<T> extends MutationState<T> {
  /// The mutation is currently running.
  const MutationPending();

  @override
  bool get isIdle => false;

  @override
  bool get isPending => true;

  @override
  bool get hasValue => false;

  @override
  bool get hasError => false;

  @override
  T? get value => null;

  @override
  Object? get error => null;

  @override
  StackTrace? get stackTrace => null;

  @override
  T get requireValue =>
      throw UnsupportedError('Pending state does not have a value');

  @override
  bool operator ==(covariant MutationState<T> other) =>
      other is MutationPending<T>;

  @override
  int get hashCode => 1;
}

/// The mutation completed successfully with a value.
class MutationSuccess<T> extends MutationState<T> {
  /// The mutation completed successfully with a value.
  const MutationSuccess(T data) : value = data;

  @override
  bool get isIdle => false;

  @override
  bool get isPending => false;

  @override
  bool get hasValue => true;

  @override
  bool get hasError => false;

  @override
  final T value;

  @override
  Object? get error => null;

  @override
  StackTrace? get stackTrace => null;

  @override
  T get requireValue => value;

  @override
  bool operator ==(covariant MutationState<T> other) =>
      other is MutationSuccess<T> && other.value == value;

  @override
  int get hashCode => value.hashCode ^ 2;
}

/// The mutation failed with an error and stack trace.
class MutationError<T> extends MutationState<T> {
  /// The mutation failed with an error and stack trace.
  const MutationError(this.error, this.stackTrace);

  @override
  bool get isIdle => false;

  @override
  bool get isPending => false;

  @override
  bool get hasValue => false;

  @override
  bool get hasError => true;

  @override
  T? get value => null;

  @override
  final Object error;

  /// The stack trace captured when the mutation failed. Always non-null on a
  /// [MutationError] (defaulted to `StackTrace.current` by the factory).
  @override
  final StackTrace stackTrace;

  @override
  T get requireValue =>
      throw UnsupportedError('Error state does not have a value');

  @override
  bool operator ==(covariant MutationState<T> other) =>
      other is MutationError<T> &&
      other.error == error &&
      other.stackTrace == stackTrace;

  @override
  int get hashCode => error.hashCode ^ stackTrace.hashCode ^ 3;
}
