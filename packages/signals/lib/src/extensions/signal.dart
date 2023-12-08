import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../signals.dart';
import '../watch/extension.dart';

/// Signal extensions
extension ReadonlySignalUtils<T> on ReadonlySignal<T> {
  /// Rebuild the [Element] that the current signal is inside of
  T watch(BuildContext context) => watchSignal<T>(context, this);

  /// Convert a signal to [ValueListenable] to be used in builders
  /// and other existing widgets like [ValueListenableBuilder]
  ValueListenable<T> toValueListenable() {
    final notifier = ValueNotifier(this());
    subscribe((_) {
      notifier.value = this();
    });
    return notifier;
  }

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

  /// Convert a [ValueListenable] to [Signal] to be used in builders
  /// and other existing widgets like [ValueListenableBuilder]
  /// and allow for mutation
  ValueNotifier<T> toValueNotifier() {
    final notifier = ValueNotifier(value);
    subscribe((_) => notifier.value = value);
    notifier.addListener(() => value = notifier.value);
    return notifier;
  }
}
