import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signals_core/signals_core.dart';

import '../watch/extension.dart';

/// Signal extensions
extension FlutterReadonlySignalUtils<T> on ReadonlySignal<T> {
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

  /// Convert a signal to [ValueListenable] to be used in builders
  /// and other existing widgets like [ValueListenableBuilder]
  ValueListenable<T> toValueListenable() {
    final notifier = ValueNotifier(this());
    subscribe((_) {
      notifier.value = this();
    });
    return notifier;
  }
}

/// Mutable signal utils
extension FlutterSignalUtils<T> on Signal<T> {
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
