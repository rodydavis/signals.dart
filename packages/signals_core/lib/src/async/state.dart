/// Error builder for [AsyncState]
///
/// The `Function` below stands for one of two types:
/// - (dynamic) -> FutureOr
/// - (dynamic, StackTrace) -> FutureOr
typedef AsyncErrorBuilder<E> = Function;

/// Value builder for [AsyncState]
typedef AsyncDataBuilder<E, T> = E Function(
  T value,
);

/// Generic builder for [AsyncState]
typedef AsyncStateBuilder<E> = E Function();

/// {@template state}
/// A sealed union representing the lifecycle states of an asynchronous operation.
///
/// `AsyncState<T>` is commonly wrapped by `AsyncSignal` or returned by asynchronous
/// computed signals (`computedAsync`, `computedFrom`) to model loading, success (data),
/// and error outcomes.
///
/// ### State Hierarchy
/// The states are modeled as a robust hierarchy of immutable types:
/// - [AsyncLoading]: Pure loading state with no pre-existing data.
/// - [AsyncData]: Success state holding a resolved value of type `T`.
///   - [AsyncDataRefreshing]: Refreshing in the background (holding historical data).
///   - [AsyncDataReloading]: Reloading (holding historical data).
/// - [AsyncError]: Failure state holding an error and optional stack trace.
///   - [AsyncErrorRefreshing]: Refreshing in the background (holding historical error).
///   - [AsyncErrorReloading]: Reloading (holding historical error).
///
/// ### Pattern Matching & Switch Expressions
/// Standard Dart switch expressions provide type-safe branching across all states:
///
/// > [!IMPORTANT]
/// > **Branch Matching Order & Existing Value Preservation:**
/// > Since reloading and refreshing states (e.g., `AsyncDataRefreshing`, `AsyncDataReloading`) implement both `AsyncData` and `AsyncLoading`, matching on `AsyncLoading` **first** will prematurely swallow existing data!
/// > Always place `AsyncData` and `AsyncError` branches **before** `AsyncLoading` to ensure pre-existing data or error states are successfully rendered during refreshes:
///
/// ```dart
/// final value = switch (state) {
///     AsyncDataRefreshing<int> r => 'Refreshing with value: ${r.value}',
///     AsyncDataReloading<int> r => 'Reloading with value: ${r.value}',
///     AsyncData<int> data => 'Stable value: ${data.value}',
///     AsyncErrorRefreshing<int> r => 'Refreshing error: ${r.error}',
///     AsyncErrorReloading<int> r => 'Reloading error: ${r.error}',
///     AsyncError<int> error => 'Stable error: ${error.error}',
///     AsyncLoading<int>() => 'Pure Loading State (no prior data)',
/// };
/// ```
///
/// ### Standard Branching Methods (`map` and `maybeMap`)
/// If you prefer standard callbacks over switch expressions, use `map` or `maybeMap`:
/// ```dart
/// state.map(
///   data: (value) => 'Value: $value',
///   error: (error, stackTrace) => 'Error: $error',
///   loading: () => 'Loading...',
/// );
/// ```
///
/// @link https://dartsignals.dev/async/state
/// {@endtemplate}
sealed class AsyncState<T> {
  const AsyncState();

  /// Create a state with a value that is reloading
  factory AsyncState.dataReloading(T data) {
    return AsyncDataReloading<T>(data);
  }

  /// Create a state with a value that is refreshing
  factory AsyncState.dataRefreshing(T data) {
    return AsyncDataRefreshing<T>(data);
  }

  /// Create a state with a value
  factory AsyncState.data(T data) {
    return AsyncData<T>(data);
  }

  /// Create a state with an error that is reloading
  factory AsyncState.errorReloading(Object error, [StackTrace? stackTrace]) {
    return AsyncErrorReloading<T>(error, stackTrace ?? StackTrace.current);
  }

  /// Create a state with an error that is refreshing
  factory AsyncState.errorRefreshing(Object error, [StackTrace? stackTrace]) {
    return AsyncErrorRefreshing<T>(error, stackTrace ?? StackTrace.current);
  }

