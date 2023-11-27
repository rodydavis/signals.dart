/// To react to the various states you can use a switch statement:
///
/// ```dart
/// final SignalState state = ...;
/// final result = (switch(state) {
///   SignalValue result => print('value: ${result.value}'),
///   SignalTimeout _ => print('timeout error'),
///   SignalError result => print('error: ${result.error}'),
///   SignalLoading _ => print('loading'),
/// });
/// ```
sealed class SignalState {}

/// Successful state for a signal
class SignalValue<T> extends SignalState {
  /// Value of the signal
  final T value;

  /// Successful value result
  SignalValue(this.value);
}

/// Error state for a signal
class SignalError extends SignalState {
  /// Error of the exception
  final Object? value;

  /// Error value result
  SignalError(this.value);
}

/// Timeout exception for a signal
class SignalTimeout extends SignalError {
  /// Timeout error result
  SignalTimeout() : super(null);
}

/// Loading state of the signal
class SignalLoading extends SignalState {}
