import 'package:preact_signals/preact_signals.dart' as preact;

/// Options for creating an effect
class EffectOptions extends preact.EffectOptions {
  /// Whether to automatically dispose the effect when it has no listeners
  final bool autoDispose;

  /// Callback when the effect is disposed
  final void Function()? onDispose;

  /// Options for creating an effect
  const EffectOptions({
    super.name,
    this.autoDispose = false,
    this.onDispose,
  });
}

/// Options for creating a signal
class SignalOptions<T> extends preact.SignalOptions<T> {
  /// Whether to automatically dispose the signal when it has no listeners
  final bool autoDispose;

  /// Options for creating a signal
  const SignalOptions({
    super.name,
    super.watched,
    super.unwatched,
    this.autoDispose = false,
  });
}
