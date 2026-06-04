---
title: "Type: SinkSignalMixin"
description: "API reference and details for SinkSignalMixin from signals.dart."
---

# SinkSignalMixin

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: SinkSignalMixin

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

### Members of SinkSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | <code>method</code> | <code>dart void add(T event)</code> |  |
| **close** | <code>method</code> | <code>dart void close()</code> |  |

## References

The **SinkSignalMixin** type is referenced and used in the following pages:

* [ValueNotifier](/guides/value-notifier) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [SinkSignalMixin](/packages/signals_flutter/mixins/sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [signals_flutter](/packages/signals_flutter)
* [SinkSignalMixin](/packages/signals_core/mixins/sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [signals_core](/packages/signals_core)
* [SinkSignalMixin](/packages/signals/mixins/sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals](/packages/signals)

