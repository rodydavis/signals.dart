import 'package:flutter/foundation.dart';
import 'package:signals_core/signals_core.dart' as core;

import '../mixins/value_listenable.dart';
import 'readonly.dart';
import 'options.dart';

/// A signal based on the value of a computation
class FlutterComputed<T> extends core.Computed<T>
    with ValueListenableSignalMixin<T>
    implements ValueListenable<T>, FlutterReadonlySignal<T> {
  /// Options used to create the signal
  final FlutterSignalOptions<T>? options;

  /// Create a new signal that is computed based on the values of other signals.
  ///
  /// The returned computed signal is read-only, and its value is automatically
  /// updated when any signals accessed from within the callback function change.
  FlutterComputed(
    super.internalValue, {
    this.options,
  }) : super(options: options);

  @override
  bool get runCallbackOnListen => options?.runCallbackOnListen ?? false;
}

/// Create a new signal that is computed based on the values of other signals.
///
/// The returned computed signal is read-only, and its value is automatically
/// updated when any signals accessed from within the callback function change.
FlutterComputed<T> computed<T>(
  T Function() compute, {
  FlutterSignalOptions<T>? options,
}) {
  return FlutterComputed<T>(
    compute,
    options: options,
  );
}
