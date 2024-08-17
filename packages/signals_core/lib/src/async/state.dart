/// Error builder for [AsyncState]
///
/// The `Function` below stands for one of two types:
/// - (dynamic) -> FutureOr<T>
/// - (dynamic, StackTrace) -> FutureOr<T>
typedef AsyncErrorBuilder<E> = Function;

/// Value builder for [AsyncState]
typedef AsyncDataBuilder<E, T> = E Function(
  T value,
);

/// Generic builder for [AsyncState]
typedef AsyncStateBuilder<E> = E Function();

/// {@template state}
/// `AsyncState` is class commonly used with Future/Stream signals to represent the states the signal can be in.
/// 
/// ## AsyncSignal
/// 
/// `AsyncState` is the default state if you want to create a `AsyncSignal` directly:
/// 
/// ```dart
/// final s = asyncSignal(AsyncState.data(1));
/// s.value = AsyncState.loading(); // or AsyncLoading();
/// s.value = AsyncState.error('Error', null); // or AsyncError();
/// ```
/// 
/// ## AsyncState
/// 
/// `AsyncState` is a sealed union made up of `AsyncLoading`, `AsyncData` and `AsyncError`.
/// 
/// ### .future
/// 
/// Sometimes you need to await a signal value in a async function until a value is completed and in this case use the .future getter.
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// s.value = AsyncState.data(1);
/// await s.future; // Waits until data or error is set
/// ```
/// 
/// ### .isCompleted
/// 
/// Returns true if the future has completed with an error or value:
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// s.value = AsyncState.data(1);
/// print(s.isCompleted); // true
/// ```
/// 
/// ### .hasValue
/// 
/// Returns true if a value has been set regardless of the state.
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.hasValue); // false
/// s.value = AsyncState.data(1);
/// print(s.hasValue); // true
/// ```
/// 
/// ### .hasError
/// 
/// Returns true if a error has been set regardless of the state.
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.hasError); // false
/// s.value = AsyncState.error('error', null);
/// print(s.hasError); // true
/// ```
/// 
/// ### .isRefreshing
/// 
/// Returns true if the state is refreshing with a loading flag, has a value or error and is not the loading state.
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.isRefreshing); // false
/// s.value = AsyncState.error('error', null, isLoading: true);
/// print(s.isRefreshing); // true
/// s.value = AsyncData(1, isLoading: true);
/// print(s.isRefreshing); // true
/// ```
/// 
/// ### .isReloading
/// 
/// Returns true if the state is reloading with having a value or error, and is the loading state.
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.isReloading); // false
/// s.value = AsyncState.loading(data: 1);
/// print(s.isReloading); // true
/// s.value = AsyncState.loading(error: ('error', null));
/// print(s.isReloading); // true
/// ```
/// 
/// ### .requireValue
/// 
/// Force unwrap the value of the state and throw an error if it has an error or is null.
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.data(1));
/// print(s.requireValue); // 1
/// ```
/// 
/// ### .value
/// 
/// Return the current value if exists.
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.data(1));
/// print(s.value); // 1 or null
/// ```
/// 
/// ### .error
/// 
/// Return the current error if exists.
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.error('error', null));
/// print(s.error); // 'error' or null
/// ```
/// 
/// ### .stackTrace
/// 
/// Return the current stack trace if exists.
/// 
/// ```dart
/// final s = asyncSignal<int>(AsyncState.error('error', StackTrace(...)));
/// print(s.stackTrace); // StackTrace(...) or null
/// ```
/// 
/// ### .map
/// 
/// If you want to handle the states of the signal `map` will enforce all branching.
/// 
/// ```dart
/// final signal = asyncSignal<int>(AsyncState.data(1));
/// signal.value.map(
///  data: (value) => 'Value: $value',
///  error: (error, stackTrace) => 'Error: $error',
///  loading: () => 'Loading...',
/// );
/// ```
/// 
/// ### .maybeMap
/// 
/// If you want to handle some of the states of the signal `maybeMap` will provide a default and optional overrides.
/// 
/// ```dart
/// final signal = asyncSignal<int>(AsyncState.data(1));
/// signal.value.maybeMap(
///  data: (value) => 'Value: $value',
///  orElse: () => 'Loading...',
/// );
/// ```
/// 
/// ### Pattern Matching
/// 
/// Instead of `map` and `maybeMap` it is also possible to use [dart switch expressions](https://dart.dev/language/patterns) to handle the branching.
/// 
/// ```dart
/// final signal = asyncSignal<int>(AsyncState.data(1));
/// final value = switch (signal.value) {
///     AsyncData<int> data => 'value: ${data.value}',
///     AsyncError<int> error => 'error: ${error.error}',
///     AsyncLoading<int>() => 'loading',
/// };
/// ```
/// @link https://dartsignals.dev/async/state
/// {@endtemplate}
sealed class AsyncState<T> {
  /// Check if the state is a loading state
  final bool isLoading;
  final T? _value;
  final (Object, StackTrace?)? _error;

