import 'dart:async';

import '../async/state.dart';
import '../core/signals.dart';

/// A mixin that implements the standard [EventSink] interface for a [Signal]
/// holding an [AsyncState] value.
///
/// This mixin is designed specifically to interface with [Stream] consumers or
/// other asynchronous data producers. It maps [add] to `AsyncState.data(...)`,
/// [addError] to `AsyncState.error(...)`, and [close] to disposing the signal.
///
/// :::note
/// This mixin only works with signals whose value is of type [AsyncState<T>].
/// :::
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// class MyEventSinkSignal extends Signal<AsyncState<int>> with EventSinkSignalMixin<int> {
///   MyEventSinkSignal(int initialValue) : super(AsyncState.data(initialValue));
/// }
///
/// void main() {
///   final signal = MyEventSinkSignal(0);
///
///   effect(() {
///     final state = signal.value;
///     state.map(
///       data: (val) => print('Data received: $val'),
///       error: (err, stack) => print('Error occurred: $err'),
///       loading: () => print('Loading...'),
///     );
///   }); // Prints: "Data received: 0"
///
///   // Treat it as an EventSink and add data
///   signal.add(10); // Prints: "Data received: 10"
///
///   // Push an error event
///   signal.addError(Exception('Failure')); // Prints: "Error occurred: Exception: Failure"
///
///   // Close/dispose the sink
///   signal.close();
///   print('Is disposed: ${signal.disposed}'); // Prints: "Is disposed: true"
/// }
/// ```
///
/// :::caution
/// Once [close] is called, the signal is disposed. Trying to call [add] or [addError]
/// after closing will result in an exception.
/// :::
abstract mixin class EventSinkSignalMixin<T>
    implements Signal<AsyncState<T>>, EventSink<T> {
  @override
  void add(T event) {
    set(AsyncState.data(event));
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    set(AsyncState.error(error, stackTrace));
  }

  @override
  void close() {
    dispose();
  }
}
