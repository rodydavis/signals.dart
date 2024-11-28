---
title: SignalsMixin
description: Mixin for State that auto disposes signals
sidebar:
  order: 0
---

SignalsMixin is a mixin for State that auto disposes signals when the widget is removed from the widget tree.

:::note
The mixin requires a `StatefulWidget` for the widget lifecycle methods.
:::

## Signals

Signal, computed, value signals, and async signals can be created with helper methods prefixed with `create*`.

```dart
class _MyState extends State<MyWidget> with SignalsMixin {
  late final count = createSignal(0);
  late final isEven = createComputed(() => signal.value.isEven);
  late final list = createListSignal(0);
}
```

## Effects

Effects can be created with the `createEffect` method. They will get disposed when the widget is removed from the widget tree.

:::danger
Effect can not be created as late field variables because they will never be evaluated.

Example that does not work:
```dart
class _MyState extends State<MyWidget> with SignalsMixin {
  late final effect = createEffect(() => print('Effect created'));
}
```
:::

```dart
class _MyState extends State<MyWidget> with SignalsMixin {
  @override
  void initState() {
    super.initState();
    createEffect(() => print('Effect created'));
  }
}
```
