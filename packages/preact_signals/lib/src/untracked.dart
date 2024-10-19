part of 'signals.dart';

/// Run a callback function that can access signal values without
/// subscribing to the signal updates.
///
/// @param fn The callback function.
/// @returns The value returned by the callback.
T untracked<T>(T Function() fn) {
  final prevContext = evalContext;
  evalContext = null;
  try {
    return fn();
  } finally {
    evalContext = prevContext;
  }
}
