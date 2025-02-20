import 'dart:async';

import '../core/signals.dart';

final Map<int, Stream<dynamic>> _streamCache = {};

/// Readonly signal extensions
extension ReadonlySignalUtils<T> on ReadonlySignal<T> {
  /// Convert a signal to a [Stream] to be consumed as
  /// a read only stream.
  Stream<T> toStream() {
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
  Computed<R> select<R>(
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

/// Writeable signal extensions
extension WriteableSignalUtils<T> on Signal<T> {
  /// Easy destructure to get and set the value
  ///
  /// ```dart
  /// final counter = signal(0);
  /// ...
  /// final (getCount, setCount) = counter.hooks;
  /// ```
  (T Function(), void Function(T)) get hooks => (get, set);
}
