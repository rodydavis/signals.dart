import 'dart:async';

import 'signals.dart';

/// Connects a [Stream] to a [MutableSignal].
class Connect<T> {
  Connect(this.signal);
  final MutableSignal<T> signal;
  final Map<int, StreamSubscription> _subscriptions = {};

  /// Connects a [Stream] to a [MutableSignal].
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final c = connect(counter);
  ///
  /// final s1 = Stream.value(1);
  /// final s2 = Stream.value(2);
  ///
  /// c.from(s1).from(s2);
  ///
  /// c.dispose();
  /// ```
  Connect<T> from(
    Stream<T> source, {
    bool? cancelOnError,
  }) {
    final subscription = source.listen(
      (event) {
        signal.value = event;
      },
      onDone: () {
        _subscriptions.removeWhere((key, value) => key == source.hashCode);
      },
      cancelOnError: cancelOnError,
    );
    _subscriptions[source.hashCode] = subscription;
    return this;
  }

  /// Synonym for `from()`
  Connect<T> operator <<(Stream<T> source) => from(source);

  /// Cancels all subscriptions.
  void dispose() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
  }
}

/// Connects a [MutableSignal] to a [Stream].
Connect<T> connect<T>(MutableSignal<T> signal) {
  return Connect(signal);
}
