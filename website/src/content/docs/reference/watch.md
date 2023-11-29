---
title: Watch
description: Watch a signal for changes in Flutter
---

To watch a signal for changes in Flutter, use the `watch` extension.

```dart
final signal = signal(10);
...
@override
Widget build(BuildContext context) {
  final count = signal.watch(context);
  return Text('$count');
}
```

## Rebuilds

To protect against unnecessary rebuilds, the `watch` extension will only subscribe once to the nearest element and mark the widget as dirty.

This means that if you have multiple widgets that are watching the same signal, only the first one will be subscribed to the signal and multiple updates will be batched together.

It is also possible to isolate the rebuilds with the `Builder` widget.

```dart
final signal = signal(10);
...
@override
Widget build(BuildContext context) {
  // Called once
  return Column(
    children: [
      Builder(
        builder: (context) {
          // Called every time the signal changes
          final count = signal.watch(context);
          return Text('$count');
        },
      ),
      Text('Not rebuilt'),
    ],
  );
}
```

## Selectors

With signals instead of using `select` you instead create a new `computed` signal that is derived from the original signal.

```dart
final signal = signal((a: 1, b: 2));
final computed = computed(() => signal.value.a);
...
@override
Widget build(BuildContext context) {
  final aCount = computed.watch(context);
  return Text('$aCount');
}
```