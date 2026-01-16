// ignore_for_file: constant_identifier_names
// Force recompile
import 'package:meta/meta.dart';

import '../devtool.dart';
import '../utils/constants.dart';
import 'dart:developer' as developer;
import 'package:preact_signals/preact_signals.dart' as signals;
export 'package:preact_signals/preact_signals.dart'
    show SignalEquality, linkedSignal, LinkedSignal;

// ignore: implementation_imports
import 'package:preact_signals/src/globals.dart';

part 'observer.dart';
part 'effect.dart';
part 'computed.dart';
part 'signal.dart';
part 'batch.dart';
part 'untracked.dart';
part 'readonly.dart';
part 'auto_dispose.dart';

/// Options for creating a signal
class SignalOptions<T> extends signals.SignalOptions<T> {
  /// Whether to automatically dispose the signal when it has no listeners
  final bool autoDispose;

  /// Options for creating a signal
  const SignalOptions({
    super.name,
    super.equalityCheck,
    super.watched,
    super.unwatched,
    this.autoDispose = false,
  });
}

/// Options for creating an effect
typedef EffectOptions = signals.EffectOptions;

/// Signal usage error
class SignalsError extends Error {
  /// Signals error pretty print message
  final String message;

  /// Signal usage error
  SignalsError(this.message);

  @override
  String toString() => message;
}

/// Error to throw if a signal is read after it is disposed
class SignalsReadAfterDisposeError extends SignalsError {
  /// Error to throw if a signal is read after it is disposed
  SignalsReadAfterDisposeError(ReadonlySignal instance)
      : super(
          'A ${instance.runtimeType} signal was read after being disposed.\n'
          'Once you have called dispose() on a signal, it can no longer be used.',
        );
}

/// Lazy signal must value value set before it is read
class LazySignalInitializationError extends SignalsError {
  /// Lazy signal must value value set before it is read
  LazySignalInitializationError(ReadonlySignal instance)
      : super(
          'A ${instance.runtimeType} lazy signal signal was read before its value was set.',
        );
}

/// Error to throw if a signal is written to after it is disposed
class SignalsWriteAfterDisposeError extends SignalsError {
  /// Error to throw if a signal is written to after it is disposed
  SignalsWriteAfterDisposeError(ReadonlySignal instance)
      : super(
          'A ${instance.runtimeType} signal was written after being disposed.\n'
          'Once you have called dispose() on a signal, it can no longer be used.',
        );
}

/// Cycle detection usually means you have updated
/// a signal inside an effect and are reading by value.
class EffectCycleDetectionError extends Error {}
