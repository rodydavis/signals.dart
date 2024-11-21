import 'package:signals_core/signals_core.dart';

/// Signal extensions
extension ReadonlySignalUntrackedValueUtils<T> on ReadonlySignal<T> {
  /// Runs a callback function that returns the signal value without
  /// subscribing to the signal updates.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final untrackedValue = counter.untrackedValue;
  /// ```
  T get untrackedValue => untracked(() => value);
}
