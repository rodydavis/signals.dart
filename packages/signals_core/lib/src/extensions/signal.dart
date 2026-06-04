import 'dart:async';

import '../core/signals.dart';

final Map<int, Stream<dynamic>> _streamCache = {};

/// Utility extensions on [ReadonlySignal] to bridge reactive programming with asynchronous streams and select sub-states.
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

  /// Select a sub-state value from this signal and return a computed signal that only notifies when that specific sub-state changes.
  ///
  /// This is highly useful for nesting or destructuring complex objects or maps without triggering downstream updates on changes to unrelated fields.
  ///
  /// ```dart
  /// import 'package:signals_core/signals_core.dart';
  ///
  /// final user = signal({'name': 'John', 'age': 30});
  /// final name = user.select((val) => val()['name'] as String);
  ///
  /// effect(() => print('Name changed: ${name.value}'));
  ///
  /// // Unrelated field update: does NOT trigger the name effect!
  /// user.value = {'name': 'John', 'age': 31};
  ///
  /// // Related field update: triggers the name effect!
  /// user.value = {'name': 'Jane', 'age': 31};
  /// ```
  Computed<R> select<R>(
    R Function(ReadonlySignal<T>) selector, [
    ComputedOptions<R>? options,
  ]) {
    return computed(
      () => selector(this),
      options: options,
    );
  }
}

/// Utility extensions on [Signal] providing functional programming wrappers like React-style hooks destructuring.
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
