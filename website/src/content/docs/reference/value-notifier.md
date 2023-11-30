---
title: ValueNotifier
description: Easy conversion between ValueNotifier and Signal
---

## MutableSignal from ValueNotifier

To create a mutable signal from a `ValueNotifier`, use the `toSignal` extension:

```dart
final notifier = ValueNotifier(10);
final signal = notifier.toSignal();
```

> Setting the value on the signal or notifier will update the other.

## ValueNotifier from MutableSignal

To create a `ValueNotifier` from a mutable signal, use the `toValueNotifier` extension:

```dart
final signal = Signal(10);
final notifier = signal.toValueNotifier();
```

> Setting the value on the signal or notifier will update the other.
