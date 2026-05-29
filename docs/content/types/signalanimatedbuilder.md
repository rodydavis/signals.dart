---
title: "Type: SignalAnimatedBuilder"
description: "API reference and details for SignalAnimatedBuilder from signals.dart."
---

# SignalAnimatedBuilder

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: SignalAnimatedBuilder

A reactive builder widget designed for performance optimizations using child caching.

<code>SignalAnimatedBuilder</code> is the modern, drop-in replacement for Flutter's native **AnimatedBuilder**
or the deprecated <code>WatchBuilder</code>.

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
> Always use <code>SignalAnimatedBuilder</code> when rendering dynamic signal values alongside static,
> heavy subtrees. This minimizes CPU cycles and avoids rebuilding static layouts on frame updates.

### Members of SignalAnimatedBuilder

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalAnimatedBuilder** | <code>constructor</code> | <code>dart SignalAnimatedBuilder({super.key, required this.builder, this.child, this.debugLabel, this.dependencies = const []})</code> | Creates a [SignalAnimatedBuilder](/types/signalanimatedbuilder) widget. |
| **builder** | <code>field</code> | <code>dart Widget Function(BuildContext context, Widget? child) builder</code> | The widget to rebuild when any signals change. |
| **child** | <code>field</code> | <code>dart Widget? child</code> | Optional pre-built child subtree that does not rebuild. |
| **debugLabel** | <code>field</code> | <code>dart String? debugLabel</code> | Optional debug label to use for devtools. |
| **dependencies** | <code>field</code> | <code>dart List<core.ReadonlySignal<dynamic>> dependencies</code> | List of optional dependencies to watch. |
| **build** | <code>method</code> | <code>dart Widget build(BuildContext context)</code> |  |

## References

The **SignalAnimatedBuilder** type is referenced and used in the following pages:

* [signals_flutter](/packages/signals_flutter)
* [SignalAnimatedBuilder](/packages/signals_flutter/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [signals](/packages/signals)
* [SignalAnimatedBuilder](/packages/signals/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>

