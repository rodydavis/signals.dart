import '../value/list_signal.dart';

/// Extension on future to provide helpful methods for signals
extension SignalListUtils<T> on List<T> {
  /// Convert an existing list to [ListSignal]
  ListSignal<T> toSignal({String? debugLabel}) {
    return ListSignal<T>(
      this,
      debugLabel: debugLabel,
    );
  }
}
