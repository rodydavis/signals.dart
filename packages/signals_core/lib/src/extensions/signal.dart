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

  /// Select a value and return a computed signal to listen for changes
  ///
  /// ```dart
  /// final a = signal({'a': 1, 'b': 2});
  /// final b = a.select((val) => val()['a'] as int);
  /// ```
  ReadonlySignal<R> select<R>(R Function(ReadonlySignal<T>) selector) {
    return computed(() => selector(this));
  }
}

/// Mutable signal utils
extension SignalUtils<T> on Signal<T> {
  /// Restrict API to readonly signal
  @Deprecated('use [readonly] instead')
  ReadonlySignal<T> toReadonlySignal() => this;
}