  /// Create a state with an error
  factory AsyncState.error(Object error, [StackTrace? stackTrace]) {
    return AsyncError<T>(error, stackTrace ?? StackTrace.current);
  }

  /// Create a loading state
  factory AsyncState.loading() {
    return AsyncLoading<T>();
  }

  /// Returns true if the state has a value
  bool get hasValue;

  /// Returns true if the state has an error
  bool get hasError;

  /// Check if the state is a loading state
  bool get isLoading;

  /// Returns true if the state is refreshing with a loading flag,
  ///  has a value or error and is not the loading state
  bool get isRefreshing;

  /// Returns true if the state is reloading with having a value or error,
  /// and is the loading state
  bool get isReloading;

  /// Force unwrap the value of the state.
  ///
  /// This will throw an error if the state does not have a value.
  T get requireValue;

  /// Returns the value of the state.
  T? get value;

  /// Returns the error of the state.
  Object? get error;

  /// Returns the stack trace of the state.
  StackTrace? get stackTrace;

  /// Map the state to a value.
  ///
  /// ```dart
  /// final signal = StreamSignal<int>();
  /// signal.value.map(
  ///  data: (value) => 'Value: $value',
  ///  error: (error, stackTrace) => 'Error: $error',
  ///  loading: () => 'Loading...',
  /// );
  /// ```
  ///
  /// The error `Function` below can be one of two types:
  /// - (dynamic) -> FutureOr
  /// - (dynamic, StackTrace) -> FutureOr
  E map<E>({
    required AsyncDataBuilder<E, T> data,
    required AsyncErrorBuilder<E> error,
    required AsyncStateBuilder<E> loading,
    AsyncStateBuilder<E>? reloading,
    AsyncStateBuilder<E>? refreshing,
  }) {
    if (isRefreshing) if (refreshing != null) return refreshing();
    if (isReloading) if (reloading != null) return reloading();
    if (hasValue) return data(value as T);
    if (hasError) {
      if (error is Function(dynamic, dynamic)) {
        return error(this.error, stackTrace);
      } else if (error is Function(dynamic)) {
        return error(this.error);
      } else {
        return error();
      }
    }
    return loading();
  }

  /// Map the state to a value with optional or else.
  ///
  /// ```dart
  /// final signal = StreamSignal<int>();
  /// signal.value.maybeMap(
  ///  data: (value) => 'Value: $value',
  ///  orElse: () => 'Loading...',
  /// );
  /// ```
  ///
  /// The error `Function` below can be one of two types:
  /// - (dynamic) -> FutureOr
  /// - (dynamic, StackTrace) -> FutureOr
  E maybeMap<E>({
    AsyncDataBuilder<E, T>? data,
    AsyncErrorBuilder<E>? error,
    AsyncStateBuilder<E>? loading,
    AsyncStateBuilder<E>? reloading,
    AsyncStateBuilder<E>? refreshing,
    required AsyncStateBuilder<E> orElse,
  }) {
    if (isRefreshing) if (refreshing != null) return refreshing();
    if (isReloading) if (reloading != null) return reloading();
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
    if (isLoading) if (loading != null) return loading();
    return orElse();
  }

  @override
  bool operator ==(covariant AsyncState<T> other);

  @override
  int get hashCode;
}

/// A loading state with a value. Signals the query conditions that led to the data
/// has changed and is being reloaded.
class AsyncDataReloading<T> extends AsyncData<T> implements AsyncLoading<T> {
  /// Create a state with a value that is reloading
  const AsyncDataReloading(super.data);

  @override
  bool get isLoading => true;

  @override
  bool get isReloading => true;

  @override
  // ignore: hash_and_equals
  bool operator ==(covariant AsyncState other) {
    return other is AsyncDataReloading<T> && other.value == value;
  }
}

