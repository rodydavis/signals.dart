---
title: Bi-directional Data Flow
description: By default, Signals are uni-directional but can be used in a bi-directional way if needed.
sidebar:
  order: 4
---

By default, Signals are uni-directional but can be used in a bi-directional way if needed.

:::caution
Bi-directional data flow should only be used when necessary as it can lead to infinite loops if not used correctly.
:::

Consider the following example:

```dart
final a = signal(0);
final b = signal(0);

effect(() {
  b.value = a.value + 1;
});

effect(() {
  a.value = b.value + 1;
});
```

In this example, `a` and `b` are two signals that are dependent on each other. When `a` changes, `b` should update, and when `b` changes, `a` should update.

This however can lead to an infinite loop and will throw a `EffectCycleDetectionError`. To prevent this, you can use the `untracked` method to prevent the signal from updating itself.

```dart
final a = signal(0);
final b = signal(0);

effect(() {
  b.value = untracked(() => a.value + 1);
});

effect(() {
  a.value = untracked(() => b.value + 1);
});
```

This will prevent the infinite loop and allow the signals to update each other without causing an error.

Signals are synchronous and will update immediately when the value is set. This means that the value will be updated before the next effect is run. This allows you to create bi-directional data flow in a predictable way.
