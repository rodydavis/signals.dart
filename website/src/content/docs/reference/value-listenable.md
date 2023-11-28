---
title: ValueListenable
description: Easy conversion between ValueListenable and Signal
---

## ReadonlySignal from ValueListenable

```dart
final ValueListenable listenable = ValueNotifier(10);
final signal = listenable.toSignal();
```

## ValueListenable from ReadonlySignal

```dart
final signal = Signal(10);
final listenable = signal.toValueListenable();
```
