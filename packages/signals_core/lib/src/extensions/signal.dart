import 'dart:async';

import '../core/signals.dart';

/// Signal extensions
extension ReadonlySignalUtils<T> on ReadonlySignal<T> {
  /// Convert a signal to a [Stream] to be consumed as
  /// a read only stream and also be used in a [StreamBuilder]
  Stream<T> toStream() {
    // ignore: close_sinks
    final controller = StreamController<T>();
    controller.add(value);
    subscribe((_) => controller.add(value));
    return controller.stream;
  }
}

/// Mutable signal utils
extension SignalUtils<T> on Signal<T> {
  /// Restrict API to readonly signal
  ReadonlySignal<T> toReadonlySignal() => this;
}
