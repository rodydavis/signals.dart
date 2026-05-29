# class `SignalAnimatedBuilder`

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

---

## Members of `SignalAnimatedBuilder`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalAnimatedBuilder** | `constructor` | `SignalAnimatedBuilder({super.key, required this.builder, this.child, this.debugLabel, this.dependencies = const []})` | Creates a [SignalAnimatedBuilder](/types/signalanimatedbuilder) widget.

The **builder** constructs the widget tree around the cached **child**.
The **dependencies** is an optional list of signals to watch explicitly. |
| **builder** | `field` | `Widget Function(BuildContext context, Widget? child) builder` | The widget to rebuild when any signals change. |
| **child** | `field` | `Widget? child` | Optional pre-built child subtree that does not rebuild. |
| **debugLabel** | `field` | `String? debugLabel` | Optional debug label to use for devtools. |
| **dependencies** | `field` | `List<core.ReadonlySignal<dynamic>> dependencies` | List of optional dependencies to watch. |
| **build** | `method` | `Widget build(BuildContext context)` |  |
