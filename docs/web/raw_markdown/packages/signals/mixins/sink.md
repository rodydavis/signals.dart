---
title: SinkSignalMixin
description: A mixin that implements the standard **Sink** interface for a Signal.
---

A mixin that implements the standard **Sink** interface for a [Signal](/packages/signals/core/signal).

This mixin allows you to treat a writable [Signal](/packages/signals/core/signal) as a sink of events, where
adding an element using **add** automatically updates the signal's value and
notifies all reactive listeners. Calling **close** automatically disposes
the signal, freeing up resources and removing all active subscriptions.

This provides excellent compatibility with streams, transformers, or any
APIs that expect a standard Dart **Sink**.

### Example Usage

```dart
import 'package:signals/signals.dart';

class MySinkSignal extends Signal<int> with SinkSignalMixin<int> {
  MySinkSignal(super.internalValue);
}

void main() {
  final signal = MySinkSignal(0);

  effect(() {
    print('Signal value changed to: ${signal.value}');
  }); // Prints: "Signal value changed to: 0"

  // Treat it as a Sink and push elements to it
  signal.add(42); // Prints: "Signal value changed to: 42"
  signal.add(100); // Prints: "Signal value changed to: 100"

  // Dispose the signal when finished
  signal.close();
  print('Is disposed: ${signal.disposed}'); // Prints: "Is disposed: true"
}
```

<Warning>
Once **close** is called, the signal is permanently disposed and cannot be reused
or written to anymore. Any subsequent **add** calls will throw an exception.
</Warning>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="add"></a>`void add(T event)`

##### <a name="close"></a>`void close()`

</details>
