/// Options for a signal
class SignalOptions<T> {
  /// Signal name
  final String? name;

  /// Callback when the signal is watched
  final void Function()? watched;

  /// Callback when the signal is unwatched
  final void Function()? unwatched;

  /// Options for a signal
  const SignalOptions({
    this.name,
    this.watched,
    this.unwatched,
  });
}

/// Options for an effect
class EffectOptions {
  /// Effect name
  final String? name;

  /// Options for an effect
  const EffectOptions({
    this.name,
  });
}
