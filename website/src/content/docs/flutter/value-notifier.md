---
title: ValueNotifier
description: Easy conversion between ValueNotifier and Signal
sidebar:
  order: 2
  badge:
    text: Updated
    variant: note
---

:::tip
As of Signals 6.0.0 any Signal created with the flutter import implement ValueNotifier by default.

```dart
import 'package:signals/signals_flutter.dart';

final count = signal(0);
assert(count is Signal<int>);
assert(count is ValueNotifier<int>);
```

You can replace any `ValueNotifier` with a `Signal` and implement both APIs.

```diff
- import 'package:flutter/foundation.dart';
+ import 'package:signals/signals_flutter.dart';
- final count = ValueNotifier(0);
+ final count = signal(0);

count.addListener(() => print(count.value));
count.value = 1;
print(count.value);
count.notifyListeners();
count.dispose();
```
:::

To create a mutable signal from a `ValueNotifier`, use the `toSignal` extension:

```dart
final notifier = ValueNotifier(10);
final signal = notifier.toSignal();
```

Setting the value on the signal or notifier will update the other.
