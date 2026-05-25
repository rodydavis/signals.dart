/// Base configuration options for reactive components and signals.
abstract class SignalOptionsBase {
  /// The name for debugging purposes.
  final String? name;

  /// Creates a new [SignalOptionsBase] instance.
  const SignalOptionsBase({this.name});
}

/// Configuration options for reactive [Effect]s.
class EffectOptions extends SignalOptionsBase {
  /// Creates a new [EffectOptions] instance.
  const EffectOptions({super.name});
}

/// Configuration options for a [ReadonlySignal].
class ReadonlySignalOptions<T> extends SignalOptionsBase {
  /// Callback called when the signal goes from 0 to >=1 listeners.
  final void Function()? watched;

  /// Callback called when the signal goes from >=1 to 0 listeners.
  final void Function()? unwatched;

  /// Creates a new [ReadonlySignalOptions] instance.
  const ReadonlySignalOptions({
    super.name,
    this.watched,
    this.unwatched,
  });
}

/// Configuration options for a [Signal].
class SignalOptions<T> extends ReadonlySignalOptions<T> {
  /// Creates a new [SignalOptions] instance.
  const SignalOptions({
    super.name,
    super.watched,
    super.unwatched,
  });
}

/// Configuration options for a [Computed] signal.
class ComputedOptions<T> extends ReadonlySignalOptions<T> {
  /// Creates a new [ComputedOptions] instance.
  const ComputedOptions({
    super.name,
    super.watched,
    super.unwatched,
  });
}
