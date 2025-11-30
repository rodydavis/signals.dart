import 'equality.dart';
import 'signal.dart';

/// Callback for when a signal is watched or unwatched
typedef SignalCallback<T> = void Function(Signal<T> signal);

/// Options for creating a signal
class SignalOptions<T> {
  /// The name of the signal, used for debugging
  final String? name;

  /// Callback when the signal is first subscribed to
  final SignalCallback<T>? watched;

  /// Callback when the signal is no longer subscribed to
  final SignalCallback<T>? unwatched;

  /// Custom equality check for the signal value
  final SignalEquality<T>? _equalityCheck;

  /// Custom equality check for the signal value
  SignalEquality<T> get equalityCheck =>
      _equalityCheck ?? SignalEquality.standard<T>();

  /// Create a new SignalOptions
  const SignalOptions({
    this.name,
    this.watched,
    this.unwatched,
    SignalEquality<T>? equalityCheck,
  }) : _equalityCheck = equalityCheck;
}

/// Options for creating an effect
class EffectOptions {
  /// The name of the effect, used for debugging
  final String? name;

  /// Create a new EffectOptions
  const EffectOptions({this.name});
}
