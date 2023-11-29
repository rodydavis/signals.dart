---
title: Watch
description: Watch a signal for changes in Flutter
---

## Watch

To watch a signal for changes in Flutter, use the `Watch` widget. This will only rebuild this widget method and not the entire widget tree.

```dart
final signal = signal(10);
...
@override
Widget build(BuildContext context) {
  return Watch(() => Text('$signal'));
}
```

## SignalWidget

If using a `StatelessWidget` and you want to watch a signal for changes rebuilding the entire widget, use the `SignalWidget` widget.

```diff
final signal = signal(10);
...
- class MyWidget extends StatelessWidget {
+ class MyWidget extends SignalWidget {
  @override
  Widget build(BuildContext context) {
    return Text('$signal');
  }
}
```

## .watch(context)

If you need to map to a widget property use the `watch` extension method. This will infer the type and subscribe to the signal.

```dart
final fontSize = signal(10);
...
@override
Widget build(BuildContext context) {
  return Text('Hello World',
    style: TextStyle(fontSize:fontSize.watch(context)),
  );
}
```

### Rebuilds

To protect against unnecessary rebuilds, the `watch` extension will only subscribe once to the nearest element and mark the widget as dirty.

This means that if you have multiple widgets that are watching the same signal, only the first one will be subscribed to the signal and multiple updates will be batched together.

It is also possible to isolate the rebuilds with the `Builder` widget, however it is recommended to use `Watch` or `SignalWidget` instead.

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
  return Watch(() => Text('$computed'));
}
```
