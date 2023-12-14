/// Error builder for [AsyncSignalState]
typedef AsyncSignalErrorBuilder<E> = E Function(
  Object error,
  StackTrace? stackTrace,
);

/// Value builder for [AsyncSignalState]
typedef AsyncSignalValueBuilder<E, T> = E Function(
  T value,
);

/// Generic builder for [AsyncSignalState]
typedef AsyncSignalBuilder<E> = E Function();

/// State for an [AsyncSignal]
sealed class AsyncSignalState<T> {
  final bool isLoading;
  final T? _value;
  final (Object, StackTrace?)? _error;

  const AsyncSignalState({
    required this.isLoading,
    required T? value,
    required (Object, StackTrace?)? error,
  })  : _value = value,
        _error = error;

  /// Create a state with a value
  factory AsyncSignalState.data(T data) {
    return AsyncSignalStateData<T>(data);
  }

  /// Create a state with an error
  factory AsyncSignalState.error(Object error, StackTrace? stackTrace) {
    return AsyncSignalStateError<T>(error, stackTrace);
  }

  /// Create a state with a loading state
  factory AsyncSignalState.loading() {
    return AsyncSignalStateLoading<T>();
  }

  /// Returns true if the state has a value
  bool get hasValue;

  /// Returns true if the state has an error
  bool get hasError;

  /// Returns true if the state is refreshing with a loading flag,
  ///  has a value or error and is not the loading state
  bool get isRefreshing =>
      isLoading &&
      (hasValue || hasError) &&
      this is! AsyncSignalStateLoading<T>;

  /// Returns true if the state is reloading with having a value or error,
  /// and is the loading state
  bool get isReloading =>
      (hasValue || hasError) && this is AsyncSignalStateLoading<T>;

  /// Force unwrap the value of the state.
  ///
  /// This will throw an error if the state does not have a value.
  T get requireValue => _value!;

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
    required AsyncSignalValueBuilder<E, T> data,
    required AsyncSignalErrorBuilder<E> error,
    required AsyncSignalBuilder<E> loading,
    AsyncSignalBuilder<E>? reloading,
    AsyncSignalBuilder<E>? refreshing,
  }) {
    if (isRefreshing) if (refreshing != null) return refreshing();
    if (isReloading) if (reloading != null) return reloading();
    if (hasValue) return data(requireValue);
    if (hasError) return error(this.error!, this.stackTrace);
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
    AsyncSignalValueBuilder<E, T>? data,
    AsyncSignalErrorBuilder<E>? error,
    AsyncSignalBuilder<E>? loading,
    AsyncSignalBuilder<E>? reloading,
    AsyncSignalBuilder<E>? refreshing,
    required AsyncSignalBuilder<E> orElse,
  }) {
    if (isRefreshing) return refreshing != null ? refreshing() : orElse();
    if (isReloading) return reloading != null ? reloading() : orElse();
    if (hasValue) return data != null ? data(requireValue) : orElse();
    if (hasError) {
      if (error != null) return error(this.error!, this.stackTrace);
      return orElse();
    }
    if (isLoading) return loading != null ? loading() : orElse();
    return orElse();
  }

  @override
  bool operator ==(covariant AsyncSignalState<T> other) {
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

/// State for an [AsyncSignal] with a value
class AsyncSignalStateData<T> extends AsyncSignalState<T> {
  AsyncSignalStateData(
    T data, {
    super.isLoading = false,
    super.error,
  }) : super(value: data);

  @override
  bool get hasValue => true;

  @override
  bool get hasError => false;
}

/// State for an [AsyncSignal] with an error
class AsyncSignalStateError<T> extends AsyncSignalState<T> {
  AsyncSignalStateError(
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

/// State for an [AsyncSignal] with a loading state
class AsyncSignalStateLoading<T> extends AsyncSignalState<T> {
  AsyncSignalStateLoading({
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
