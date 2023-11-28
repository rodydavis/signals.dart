import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../signals.dart';
import '../watch_signal.dart';

/// Signal extensions
extension ReadonlySignalUtils<T> on ReadonlySignal<T> {
  /// Rebuild the [Element] that the current signal is inside of
  T watch(BuildContext context) => watchSignal<T>(context, this);

  /// Convert a signal to [ValueListenable] to be used in builders
  /// and other existing widgets like [ValueListenableBuilder]
  ValueListenable<T> listenable() {
    final notifier = ValueNotifier(this());
    subscribe((_) {
      notifier.value = this();
    });
    return notifier;
  }

  /// Convert a signal to a [Stream] to be consumed as
  /// a read only stream and also be used in a [StreamBuilder]
  Stream<T> stream() {
    final controller = StreamController<T>();
    controller.add(value);
    subscribe((_) => controller.add(value));
    return controller.stream;
  }
}

/// Mutable signal utils
extension MutableSignalUtils<T> on MutableSignal<T> {
  /// Restrict API to readonly signal
  ReadonlySignal<T> readonly() => this;

  /// Convert a [ValueListenable] to [MutableSignal] to be used in builders
  /// and other existing widgets like [ValueListenableBuilder]
  /// and allow for mutation
  ValueNotifier<T> notifier() {
    final notifier = ValueNotifier(value);
    subscribe((_) => notifier.value = value);
    notifier.addListener(() => value = notifier.value);
    return notifier;
  }
}
