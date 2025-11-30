import 'dart:async';

import 'globals.dart';

/// Run a callback function that can access signal values without
/// subscribing to the signal updates.
T untracked<T>(
  /// The callback function
  T Function() fn,
) {
  return runZoned(fn, zoneValues: {evalContextKey: null});
}
