part of 'signals.dart';

/// Configuration options for reactive [Effect]s extending [signals.EffectOptions].
class EffectOptions extends signals.EffectOptions {
  /// Automatically dispose the signal when there are no more listeners.
  final bool autoDispose;

  /// Callback called when the effect is disposed.
  final void Function()? onDispose;

  /// Creates a new [EffectOptions] instance.
  const EffectOptions({
    super.name,
    this.autoDispose = false,
    this.onDispose,
  });

  @override
  EffectOptions copyWith({
    String? name,
    bool? autoDispose,
    void Function()? onDispose,
  }) {
    return EffectOptions(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      onDispose: onDispose ?? this.onDispose,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EffectOptions &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.onDispose == onDispose;
  }

  @override
  int get hashCode => Object.hash(name, autoDispose, onDispose);
}

/// Configuration options for a [ReadonlySignal] extending [signals.ReadonlySignalOptions].
class ReadonlySignalOptions<T> extends signals.ReadonlySignalOptions<T> {
  /// Automatically dispose the signal when there are no more listeners.
  final bool autoDispose;

  /// Convert to [SignalOptions]
  SignalOptions<T> get toSignalOptions => SignalOptions<T>(
        name: name,
        autoDispose: autoDispose,
        watched: watched,
        unwatched: unwatched,
      );

  /// Creates a new [ReadonlySignalOptions] instance.
  const ReadonlySignalOptions({
    super.name,
    this.autoDispose = false,
    super.watched,
    super.unwatched,
  });

  @override
  ReadonlySignalOptions<T> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return ReadonlySignalOptions<T>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReadonlySignalOptions<T> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(name, autoDispose, watched, unwatched);
}

/// Configuration options for a [Signal] extending [signals.SignalOptions].
class SignalOptions<T> extends signals.SignalOptions<T> {
  /// Automatically dispose the signal when there are no more listeners.
  final bool autoDispose;

  /// Creates a new [SignalOptions] instance.
  const SignalOptions({
    super.name,
    this.autoDispose = false,
    super.watched,
    super.unwatched,
  });

  @override
  SignalOptions<T> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return SignalOptions<T>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignalOptions<T> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(name, autoDispose, watched, unwatched);
}

/// Configuration options for a [Computed] extending [signals.ComputedOptions].
class ComputedOptions<T> extends signals.ComputedOptions<T> {
  /// Automatically dispose the signal when there are no more listeners.
  final bool autoDispose;

  /// Creates a new [ComputedOptions] instance.
  const ComputedOptions({
    super.name,
    this.autoDispose = false,
    super.watched,
    super.unwatched,
  });

  @override
  ComputedOptions<T> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return ComputedOptions<T>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ComputedOptions<T> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(name, autoDispose, watched, unwatched);
}
