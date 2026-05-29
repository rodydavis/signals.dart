---
title: Watch
description: A deprecated widget for watching signal changes in the widget tree.
---

A deprecated widget for watching signal changes in the widget tree.

<Warning>
  <strong>DEPRECATED</strong>: Use <a href="/types/signalbuilder">SignalBuilder</a> instead for superior, self-contained reactivity
  and consistent API design.
</Warning>

### Migration to [SignalBuilder](/types/signalbuilder)
```dart
// Deprecated legacy pattern:
Watch((context) => Text('$counter'))

// Modern, streamlined pattern:
SignalBuilder(builder: (context) => Text('${counter.value}'))
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="watch"></a><a name="watch"></a>`Watch(this.builder, {super.key, this.debugLabel, this.dependencies = const []})`

Minimal builder for signal changes that rerender a widget tree.

```dart
final counter = signal(0);
...
Watch((context) => Text('$counter'))
```

##### <a name="watch-builder"></a><a name="builder"></a>`Watch.builder({super.key, required this.builder, this.debugLabel, this.dependencies = const []})`

Drop in replacement for the Flutter builder widget.

```dart
final counter = signal(0);
...
- Builder(
+ Watch.builder(
  builder: (context) {
    return Text('$counter');
  }
)
```

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="builder"></a>`T Function(BuildContext context) builder`

The widget to rebuild when any signals change

##### <a name="debuglabel"></a>`String? debugLabel`

Optional debug label to use for devtools

##### <a name="dependencies"></a>`List<core.ReadonlySignal<dynamic>> dependencies`

List of optional dependencies to watch

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a>`Widget build(BuildContext context)`

</details>
