---
title: WatchBuilder
description: WatchBuilder.
---

## WatchBuilder

To watch a signal for changes in Flutter, use the <code>WatchBuilder</code> widget. This will only rebuild this widget method and not the entire widget tree.

```dart
final signal = signal(10);
...
@override
Widget build(BuildContext context) {
  return WatchBuilder(
    child: const Icon(Icons.add),
    builder: (context, child) => Row(children: [Text('$signal'), child!]),
  );
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="watchbuilder"></a><a name="watchbuilder"></a><code>WatchBuilder({super.key, required this.builder, this.debugLabel, this.dependencies = const [], this.child})</code>

Minimal builder for signal changes that rerender a widget tree.

```dart
final counter = signal(0);
...
WatchBuilder(
  builder: (context, child) => Text('$counter')
)
```

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="builder"></a><code>T Function(BuildContext context, Widget? child) builder</code>

The widget to rebuild when any signals change

##### <a name="debuglabel"></a><code>String? debugLabel</code>

Optional debug label to use for devtools

##### <a name="child"></a><code>Widget? child</code>

Cached widget to pass in

##### <a name="dependencies"></a><code>List<core.ReadonlySignal<dynamic>> dependencies</code>

List of optional dependencies to watch

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a><code>Widget build(BuildContext context)</code>

</details>