/// A loading state with a value. Signals the query conditions that led to the data
/// has remained the same and is being refreshed
class AsyncDataRefreshing<T> extends AsyncData<T> implements AsyncLoading<T> {
  /// Create a state with a value that is refreshing
  const AsyncDataRefreshing(super.data);

  @override
  bool get isLoading => true;

  @override
  bool get isRefreshing => true;

  @override
  // ignore: hash_and_equals
  bool operator ==(covariant AsyncState other) {
    return other is AsyncDataRefreshing<T> && other.value == value;
  }
}

/// State for an [AsyncState] with a value
class AsyncData<T> extends AsyncState<T> {
  /// State for an [AsyncState] with a value
  const AsyncData(T data) : value = data;

  @override
  bool get hasValue => true;

  @override
  bool get hasError => false;

  @override
  final T value;

  @override
  bool get isLoading => false;

  @override
  bool get isRefreshing => false;

  @override
  bool get isReloading => false;

  @override
  T get requireValue => value;

  @override
  Object? get error => null;

  @override
  StackTrace? get stackTrace => null;

  @override
  bool operator ==(covariant AsyncState other) {
    if (other is AsyncData<T>) {
      return other.value == value;
    }
    return false;
  }

  @override
  int get hashCode =>
      value.hashCode ^
      isLoading.hashCode ^
      isRefreshing.hashCode ^
      isReloading.hashCode;
}

/// A loading state with an error. Signal the query conditions that led to the error
/// has changed and is being reloaded.
class AsyncErrorReloading<T> extends AsyncError<T> implements AsyncLoading<T> {
  /// Create a state with an error that is reloading
  const AsyncErrorReloading(super.error, super.stackTrace);

  @override
  bool get isLoading => true;

  @override
  bool get isReloading => true;

  @override
  // ignore: hash_and_equals
  bool operator ==(covariant AsyncState other) {
    return other is AsyncErrorReloading<T> &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }
}

/// A loading state with an error. Signal the query conditions that led to the error
/// has remained the same and is being refreshed.
class AsyncErrorRefreshing<T> extends AsyncError<T> implements AsyncLoading<T> {
  /// Create a state with an error that is refreshing
  const AsyncErrorRefreshing(super.error, super.stackTrace);

  @override
  bool get isLoading => true;

  @override
  bool get isRefreshing => true;

  @override
  // ignore: hash_and_equals
  bool operator ==(covariant AsyncState other) {
    return other is AsyncErrorRefreshing<T> &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }
}

/// State for an [AsyncState] with an error
class AsyncError<T> extends AsyncState<T> {
  /// State for an [AsyncState] with an error
  const AsyncError(this.error, this.stackTrace);

  @override
  bool get hasValue => false;

  @override
  bool get hasError => true;

  @override
  T? get value => null;

  @override
  bool get isLoading => false;

  @override
  bool get isRefreshing => false;

  @override
  bool get isReloading => false;

  @override
  T get requireValue =>
      throw UnsupportedError('Error state does not have a value');

  @override
  final Object error;

  @override
  final StackTrace stackTrace;

  @override
  bool operator ==(covariant AsyncState other) {
    return other is AsyncError<T> &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode =>
      error.hashCode ^
      stackTrace.hashCode ^
      isLoading.hashCode ^
      isRefreshing.hashCode ^
      isReloading.hashCode;
}

/// State for an [AsyncState] with a loading state
class AsyncLoading<T> extends AsyncState<T> {
  /// State for an [AsyncState] with a loading state
  const AsyncLoading();

  @override
  bool get hasValue => false;

  @override
  bool get hasError => false;

  @override
  T? get value => null;

  @override
  bool get isLoading => true;

  @override
  bool get isRefreshing => false;

  @override
  bool get isReloading => false;

  @override
  T get requireValue =>
      throw UnsupportedError('Loading state does not have a value');

  @override
  Object? get error => null;

  @override
  StackTrace? get stackTrace => null;

  @override
  bool operator ==(covariant AsyncState other) {
    return other is AsyncLoading;
  }

  @override
  int get hashCode => 0;
}
