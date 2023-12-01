import 'dart:async';

import 'signals.dart';

/// Connects a [Signal] to a [Stream].
class Connect<T> {
  Connect(this.signal);
  final Signal<T> signal;
  final Map<int, StreamSubscription> _subscriptions = {};

  /// Connects a [Signal] to a [Stream].
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final c = connect(counter);
  ///
  /// final s1 = Stream.value(1);
  /// final s2 = Stream.value(2);
  ///
  /// c.to(s1).to(s2);
  ///
  /// c.dispose();
  /// ```
  Connect<T> to(
    Stream<T> stream, {
    bool? cancelOnError,
  }) {
    final subscription = stream.listen(
      (event) {
        signal.value = event;
      },
      onDone: () {
        _subscriptions.removeWhere((key, value) => key == stream.hashCode);
      },
      cancelOnError: cancelOnError,
    );
    _subscriptions[stream.hashCode] = subscription;
    return this;
  }

  /// Cancels all subscriptions.
  void dispose() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
  }
}

/// Connects a [Signal] to a [Stream].
Connect<T> connect<T>(Signal<T> signal) {
  return Connect(signal);
}
