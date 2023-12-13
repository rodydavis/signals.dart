import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/signals.dart';
import '../watch/extension.dart';

/// Signal extensions
extension ReadonlySignalUtils<T> on ReadonlySignal<T> {
  /// Rebuild the [Element] that the current signal is inside of
  T watch(
    BuildContext context, {
    String? debugLabel,
  }) {
    return watchSignal<T>(
      context,
      this,
      debugLabel: debugLabel,
    );
  }

  /// Used to listen for updates on a signal but not rebuild the nearest element
  ///
  /// ```dart
  /// final counter = signal(0);
  /// ...
  /// @override
  /// Widget build(BuildContext context) {
  ///   counter.listen(context, () {
  ///     if (counter.value == 10) {
  ///       final messenger = ScaffoldMessenger.of(context);
  ///       messenger.hideCurrentSnackBar();
  ///       messenger.showSnackBar(
  ///         const SnackBar(content: Text('You hit 10 clicks!')),
  ///       );
  ///     }
  ///   });
  /// ...
  /// }
  /// ```
  void listen(
    BuildContext context,
    void Function() callback, {
    String? debugLabel,
  }) {
    listenSignal<T>(
      context,
      this,
      callback,
      debugLabel: debugLabel,
    );
  }

  /// Stop subscriptions to updates on a signal for watchers
  void unwatch(BuildContext context) {
    unwatchSignal(context, this);
  }

  /// Stop subscriptions to updates on a signal for listeners
  void unlisten(BuildContext context) {
    unlistenSignal(context, this);
  }

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
