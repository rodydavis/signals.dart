import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signals_core/signals_core.dart';

import '../watch/watch.dart';
import '../core/signal_value_listenable.dart';

/// Signal extensions
extension FlutterReadonlySignalUtils<T> on ReadonlySignal<T> {
  /// Rebuild the [Element] that the current signal is inside of
  @Deprecated('use SignalsMixin in StatefulWidget or Watch in StatelessWidget')
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

  /// Stop subscriptions to updates on a signal for watchers
  @Deprecated('use SignalsMixin in StatefulWidget or Watch in StatelessWidget')
  void unwatch(BuildContext context) {
    unwatchSignal(context, this);
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
  @Deprecated('use SignalsMixin in StatefulWidget')
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

  /// Stop subscriptions to updates on a signal for listeners
  @Deprecated('use SignalsMixin in StatefulWidget')
  void unlisten(BuildContext context, void Function() callback) {
    unlistenSignal(context, this, callback);
  }

  /// Convert a signal to [ValueListenable] to be used in builders
  /// and other existing widgets like [ValueListenableBuilder]
  SignalValueListenable<T, ValueListenable<T>, ReadonlySignal<T>>
      toValueListenable() {
    return SignalValueListenable<T, ValueListenable<T>,
        ReadonlySignal<T>>.fromSignal(this);
  }
}

/// Mutable signal utils
extension FlutterSignalUtils<T> on Signal<T> {
  /// Convert a [ValueListenable] to [Signal] to be used in builders
  /// and other existing widgets like [ValueListenableBuilder]
  /// and allow for mutation
  SignalValueNotifier<T> toValueNotifier() {
    return SignalValueNotifier<T>.fromSignal(this);
  }
}
