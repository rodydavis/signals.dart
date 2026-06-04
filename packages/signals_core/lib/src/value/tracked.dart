part of 'value.dart';

/// A signal that stores the initial and previous value
class TrackedSignal<T> extends Signal<T> with TrackedSignalMixin<T> {
  /// A signal that stores the initial and previous value
  TrackedSignal(
    super.value, {
    TrackedSignalOptions<T>? options,
    @Deprecated('Use options: TrackedSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: TrackedSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              TrackedSignalOptions<T>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        );
}

/// Create a signal that stores the initial and previous value
TrackedSignal<T> trackedSignal<T>(
  T value, {
  TrackedSignalOptions<T>? options,
  @Deprecated('Use options: TrackedSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: TrackedSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return TrackedSignal<T>(
    value,
    options: options ??
        TrackedSignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Configuration options for a [TrackedSignal].
class TrackedSignalOptions<T> extends SignalOptions<T> {
  /// Creates a new [TrackedSignalOptions] instance.
  const TrackedSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
  });

  @override
  TrackedSignalOptions<T> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return TrackedSignalOptions<T>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TrackedSignalOptions<T> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(name, autoDispose, watched, unwatched);
}
