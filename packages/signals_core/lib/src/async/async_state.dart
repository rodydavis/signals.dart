/// Error builder for [AsyncState]
typedef AsyncErrorBuilder<E> = E Function(
  Object error,
  StackTrace? stackTrace,
);

/// Value builder for [AsyncState]
typedef AsyncDataBuilder<E, T> = E Function(
  T value,
);

/// Generic builder for [AsyncState]
typedef AsyncStateBuilder<E> = E Function();

/// State for an [AsyncSignal]
sealed class AsyncState<T> {
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
  factory AsyncState.error(Object error, StackTrace? stackTrace) {
    return AsyncError<T>(error, stackTrace);
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
    if (hasError) return error(this.error!, stackTrace);
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
    if (hasError) if (error != null) return error(this.error!, stackTrace);
    if (loading != null) return loading();
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
  AsyncData(
    T data, {
    super.isLoading = false,
    super.error,
  }) : super(value: data);

  @override
  bool get hasValue => true;

  @override
  bool get hasError => false;
}

/// State for an [AsyncState] with an error
class AsyncError<T> extends AsyncState<T> {
  AsyncError(
    Object error,
    StackTrace? stackTrace, {
    super.isLoading = false,
    super.value,
  }) : super(error: (error, stackTrace));

  @override
  bool get hasValue => false;

  @override
  bool get hasError => true;
}

/// State for an [AsyncState] with a loading state
class AsyncLoading<T> extends AsyncState<T> {
  AsyncLoading({
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

@Deprecated('Use [AsyncState] instead')
typedef AsyncSignalState<T> = AsyncState<T>;

@Deprecated('Use [AsyncLoading] instead')
typedef AsyncSignalStateLoading<T> = AsyncLoading<T>;

@Deprecated('Use [AsyncData] instead')
typedef AsyncSignalStateData<T> = AsyncData<T>;

@Deprecated('Use [AsyncError] instead')
typedef AsyncSignalStateError<T> = AsyncError<T>;
