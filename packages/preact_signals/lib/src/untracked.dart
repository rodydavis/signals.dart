import 'dart:async';

import 'globals.dart';

/// Run a callback function that can access signal values without
/// subscribing to the signal updates.
T untracked<T>(
  /// The callback function
  T Function() fn,
) {
  if (Zone.current[evalContextKey] != null) {
    return runZoned(
      () {
        final prev = globalEvalContext;
        globalEvalContext = null;
        try {
          return fn();
        } finally {
          globalEvalContext = prev;
        }
      },
      zoneValues: {evalContextKey: null},
    );
  }
  final prev = globalEvalContext;
  globalEvalContext = null;
  try {
    return fn();
  } finally {
    globalEvalContext = prev;
  }
}
