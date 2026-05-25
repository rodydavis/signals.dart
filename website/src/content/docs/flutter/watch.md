---
title: Rebuilding on Changes
description: Watch and rebuild Flutter widgets on signal updates
sidebar:
  order: 3
---

In `signals_flutter`, there are multiple ways to rebuild widgets on signal changes. Starting with this release, the recommended patterns have been streamlined to promote superior, self-contained reactivity and high-performance canvas updates.

---

> [!WARNING]
> The legacy `Watch`, `WatchBuilder`, `SignalsMixin`, and the `.watch(context)` extension method have been **deprecated** in favor of modern, clean, and state-of-the-art APIs. Clear migration guides are provided below.

---

## 1. SignalBuilder (Surgical Local Rebuilds)

`SignalBuilder` is the primary, surgical builder widget. It accepts a standard named `builder` callback, tracks any signals read within its scope, and rebuilds **only** that specific block instead of the entire widget tree when a tracked signal updates.

```dart
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

final count = signal(0);

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SignalBuilder(
          builder: (context) => Text(
            'Count: ${count.value}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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

```diff
- Watch((context) => Text('$count'))
+ SignalBuilder(builder: (context) => Text('$count'))
```

```diff
- WatchBuilder(
-   builder: (context, child) => Row(children: [Text('$count'), child!]),
-   child: const Icon(Icons.add),
- )
+ SignalAnimatedBuilder(
+   child: const Icon(Icons.add),
+   builder: (context, child) => Row(children: [Text('$count'), child!]),
+ )
```

### 1.1. SignalAnimatedBuilder (Static Child Caching)

`SignalAnimatedBuilder` is the drop-in replacement for Flutter's native `AnimatedBuilder` or the deprecated `WatchBuilder`.

When you have a massive widget subtree that does *not* depend on any signal values, you should pass it as a pre-built static `child` to `SignalAnimatedBuilder`. This ensures the child subtree is cached and never rebuilt when signal values mutate, yielding a massive rendering performance optimization.

```dart
final count = signal(0);

class OptimizedCounter extends StatelessWidget {
  const OptimizedCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalAnimatedBuilder(
      child: const HugeHeavySubtreeWidget(), // Cached and never rebuilt!
      builder: (context, child) {
        return Column(
          children: [
            Text('Count: ${count.value}'),
            child!, // Used directly without rebuilding the subtree
          ],
        );
      },
    );
  }
}
```

---

## 2. Implicit Reactivity (SignalWidget & SignalStatefulWidget)

For a cleaner, JS-style reactivity experience, you can inherit from **`SignalWidget`** (for stateless widgets) or **`SignalStatefulWidget`** (for stateful widgets). 

These widgets establish a dynamic reactive context directly at the Flutter element layer. Any signal accessed via `.value` inside their `build()` methods is **implicitly tracked** and subscribed to. When a signal changes, only that element is rebuilt.

### SignalWidget Example (Stateless)

```dart
class CounterView extends SignalWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Implicitly tracks 'count' without builders or context watch calls!
    return Text('Count: ${count.value}');
  }
}
```

### SignalStatefulWidget Example (Stateful)

```dart
class CounterControl extends SignalStatefulWidget {
  const CounterControl({super.key});

  @override
  State<CounterControl> createState() => _CounterControlState();
}

class _CounterControlState extends State<CounterControl> {
  final count = signal(0);

  @override
  Widget build(BuildContext context) {
    // Automatically tracked and safely unsubscribed on unmount
    return ElevatedButton(
      onPressed: () => count.value++,
      child: Text('Count: ${count.value}'),
    );
  }
}
```

### Migrating from legacy `SignalsMixin`

The legacy `SignalsMixin` is deprecated because it adds extra stateful widget lifecycle overhead and manual binding. Inheriting from `SignalStatefulWidget` or using `SignalBuilder` inside a normal `StatelessWidget` provides a cleaner, self-contained architecture:

```diff
- class _MyWidgetState extends State<MyWidget> with SignalsMixin {
-   late final count = createSignal(0);
-   ...
-   Widget build(BuildContext context) {
-     return Text('$count');
-   }
- }
+ class _MyWidgetState extends State<MyWidget> {
+   final count = signal(0);
+   ...
+   Widget build(BuildContext context) {
+     return SignalBuilder(builder: (context) => Text('${count.value}'));
+   }
+ }
```

---

## 3. High-Performance GPU Rendering (SignalCustomPaint)

If you are running high-performance rendering or animations (e.g. game loops, custom charts, canvas particle systems), rebuilding the widget tree is often too expensive.

`SignalCustomPaint` and `SignalPainterWidget` allow you to bypass the widget layout and build lifecycles entirely. When the signal changes, the custom painter directly triggers a `RenderObject` paint cycle (`markNeedsPaint()`) on the GPU, completely skipping Flutter's widget build phase!

```dart
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

final offset = signal(const Offset(0, 0));

class ParticleCanvas extends StatelessWidget {
  const ParticleCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalCustomPaint(
      painter: StarPainter(offset),
      child: const SizedBox.expand(),
    );
  }
}

class StarPainter extends SignalCustomPainter {
  StarPainter(this.offsetSignal) : super(signals: [offsetSignal]);

  final ReadonlySignal<Offset> offsetSignal;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.amber;
    // Inside the paint cycle, ALWAYS use .peek() to avoid active context corruption!
    canvas.drawCircle(offsetSignal.peek(), 20.0, paint);
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}
```

---

## 4. Scoped Side-Effects (SignalEffect / SignalListener)

Sometimes, you need to execute reactive side-effects inline within the widget tree (e.g. showing a snackbar, popping a dialog, navigating to a new route, or logging telemetry) without actually triggering rebuilds of the child widget tree.

`SignalEffect` (and its direct type alias `SignalListener`) allows you to define a reactive callback inline. It executes immediately on mount, automatically tracks any signals read within its scope, and disposes of the underlying effect subscription immediately when the widget is unmounted from the tree.

```dart
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

final count = signal(0);

class EventNotifier extends StatelessWidget {
  const EventNotifier({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalEffect(
      callback: (context) {
        // Runs whenever 'count' changes!
        if (count.value >= 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Count reached ${count.value}!')),
          );
        }
      },
      child: ElevatedButton(
        onPressed: () => count.value++,
        child: const Text('Increment Count'),
      ),
    );
  }
}
```

### SignalListener Type Alias

For developers coming from other libraries, `SignalListener` is a direct type alias for `SignalEffect`, offering a clean and familiar naming convention:

```dart
SignalListener(
  callback: (context) {
    print('Signal value changed to: ${mySignal.value}');
  },
  child: const MyWidget(),
)
```

---

## 5. Legacy .watch(context) Extension (Not Recommended)

For backward-compatibility, the `.watch(context)` and `.unwatch(context)` extensions are still fully supported under the hood. They employ a memory-safe **Weak-Finalizer & Expando** system. 

```dart
@override
Widget build(BuildContext context) {
  // Deprecated: Use SignalBuilder instead
  return Text('Count: ${count.watch(context)}');
}
```

> [!IMPORTANT]
> The `.watch(context)` extension relies on Dart VM garbage collection to cleanly release signal subscriptions when elements are removed from the tree. For predictable, deterministic, and immediate subscription teardown, prefer `SignalBuilder` or `SignalWidget`/`SignalStatefulWidget` instead.
