---
title: "Type: SignalStatefulHookWidget"
description: "API reference and details for SignalStatefulHookWidget from signals.dart."
---

# SignalStatefulHookWidget

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Class: SignalStatefulHookWidget

A premium stateful widget that both supports Flutter Hooks and implicitly tracks and rebuilds on signal changes.

Stateful counterpart of [SignalHookWidget](/types/signalhookwidget).

### Example Usage
```dart
class CounterWidget extends SignalStatefulHookWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    // Standard flutter hooks work here:
    final controller = useTextEditingController();
    // Reactive signals work here as well:
    final counter = useSignal(0);
    return Column(
      children: [
        TextField(controller: controller),
        Text('Count: $counter'),
        ElevatedButton(
          onPressed: () => counter.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

### Members of SignalStatefulHookWidget

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalStatefulHookWidget** | <code>constructor</code> | <code>dart SignalStatefulHookWidget({super.key})</code> | Constructor for [SignalStatefulHookWidget](/types/signalstatefulhookwidget). |
| **createElement** | <code>method</code> | <code>dart StatefulElement createElement()</code> |  |

## References

The **SignalStatefulHookWidget** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [SignalStatefulHookWidget](/packages/signals_hooks/widgets/signal-stateful-hook-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>

