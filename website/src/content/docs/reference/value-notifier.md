---
title: ValueNotifier
description: Easy conversion between ValueNotifier and Signal
---

## ValueNotifier from MutableSignal

```dart
final signal = Signal(10);
final notifier = signal.toValueNotifier();
```

> Setting the value on the signal or notifier will update the other.


## MutableSignal from ValueNotifier

```dart
final notifier = ValueNotifier(10);
final signal = notifier.toSignal();
```

> Setting the value on the signal or notifier will update the other.
