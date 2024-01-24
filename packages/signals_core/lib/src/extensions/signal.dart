import 'dart:async';

import '../core/signals.dart';

/// Signal extensions
extension ReadonlySignalUtils<T> on ReadonlySignal<T> {
  /// Convert a signal to a [Stream] to be consumed as
  /// a read only stream and also be used in a [StreamBuilder]
  Stream<T> toStream({bool broadcast = false}) {
    final controller = StreamController<T>();

    controller.add(value);

    subscribe(controller.add);

    onDispose(controller.close);

    return broadcast
        ? controller.stream.asBroadcastStream()
        : controller.stream;
  }
}

/// Mutable signal utils
extension SignalUtils<T> on Signal<T> {
  /// Restrict API to readonly signal
  ReadonlySignal<T> toReadonlySignal() => this;
}
