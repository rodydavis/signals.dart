---
title: ValueListenable
description: Easy conversion between ValueListenable and Signal
---

## ReadonlySignal from ValueListenable

To create a readonly signal from a `ValueListenable`, use the `toSignal` extension:

```dart
final ValueListenable listenable = ValueNotifier(10);
final signal = listenable.toSignal();
```

## ValueListenable from ReadonlySignal

To create a `ValueListenable` from a readonly signal, use the `toValueListenable` extension:

```dart
final signal = Signal(10);
final listenable = signal.toValueListenable();
```
