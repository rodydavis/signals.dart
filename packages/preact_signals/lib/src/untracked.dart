part of 'signals.dart';

/// Run a callback function that can access signal values without
/// subscribing to the signal updates.
T untracked<T>(
  /// The callback function
  T Function() fn,
) {
  final prevContext = evalContext;
  evalContext = null;
  try {
    return fn();
  } finally {
    evalContext = prevContext;
  }
}
