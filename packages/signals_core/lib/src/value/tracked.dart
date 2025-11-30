part of 'value.dart';

/// A signal that stores the initial and previous value
class TrackedSignal<T> extends Signal<T> with TrackedSignalMixin<T> {
  /// A signal that stores the initial and previous value
  /// A signal that stores the initial and previous value
  TrackedSignal(
    super.value, {
    super.options,
  });
}

/// Create a signal that stores the initial and previous value
TrackedSignal<T> trackedSignal<T>(
  T value, {
  String? debugLabel,
  bool autoDispose = false,
  SignalOptions<T>? options,
}) {
  return TrackedSignal<T>(
    value,
    options: options ??
        SignalOptions<T>(
          name: debugLabel,
          autoDispose: autoDispose,
        ),
  );
}
