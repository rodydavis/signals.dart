import '../value/iterable_signal.dart';

/// Extension on future to provide helpful methods for signals
extension SignalIterableUtils<T> on Iterable<T> {
  /// Convert an existing list to [IterableSignal]
  IterableSignal<T> toSignal({String? label}) {
    return IterableSignal<T>(
      this,
      label: label,
    );
  }
}
