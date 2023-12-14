import '../value/iterable_signal.dart';

/// Extension on future to provide helpful methods for signals
extension SignalIterableUtils<T> on Iterable<T> {
  /// Convert an existing list to [IterableSignal]
  IterableSignal<T> toSignal({String? debugLabel}) {
    return IterableSignal<T>(
      this,
      debugLabel: debugLabel,
    );
  }
}
