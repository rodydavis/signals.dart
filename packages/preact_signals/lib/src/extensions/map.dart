import 'package:preact_signals/src/map_signal.dart';

/// Extension on future to provide helpful methods for signals
extension SignalMapUtils<K, V> on Map<K, V> {
  /// Convert an existing list to [MapSignal]
  MapSignal<K, V> toSignal() {
    return MapSignal<K, V>(this);
  }
}
