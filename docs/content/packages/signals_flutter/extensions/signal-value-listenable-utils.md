---
title: Signal Value Listenable Utils
description: Extension on ValueListenable to seamlessly bridge standard Flutter values to reactive signals.
---

## SignalValueListenableUtils

Extension on **ValueListenable** to seamlessly bridge standard Flutter values to reactive signals.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tosignal"></a><code>ReadonlySignal<T> toSignal({String? debugLabel, bool autoDispose = false})</code>

## ReadonlySignal from ValueListenable

Converted **ValueListenable** objects become readable signals that automatically listen
to the underlying source. When the source updates, the signal updates.

The signal automatically manages the subscription, disposing of the listener when the
signal itself is disposed.

### Example: Converting a ValueNotifier
```dart
final ValueListenable<int> listenable = ValueNotifier(10);
final signal = listenable.toSignal();

print(signal.value); // 10
```

### Example: ValueListenable from ReadonlySignal
To convert back to a standard **ValueListenable** for native Flutter compatibility:
```dart
final signal = Signal(10);
final listenable = signal.toValueListenable();
```

</details>
