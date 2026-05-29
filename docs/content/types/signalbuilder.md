---
title: "Type: SignalBuilder"
description: "API reference and details for SignalBuilder from signals.dart."
---

# SignalBuilder

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: SignalBuilder

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

### Members of SignalBuilder

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalBuilder** | <code>constructor</code> | <code>dart SignalBuilder({super.key, required this.builder, this.dependencies = const []})</code> | Creates a [SignalBuilder](/types/signalbuilder) widget. |
| **builder** | <code>field</code> | <code>dart Widget Function(BuildContext context) builder</code> | The widget to rebuild when any signals change. |
| **dependencies** | <code>field</code> | <code>dart List<core.ReadonlySignal<dynamic>> dependencies</code> | List of optional dependencies to watch. |
| **build** | <code>method</code> | <code>dart Widget build(BuildContext context)</code> |  |

## References

The **SignalBuilder** type is referenced and used in the following pages:

* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [signals_flutter](/packages/signals_flutter)
* [Watch](/packages/signals_flutter/widgets/watch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalWidget](/packages/signals_flutter/widgets/signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalBuilder](/packages/signals_flutter/widgets/signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalsAvoidDeprecatedWatchExtension](/packages/signals_lint/flutter/signals-avoid-deprecated-watch-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [WrapWithSignalBuilder](/packages/signals_lint/flutter/wrap-with-signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsAvoidDeprecatedSignalsMixin](/packages/signals_lint/flutter/signals-avoid-deprecated-signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsPreferNamedBuilder](/packages/signals_lint/flutter/signals-prefer-named-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [MigrateWatchToSignalBuilder](/packages/signals_lint/flutter/migrate-watch-to-signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals](/packages/signals)
* [Watch](/packages/signals/widgets/watch) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalWidget](/packages/signals/widgets/signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalBuilder](/packages/signals/widgets/signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>

