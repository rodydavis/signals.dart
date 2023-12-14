import '../value/set_signal.dart';

/// Extension on future to provide helpful methods for signals
extension SignalSetUtils<T> on Set<T> {
  /// Convert an existing list to [SetSignal]
  SetSignal<T> toSignal({String? debugLabel}) {
    return SetSignal(
      this,
      debugLabel: debugLabel,
    );
  }
}