  const AsyncState({
    required this.isLoading,
    required T? value,
    required (Object, StackTrace?)? error,
  })  : _value = value,
        _error = error;

  /// Create a state with a value
  factory AsyncState.data(T data) {
    return AsyncData<T>(data);
  }

  /// Create a state with an error
  factory AsyncState.error(Object error, [StackTrace? stackTrace]) {
    return AsyncError<T>(error, stackTrace ?? StackTrace.current);
  }

  /// Create a state with a loading state
  factory AsyncState.loading() {
    return AsyncLoading<T>();
  }

  /// Returns true if the state has a value
  bool get hasValue;

  /// Returns true if the state has an error
  bool get hasError;

  /// Returns true if the state is refreshing with a loading flag,
  ///  has a value or error and is not the loading state
  bool get isRefreshing =>
      isLoading && (hasValue || hasError) && this is! AsyncLoading<T>;

  /// Returns true if the state is reloading with having a value or error,
  /// and is the loading state
  bool get isReloading => (hasValue || hasError) && this is AsyncLoading<T>;

  /// Force unwrap the value of the state.
  ///
  /// This will throw an error if the state does not have a value.
  T get requireValue => _value as T;

  /// Returns the value of the state.
  T? get value => _value;

  /// Returns the error of the state.
  Object? get error => _error?.$1;

  /// Returns the stack trace of the state.
  StackTrace? get stackTrace => _error?.$2;

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
  /// - (dynamic) -> FutureOr<T>
  /// - (dynamic, StackTrace) -> FutureOr<T>
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
  /// - (dynamic) -> FutureOr<T>
  /// - (dynamic, StackTrace) -> FutureOr<T>
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
  bool operator ==(covariant AsyncState<T> other) {
    if (identical(this, other)) return true;
    return other.hasError == hasError &&
        other.hasValue == hasValue &&
        other.isLoading == isLoading &&
        other.isRefreshing == isRefreshing &&
        other.isReloading == isReloading &&
        other._value == _value &&
        other._error == _error;
  }

  @override
  int get hashCode {
    return hasError.hashCode ^
        hasValue.hashCode ^
        isLoading.hashCode ^
        isRefreshing.hashCode ^
        isReloading.hashCode ^
        _value.hashCode ^
        _error.hashCode;
  }
}

/// State for an [AsyncState] with a value
class AsyncData<T> extends AsyncState<T> {
  /// State for an [AsyncState] with a value
  const AsyncData(
    T data, {
    super.isLoading = false,
    super.error,
  }) : super(value: data);

  @override
  bool get hasValue => true;

  @override
  bool get hasError => false;

  @override
  T get value => super.value as T;
}

/// State for an [AsyncState] with an error
class AsyncError<T> extends AsyncState<T> {
  /// State for an [AsyncState] with an error
  const AsyncError(
    Object error,
    StackTrace? stackTrace, {
    super.isLoading = false,
    super.value,
  }) : super(error: (error, stackTrace));

  @override
  bool get hasValue => false;

  @override
  bool get hasError => true;

  @override
  Object get error => super.error as Object;
}

/// State for an [AsyncState] with a loading state
class AsyncLoading<T> extends AsyncState<T> {
  /// State for an [AsyncState] with a loading state
  const AsyncLoading({
    super.value,
    super.error,
    super.isLoading = true,
    this.hasValue = false,
    this.hasError = false,
  });

  @override
  final bool hasValue;

  @override
  final bool hasError;
}
