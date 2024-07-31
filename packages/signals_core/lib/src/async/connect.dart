import 'dart:async';

import '../core/signals.dart';

/// {@template connect}
/// The idea for `connect` comes from Anguar Signals with RxJS:
/// 
/// <iframe width="560" height="315" src="https://www.youtube.com/embed/R7-KdADEq0A?si=kK8XasbBedE3sPrR" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
/// 
/// Start with a signal and then use the `connect` method to create a connector.
/// Streams will feed Signal value.
/// 
/// ```dart
/// final s = signal(0);
/// final c = connect(s);
/// ```
/// 
/// ### to
/// 
/// Add streams to the connector.
/// 
/// ```dart
/// final s = signal(0);
/// final c = connect(s);
/// 
/// final s1 = Stream.value(1);
/// final s2 = Stream.value(2);
/// 
/// c.from(s1).from(s2); // These can be chained
/// ```
/// 
/// ### dispose
/// 
/// Cancel all subscriptions.
/// 
/// ```dart
/// final s = signal(0);
/// final c = connect(s);
/// 
/// final s1 = Stream.value(1);
/// final s2 = Stream.value(2);
/// 
/// c.from(s1).from(s2);
/// // or
/// c << s1 << s2
/// 
/// c.dispose(); // This will cancel all subscriptions
/// ```
/// @link https://dartsignals.dev/async/connect
/// {@endtemplate}
class Connect<T, S extends T> {
  /// Connects a [Stream] to a [Signal].
  Connect(this.signal);

  /// Internal signal to connect to.
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
  Connect<T, S> from(
    Stream<S> source, {
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
  Connect<T, S> operator <<(Stream<S> source) => from(source);

  /// Cancels all subscriptions.
  void dispose() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _subscriptions.clear();
    signal.dispose();
  }
}

/// {@template connect}
/// The idea for `connect` comes from Anguar Signals with RxJS:
/// 
/// <iframe width="560" height="315" src="https://www.youtube.com/embed/R7-KdADEq0A?si=kK8XasbBedE3sPrR" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
/// 
/// Start with a signal and then use the `connect` method to create a connector.
/// Streams will feed Signal value.
/// 
/// ```dart
/// final s = signal(0);
/// final c = connect(s);
/// ```
/// 
/// ### to
/// 
/// Add streams to the connector.
/// 
/// ```dart
/// final s = signal(0);
/// final c = connect(s);
/// 
/// final s1 = Stream.value(1);
/// final s2 = Stream.value(2);
/// 
/// c.from(s1).from(s2); // These can be chained
/// ```
/// 
/// ### dispose
/// 
/// Cancel all subscriptions.
/// 
/// ```dart
/// final s = signal(0);
/// final c = connect(s);
/// 
/// final s1 = Stream.value(1);
/// final s2 = Stream.value(2);
/// 
/// c.from(s1).from(s2);
/// // or
/// c << s1 << s2
/// 
/// c.dispose(); // This will cancel all subscriptions
/// ```
/// @link https://dartsignals.dev/async/connect
/// {@endtemplate}
Connect<T, S> connect<T, S extends T>(Signal<T> signal, [Stream<S>? stream]) {
  final instance = Connect<T, S>(signal);
  if (stream != null) instance << stream;
  return instance;
}
