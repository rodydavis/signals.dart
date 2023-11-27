/// To react to the various states you can use a switch statement:
///
/// ```dart
/// final SignalState<T> state = ...;
/// final result = (switch(state) {
///   SignalValue result => print('value: ${result.value}'),
///   SignalTimeout _ => print('timeout error'),
///   SignalError result => print('error: ${result.error}'),
///   SignalLoading _ => print('loading'),
/// });
/// ```
sealed class SignalState<T> {
  /// Returns true if the signal is in a loading state
  bool get isLoading => this is SignalLoading<T>;

  /// Returns true if the signal is in an error state
  bool get isTimeout => this is SignalTimeout<T>;

  /// Returns true if the signal is in an error state
  bool get hasError => this is SignalError<T, Object>;

  /// Returns true if the signal is in a value state
  bool get hasValue => this is SignalValue<T>;

  /// Returns the value of the signal or null if not a value
  T? get valueOrNull {
    if (this is SignalValue<T>) {
      return (this as SignalValue<T>).value;
    }
    return null;
  }

  /// Returns the error of the signal or null if not an error
  Object? get errorOrNull {
    if (this is SignalError<T, Object>) {
      return (this as SignalError<T, Object>).value;
    }
    return null;
  }
}

/// Successful state for a signal
class SignalValue<T> extends SignalState<T> {
  /// Value of the signal
  final T value;

  /// Successful value result
  SignalValue(this.value);
}

/// Error state for a signal
class SignalError<T, E extends Object> extends SignalState<T> {
  /// Error of the exception
  final E? value;

  /// Error value result
  SignalError(this.value);
}

/// Timeout exception for a signal
class SignalTimeout<T> extends SignalError<T, Object> {
  /// Timeout error result
  SignalTimeout() : super(null);
}

/// Loading state of the signal
class SignalLoading<T> extends SignalState<T> {}
