---
title: ValueListenable
description: Easy conversion between ValueListenable and Signal
sidebar:
  order: 2
  badge:
    text: Updated
    variant: note
---

:::tip
As of Signals 6.0.0 any Computed created with the flutter import implement ValueListenable by default.

```dart
import 'package:signals/signals_flutter.dart';

final count = computed(() => 0);
assert(count is Computed<int>);
assert(count is ValueListenable<int>);
```
:::

To create a readonly signal from a `ValueListenable`, use the `toSignal` extension:

```dart
final ValueListenable listenable = ValueNotifier(10);
final signal = listenable.toSignal();
```
