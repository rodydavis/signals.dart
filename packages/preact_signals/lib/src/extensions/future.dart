import 'package:preact_signals/preact_signals.dart';

/// A [Signal] that wraps a [Future]
///
/// Starts with [SignalLoading] for the default
/// state until the future completes.
///
/// When an error occurs [SignalError] is returned with the value
/// being the [Object] of the exception
///
/// If success then the result will be [SignalValue]
class FutureSignal<T> extends Signal<SignalState> {
  /// Creates a [FutureSignal] that wraps a [Future]
  FutureSignal(this._getFuture) : super(SignalLoading()) {
    _init();
  }

  final Future<T> Function() _getFuture;

  /// Resets the signal by calling the [Future] again
  void reset() {
    _init();
  }

  void _init() {
    if (peek() is! SignalLoading) {
      value = SignalLoading();
    }

    _getFuture().then((value) {
      this.value = SignalValue(value);
    }).catchError((error) {
      value = SignalError(error);
    });
  }
}

/// Extension on future to provide helpful methods for signals
extension SignalFutureUtils on Future {
  /// Convert an existing future to [ReadonlySignal]
  toSignal() => FutureSignal(() => this);
}
