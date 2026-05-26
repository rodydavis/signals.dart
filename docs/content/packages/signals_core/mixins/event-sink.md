---
title: EventSinkSignalMixin
description: A mixin that implements the standard **EventSink** interface for a Signal.
---

A mixin that implements the standard **EventSink** interface for a [Signal](/packages/signals/core/signal)
holding an [AsyncState](/packages/signals/async/state) value.

This mixin is designed specifically to interface with **Stream** consumers or
other asynchronous data producers. It maps **add** to <code>AsyncState.data(...)</code>,
**addError** to <code>AsyncState.error(...)</code>, and **close** to disposing the signal.

<Info>
This mixin only works with signals whose value is of type [AsyncState<T>](/packages/signals/async/state).
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyEventSinkSignal extends Signal<AsyncState<int>> with EventSinkSignalMixin<int> {
  MyEventSinkSignal(int initialValue) : super(AsyncState.data(initialValue));
}

void main() {
  final signal = MyEventSinkSignal(0);

  effect(() {
    final state = signal.value;
    state.map(
      data: (val) => print('Data received: $val'),
      error: (err, stack) => print('Error occurred: $err'),
      loading: () => print('Loading...'),
    );
  }); // Prints: "Data received: 0"

  // Treat it as an EventSink and add data
  signal.add(10); // Prints: "Data received: 10"

  // Push an error event
  signal.addError(Exception('Failure')); // Prints: "Error occurred: Exception: Failure"

  // Close/dispose the sink
  signal.close();
  print('Is disposed: ${signal.disposed}'); // Prints: "Is disposed: true"
}
```

<Warning>
Once **close** is called, the signal is disposed. Trying to call **add** or **addError**
after closing will result in an exception.
</Warning>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="add"></a>`void add(T event)`

##### <a name="adderror"></a>`void addError(Object error, [StackTrace? stackTrace])`

##### <a name="close"></a>`void close()`

</details>
