---
title: Signal Value Notifier Utils
description: Extension on ValueNotifier to seamlessly bridge standard Flutter mutable values to reactive signals.
---

## SignalValueNotifierUtils

Extension on **ValueNotifier** to seamlessly bridge standard Flutter mutable values to reactive signals.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tosignal"></a><code>Signal<T> toSignal({String? debugLabel, bool autoDispose = false})</code>

## Bi-directional Signal and ValueNotifier Interoperability

Converted **ValueNotifier** objects become mutable [Signal](/types/signal) instances. Setting the value
on the signal or the notifier automatically propagates the update to the other.

The subscription is fully memory-safe and automatically unsubscribed when the signal
is disposed.

### Example: Converting a ValueNotifier to a Signal
```dart
final notifier = ValueNotifier(10);
final signal = notifier.toSignal();

signal.value = 20;
print(notifier.value); // 20

notifier.value = 30;
print(signal.value); // 30
```

### Example: Converting a Signal to a ValueNotifier
To bridge back to a standard **ValueNotifier** for Flutter compatibility:
```dart
final signal = Signal(10);
final notifier = signal.toValueNotifier();
```

</details>
