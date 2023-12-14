import 'dart:async';

import 'core/signals.dart';

/// Connects a [Stream] to a [Signal].
class Connect<T> {
  Connect(this.signal);
  final Signal<T> signal;
  final Map<int, StreamSubscription> _subscriptions = {};

  /// Connects a [Stream] to a [Signal].
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
    Function? onError,
    Function? onDone,
    void Function(T)? onValue,
  }) {
    // stop multiple subscriptions to the same stream
    if (_subscriptions.containsKey(source.hashCode)) {
      return this;
    }
    final subscription = source.listen(
      (event) {
        signal.value = event;
        onValue?.call(event);
      },
      onError: onError,
      onDone: () {
        _subscriptions.removeWhere((key, value) => key == source.hashCode);
        onDone?.call();
      },
      cancelOnError: cancelOnError,
    );
    _subscriptions[source.hashCode] = subscription;
    return this;
  }

  /// Synonym for `from(Stream<T> source)`
  Connect<T> operator <<(Stream<T> source) => from(source);

  /// Cancels all subscriptions.
  void dispose() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
  }
}

/// Connects a [Signal] to a [Stream].
Connect<T> connect<T>(Signal<T> signal, [Stream<T>? stream]) {
  final instance = Connect(signal);
  if (stream != null) instance << stream;
  return instance;
}
