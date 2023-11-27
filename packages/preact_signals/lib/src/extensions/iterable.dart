import 'package:preact_signals/src/iterable_signal.dart';

/// Extension on future to provide helpful methods for signals
extension SignalIterableUtils<T> on Iterable<T> {
  /// Convert an existing list to [IterableSignal]
  IterableSignal<T> toSignal() {
    return IterableSignal<T>(this);
  }
}
