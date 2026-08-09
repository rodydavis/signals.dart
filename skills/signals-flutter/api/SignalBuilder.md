# class `SignalBuilder`

A premium, surgical builder widget that rebuilds locally on signal changes.

<code>SignalBuilder</code> tracks any signals read dynamically within its <code>builder</code> callback and
automatically subscribes to them. When any of these signals update, only the <code>SignalBuilder</code>
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
> Keep <code>SignalBuilder</code> widgets as small and leaf-level as possible in your tree to maximize
> rendering performance.

---

## Members of `SignalBuilder`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalBuilder** | `constructor` | `SignalBuilder({super.key, required this.builder, this.dependencies = const []})` | Creates a [SignalBuilder](/types/signalbuilder) widget.

The **builder** is called to construct the widget tree and tracks read signals.
The optional **dependencies** allows explicitly specifying a list of signals to watch
regardless of whether they are read during the build phase. |
| **builder** | `field` | `Widget Function(BuildContext context) builder` | The widget to rebuild when any signals change. |
| **dependencies** | `field` | `List<core.ReadonlySignal<dynamic>> dependencies` | List of optional dependencies to watch. |
| **build** | `method` | `Widget build(BuildContext context)` |  |
