---
title: Value Listenable To Signal
description: A global helper function to convert a Flutter ValueListenable to a ReadonlySignal.
---

## valueListenableToSignal

A global helper function to convert a Flutter **ValueListenable** to a [ReadonlySignal](/types/readonlysignal).

This helper is a functional equivalent of the <code>toSignal()</code> extension method.

### Example
```dart
final scrollPosition = ValueNotifier(0.0);
final scrollSignal = valueListenableToSignal(scrollPosition);
```
