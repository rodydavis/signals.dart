import 'package:flutter/material.dart';
import 'package:signals_core/signals_core.dart';

import '../watch/watch.dart';

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

  /// Stop subscriptions to updates on a signal for watchers
  void unwatch(BuildContext context) {
    unwatchSignal(context, this);
  }
}
