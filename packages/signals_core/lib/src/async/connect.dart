import 'dart:async';

import '../core/signals.dart';

/// {@template connect}
/// A highly powerful connector utility that allows you to dynamically stream and pipe multiple asynchronous streams directly into a single reactive [Signal].
///
/// The concept is inspired by **Angular Signals** integration with RxJS streams.
///
/// Start with an existing mutable [Signal] and call `connect(signal)` to create a connector instance.
///
/// ### 1. Chaining Streams
/// You can bind multiple streams to feed the same destination signal. The connector will handle the subscription management for all streams seamlessly.
///
/// ```dart
/// final counter = signal(0);
/// final connector = connect(counter);
///
/// final fastStream = Stream.periodic(Duration(seconds: 1), (i) => i);
/// final slowStream = Stream.periodic(Duration(seconds: 5), (i) => i * 10);
///
/// // Values from both streams will be piped into the counter signal!
/// connector.from(fastStream).from(slowStream);
/// ```
///
/// ### 2. The Shift Operator (`<<`)
/// For a more concise and beautiful visual flow, you can use the shift operator (`<<`) to chain streams:
///
/// ```dart
/// final s = signal(0);
/// final c = connect(s);
///
/// c << fastStream << slowStream;
/// ```
///
/// ### 3. Lifecycle and Disposal
/// To avoid memory leaks, make sure to dispose the connector when it is no longer needed. Disposing the connector will automatically cancel all underlying active stream subscriptions.
///
/// ```dart
/// connector.dispose(); // Cancels all stream subscriptions safely
/// ```
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
