import 'dart:async';

import '../core/signals.dart';

final Map<int, Stream<dynamic>> _streamCache = {};

/// Signal extensions
extension ReadonlySignalUtils<T> on ReadonlySignal<T> {
  /// Convert a signal to a [Stream] to be consumed as
  /// a read only stream and also be used in a [StreamBuilder]
  Stream<T> toStream({
    @Deprecated('No longer needed') bool broadcast = false,
  }) {
    final existing = _streamCache[globalId];

    if (existing != null) {
      return existing as Stream<T>;
    }

    final controller = StreamController<T>();

    final stream = controller.stream.asBroadcastStream();

    _streamCache[globalId] = stream;

    subscribe(controller.add);

    onDispose(() {
      _streamCache.remove(globalId);
      controller.close();
    });

    return stream;
  }

  /// Select a value and return a computed signal to listen for changes
  ///
  /// ```dart
  /// final a = signal({'a': 1, 'b': 2});
  /// final b = a.select((val) => val()['a'] as int);
  /// ```
  ReadonlySignal<R> select<R>(
    R Function(ReadonlySignal<T>) selector, {
    bool autoDispose = false,
    String? debugLabel,
  }) {
    return computed(
      () => selector(this),
      autoDispose: autoDispose,
      debugLabel: debugLabel,
    );
  }
}

/// Mutable signal utils
extension SignalUtils<T> on Signal<T> {
  /// Restrict API to readonly signal
  @Deprecated('use [.readonly()] instead')
  ReadonlySignal<T> toReadonlySignal() => this;
}
