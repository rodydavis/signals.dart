sealed class SignalState {}

class SignalValue<T> extends SignalState {
  final T value;
  SignalValue(this.value);
}

class SignalError extends SignalState {
  final Object? value;
  SignalError(this.value);
}

class SignalTimeout extends SignalError {
  SignalTimeout() : super(null);
}

class SignalLoading extends SignalState {}
