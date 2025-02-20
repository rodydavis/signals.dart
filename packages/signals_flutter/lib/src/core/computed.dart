import 'package:flutter/foundation.dart';
import 'package:signals_core/signals_core.dart' as core;

import '../mixins/value_listenable.dart';
import 'readonly.dart';

/// A signal based on the value of a computation
class FlutterComputed<T> extends core.Computed<T>
    with ValueListenableSignalMixin<T>
    implements ValueListenable<T>, FlutterReadonlySignal<T> {
  /// Create a new signal that is computed based on the values of other signals.
  ///
  /// The returned computed signal is read-only, and its value is automatically
  /// updated when any signals accessed from within the callback function change.
  FlutterComputed(
    super.internalValue, {
    super.autoDispose,
    super.debugLabel,
    this.runCallbackOnListen = false,
  });

  @override
  bool runCallbackOnListen;
}

/// Create a new signal that is computed based on the values of other signals.
///
/// The returned computed signal is read-only, and its value is automatically
/// updated when any signals accessed from within the callback function change.
FlutterComputed<T> computed<T>(
  T Function() compute, {
  String? debugLabel,
  bool autoDispose = false,
  bool runCallbackOnListen = false,
}) {
  return FlutterComputed<T>(
    compute,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    runCallbackOnListen: runCallbackOnListen,
  );
}
