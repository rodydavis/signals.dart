import 'equality.dart';

/// Base configuration options for reactive components and signals.
///
/// Contains common options across all signals, computed values, and effects,
/// such as the debug [name].
abstract class SignalOptionsBase {
  /// The name for debugging, tracing, and DevTools inspection.
  final String? name;

  /// Creates a new [SignalOptionsBase] instance.
  const SignalOptionsBase({this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignalOptionsBase && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

/// Configuration options for reactive [Effect]s.
///
/// Permits naming the effect for debugging, performance profiling,
/// and tracing within the signals developer tools.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final count = signal(0);
///
/// final logger = effect(
///   () => print('Count changed to: ${count.value}'),
///   options: const EffectOptions(name: 'counter-logger'),
/// );
/// ```
class EffectOptions extends SignalOptionsBase {
  /// Creates a new [EffectOptions] instance.
  const EffectOptions({super.name});

  /// Creates a copy of this options with custom overrides.
  EffectOptions copyWith({String? name}) {
    return EffectOptions(name: name ?? this.name);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EffectOptions && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

/// Configuration options for a [ReadonlySignal].
///
/// Allows intercepting the signal's active subscription state changes
/// via [watched] and [unwatched] callback event listeners. This is extremely useful
/// for initiating or canceling active background fetching, web sockets, or timer loops.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final stockTicker = signal(
///   0.0,
///   options: ReadonlySignalOptions(
///     name: 'stock-ticker',
///     watched: () => print('Stock Ticker is actively being listened to!'),
///     unwatched: () => print('No more listeners, sleeping the ticker.'),
///   ),
/// );
/// ```
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

  /// Creates a copy of this options with custom overrides.
  ReadonlySignalOptions<T> copyWith({
    String? name,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return ReadonlySignalOptions<T>(
      name: name ?? this.name,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReadonlySignalOptions<T> &&
        other.name == name &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(name, watched, unwatched);
}

/// Configuration options for a [Signal].
///
/// Extends [ReadonlySignalOptions] to also support custom [equality] checkers,
/// which control whether incoming values trigger update events.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final items = signal(
///   [1, 2, 3],
///   options: SignalOptions(
///     name: 'item-list',
///     equality: SignalEquality.deep(),
///     watched: () => print('Items watch active'),
///     unwatched: () => print('Items watch inactive'),
///   ),
/// );
/// ```
class SignalOptions<T> extends ReadonlySignalOptions<T> {
  /// Signal equality check strategy
  final SignalEquality<T> _equalityCheck;

  /// Get the active equality check
  SignalEquality<T> get equalityCheck => _equalityCheck;

  /// Creates a new [SignalOptions] instance.
  const SignalOptions({
    super.name,
    super.watched,
    super.unwatched,
    SignalEquality<T>? equality,
  }) : _equalityCheck = equality ?? const SignalStandardEquality<Never>();

  @override
  SignalOptions<T> copyWith({
    String? name,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return SignalOptions<T>(
      name: name ?? this.name,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
      equality: _equalityCheck,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignalOptions<T> &&
        other.name == name &&
        other.watched == watched &&
        other.unwatched == unwatched &&
        other._equalityCheck == _equalityCheck;
  }

  @override
  int get hashCode => Object.hash(name, watched, unwatched, _equalityCheck);
}

/// Configuration options for a [Computed] signal.
///
/// Enables configuring debugging names and subscription state event listeners
/// for computed derivations.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final count = signal(0);
/// final doubleCount = computed(
///   () => count.value * 2,
///   options: ComputedOptions(
///     name: 'double-count',
///     watched: () => print('Computed doubleCount is active'),
///     unwatched: () => print('Computed doubleCount is inactive'),
///   ),
/// );
/// ```
class ComputedOptions<T> extends ReadonlySignalOptions<T> {
  /// Creates a new [ComputedOptions] instance.
  const ComputedOptions({
    super.name,
    super.watched,
    super.unwatched,
  });

  @override
  ComputedOptions<T> copyWith({
    String? name,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return ComputedOptions<T>(
      name: name ?? this.name,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ComputedOptions<T> &&
        other.name == name &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(name, watched, unwatched);
}
