import 'equality.dart';
import 'readonly.dart';

/// Callback for when a signal is watched or unwatched
typedef SignalCallback<T> = void Function(ReadonlySignal<T> signal);

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

  /// Copy the options with new values
  SignalOptions<T> copyWith({
    String? name,
    SignalCallback<T>? watched,
    SignalCallback<T>? unwatched,
    SignalEquality<T>? equalityCheck,
  }) {
    return SignalOptions<T>(
      name: name ?? this.name,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
      equalityCheck: equalityCheck ?? this.equalityCheck,
    );
  }
}

/// Options for creating an effect
class EffectOptions {
  /// The name of the effect, used for debugging
  final String? name;

  /// Create a new EffectOptions
  const EffectOptions({this.name});
}
