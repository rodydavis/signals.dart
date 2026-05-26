---
title: SignalAnimatedBuilder
description: A reactive builder widget designed for performance optimizations using child caching.
---

A reactive builder widget designed for performance optimizations using child caching.

`SignalAnimatedBuilder` is the modern, drop-in replacement for Flutter's native **AnimatedBuilder**
or the deprecated `WatchBuilder`.

When you have a complex or computationally heavy widget subtree that does *not* depend on
any signal values, you should pass it as the **child** parameter. This subtree is cached
and is *never* rebuilt when the signals mutate, delivering a massive rendering boost.

### Performance Optimization Example
```dart
final count = signal(0);

class OptimizedCounter extends StatelessWidget {
  const OptimizedCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignalAnimatedBuilder(
        // 1. Define the heavy subtree once. It will be cached:
        child: const HeavyComplexSubtreeWidget(),

        // 2. The builder receives the cached child:
        builder: (context, cachedChild) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dynamic Count: ${count.value}'),
              const SizedBox(height: 20),
              // 3. Render the cached child directly:
              cachedChild!,
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

> [!TIP]
> Always use `SignalAnimatedBuilder` when rendering dynamic signal values alongside static,
> heavy subtrees. This minimizes CPU cycles and avoids rebuilding static layouts on frame updates.


### Constructors

##### <a name="signalanimatedbuilder"></a><a name="signalanimatedbuilder"></a>`SignalAnimatedBuilder({super.key, required this.builder, this.child, this.debugLabel, this.dependencies = const []})`

Creates a [SignalAnimatedBuilder](/packages/signals/flutter/watch) widget.

The **builder** constructs the widget tree around the cached **child**.
The **dependencies** is an optional list of signals to watch explicitly.


### Properties

##### <a name="builder"></a>`Widget Function(BuildContext context, Widget? child) builder`

The widget to rebuild when any signals change.

##### <a name="child"></a>`Widget? child`

Optional pre-built child subtree that does not rebuild.

##### <a name="debuglabel"></a>`String? debugLabel`

Optional debug label to use for devtools.

##### <a name="dependencies"></a>`List<core.ReadonlySignal<dynamic>> dependencies`

List of optional dependencies to watch.


### Methods

##### <a name="build"></a>`Widget build(BuildContext context)`



---

## SignalBuilder

A premium, surgical builder widget that rebuilds locally on signal changes.

`SignalBuilder` tracks any signals read dynamically within its `builder` callback and
automatically subscribes to them. When any of these signals update, only the `SignalBuilder`
is rebuilt, preventing costly rebuilds of the surrounding widget subtree.

This widget provides predictable, immediate, and memory-safe subscription management,
automatically tearing down all active signal subscriptions when the builder is unmounted.

### Surgical Counter Example
```dart
final count = signal(0);

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This static text never rebuilds!'),
            const SizedBox(height: 20),
            // Only this specific Text widget rebuilds when 'count' changes:
            SignalBuilder(
              builder: (context) => Text(
                'Count: ${count.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

> [!TIP]
> Keep `SignalBuilder` widgets as small and leaf-level as possible in your tree to maximize
> rendering performance.


### Constructors

##### <a name="signalbuilder"></a><a name="signalbuilder"></a>`SignalBuilder({super.key, required this.builder, this.dependencies = const []})`

Creates a [SignalBuilder](/packages/signals/flutter/watch) widget.

The **builder** is called to construct the widget tree and tracks read signals.
The optional **dependencies** allows explicitly specifying a list of signals to watch
regardless of whether they are read during the build phase.


### Properties

##### <a name="builder"></a>`Widget Function(BuildContext context) builder`

The widget to rebuild when any signals change.

##### <a name="dependencies"></a>`List<core.ReadonlySignal<dynamic>> dependencies`

List of optional dependencies to watch.


### Methods

##### <a name="build"></a>`Widget build(BuildContext context)`



---

## Watch

A deprecated widget for watching signal changes in the widget tree.

<Warning>
**DEPRECATED**: Use [SignalBuilder](/packages/signals/flutter/watch) instead for superior, self-contained reactivity
and consistent API design.
</Warning>

### Migration to [SignalBuilder](/packages/signals/flutter/watch)
```dart
// Deprecated legacy pattern:
Watch((context) => Text('$counter'))

// Modern, streamlined pattern:
SignalBuilder(builder: (context) => Text('${counter.value}'))
```


### Constructors

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


### Properties

##### <a name="builder"></a>`T Function(BuildContext context) builder`

The widget to rebuild when any signals change

##### <a name="debuglabel"></a>`String? debugLabel`

Optional debug label to use for devtools

##### <a name="dependencies"></a>`List<core.ReadonlySignal<dynamic>> dependencies`

List of optional dependencies to watch


### Methods

##### <a name="build"></a>`Widget build(BuildContext context)`



---

## WatchBuilder

## WatchBuilder

To watch a signal for changes in Flutter, use the `WatchBuilder` widget. This will only rebuild this widget method and not the entire widget tree.

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

##### <a name="watchbuilder"></a><a name="watchbuilder"></a>`WatchBuilder({super.key, required this.builder, this.debugLabel, this.dependencies = const [], this.child})`

Minimal builder for signal changes that rerender a widget tree.

```dart
final counter = signal(0);
...
WatchBuilder(
  builder: (context, child) => Text('$counter')
)
```


### Properties

##### <a name="builder"></a>`T Function(BuildContext context, Widget? child) builder`

The widget to rebuild when any signals change

##### <a name="debuglabel"></a>`String? debugLabel`

Optional debug label to use for devtools

##### <a name="child"></a>`Widget? child`

Cached widget to pass in

##### <a name="dependencies"></a>`List<core.ReadonlySignal<dynamic>> dependencies`

List of optional dependencies to watch


### Methods

##### <a name="build"></a>`Widget build(BuildContext context)`



---

## FlutterReadonlySignalUtils

Signal extensions for watching value changes on BuildContext.


### Methods

##### <a name="watch"></a>`T watch(BuildContext context, {String? debugLabel})`

Rebuild the **Element** that the current signal is inside of.

##### <a name="unwatch"></a>`void unwatch(BuildContext context)`

Stop subscriptions to updates on a signal for watchers.
