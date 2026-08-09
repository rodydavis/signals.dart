# class `SinkSignalMixin`

A mixin that implements the standard **Sink** interface for a [Signal](/types/signal).

This mixin allows you to treat a writable [Signal](/types/signal) as a sink of events, where
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
Once <strong>close</strong> is called, the signal is permanently disposed and cannot be reused
or written to anymore. Any subsequent <strong>add</strong> calls will throw an exception.
</Warning>

---

## Members of `SinkSignalMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | `method` | `void add(T event)` |  |
| **close** | `method` | `void close()` |  |
