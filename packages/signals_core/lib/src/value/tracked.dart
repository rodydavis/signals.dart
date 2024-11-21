part of 'value.dart';

/// A signal that stores the initial and previous value
class TrackedSignal<T> extends Signal<T> with TrackedSignalMixin<T> {
  /// A signal that stores the initial and previous value
  TrackedSignal(
    super.value, {
    super.debugLabel,
    super.autoDispose,
  });
}

/// Create a signal that stores the initial and previous value
TrackedSignal<T> trackedSignal<T>(
  T value, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return TrackedSignal<T>(
    value,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
