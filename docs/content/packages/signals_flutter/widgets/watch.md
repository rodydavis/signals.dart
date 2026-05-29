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

##### <a name="watch"></a><a name="watch"></a><code>Watch(this.builder, {super.key, this.debugLabel, this.dependencies = const []})</code>

Minimal builder for signal changes that rerender a widget tree.

```dart
final counter = signal(0);
...
Watch((context) => Text('$counter'))
```

##### <a name="watch-builder"></a><a name="builder"></a><code>Watch.builder({super.key, required this.builder, this.debugLabel, this.dependencies = const []})</code>

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

##### <a name="builder"></a><code>T Function(BuildContext context) builder</code>

The widget to rebuild when any signals change

##### <a name="debuglabel"></a><code>String? debugLabel</code>

Optional debug label to use for devtools

##### <a name="dependencies"></a><code>List<core.ReadonlySignal<dynamic>> dependencies</code>

List of optional dependencies to watch

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a><code>Widget build(BuildContext context)</code>

</details>
