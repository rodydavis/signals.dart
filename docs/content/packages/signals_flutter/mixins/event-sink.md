---
title: EventSinkSignalMixin
description: A mixin that implements the standard EventSink interface for a Signal.
---

A mixin that implements the standard **EventSink** interface for a [Signal](/types/signal)
holding an [AsyncState](/types/asyncstate) value.

This mixin is designed specifically to interface with **Stream** consumers or
other asynchronous data producers. It maps **add** to <code>AsyncState.data(...)</code>,
**addError** to <code>AsyncState.error(...)</code>, and **close** to disposing the signal.

<Info>
This mixin only works with signals whose value is of type <a href="/types/asyncstate">AsyncState<T></a>.
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
Once <strong>close</strong> is called, the signal is disposed. Trying to call <strong>add</strong> or <strong>addError</strong>
after closing will result in an exception.
</Warning>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="add"></a><code>void add(T event)</code>

##### <a name="adderror"></a><code>void addError(Object error, [StackTrace? stackTrace])</code>

##### <a name="close"></a><code>void close()</code>

</details>
