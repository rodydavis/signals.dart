import 'package:flutter/foundation.dart';
import 'package:signals_core/signals_core.dart' as core;

import 'readonly.dart';

/// A signal based on the value of a computation
class FlutterComputed<T> extends core.Computed<T>
    implements ValueListenable<T>, FlutterReadonlySignal<T> {
  final _listeners = <VoidCallback, void Function()>{};

  /// Create a new signal that is computed based on the values of other signals.
  ///
  /// The returned computed signal is read-only, and its value is automatically
  /// updated when any signals accessed from within the callback function change.
  FlutterComputed(
    super.internalValue, {
    super.autoDispose,
    super.debugLabel,
  });

  @override
  void addListener(VoidCallback listener) {
    _listeners.putIfAbsent(listener, () {
      return subscribe((_) => listener());
    });
  }

  @override
  void removeListener(VoidCallback listener) {
    final cleanup = _listeners.remove(listener);
    cleanup?.call();
  }

  @override
  void dispose() {
    super.dispose();
    _listeners.clear();
  }
}

/// Create a new signal that is computed based on the values of other signals.
///
/// The returned computed signal is read-only, and its value is automatically
/// updated when any signals accessed from within the callback function change.
FlutterComputed<T> computed<T>(
  T Function() compute, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return FlutterComputed<T>(
    compute,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
