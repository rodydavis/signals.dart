/// Configuration options for a [Signal].
class SignalOptions<T> {
  /// The name of the signal for debugging purposes.
  final String? name;

  /// Callback called when the signal goes from 0 to >=1 listeners.
  final void Function()? watched;

  /// Callback called when the signal goes from >=1 to 0 listeners.
  final void Function()? unwatched;

  const SignalOptions({
    this.name,
    this.watched,
    this.unwatched,
  });
}

/// Configuration options for a [ReadonlySignal].
class ReadonlySignalOptions<T> {
  /// The name of the signal for debugging purposes.
  final String? name;

  /// Callback called when the signal goes from 0 to >=1 listeners.
  final void Function()? watched;

  /// Callback called when the signal goes from >=1 to 0 listeners.
  final void Function()? unwatched;

  const ReadonlySignalOptions({
    this.name,
    this.watched,
    this.unwatched,
  });
}

/// Configuration options for a [Computed] signal.
class ComputedOptions<T> {
  /// The name of the signal for debugging purposes.
  final String? name;

  /// Callback called when the signal goes from 0 to >=1 listeners.
  final void Function()? watched;

  /// Callback called when the signal goes from >=1 to 0 listeners.
  final void Function()? unwatched;

  const ComputedOptions({
    this.name,
    this.watched,
    this.unwatched,
  });
}

/// Configuration options for reactive [Effect]s.
class EffectOptions {
  /// The name of the effect for debugging purposes.
  final String? name;

  const EffectOptions({
    this.name,
  });
}
