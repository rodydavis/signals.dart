---
title: "Type: SignalHookWidget"
description: "API reference and details for SignalHookWidget from signals.dart."
---

# SignalHookWidget

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Class: SignalHookWidget

A premium reactive widget that both supports Flutter Hooks and implicitly tracks and rebuilds on signal changes.

<code>SignalHookWidget</code> establishes a dynamic reactive context directly at the Flutter element layer.
Any signal accessed via <code>.value</code> inside the **build** method is **implicitly tracked** and
subscribed to. At the same time, you can call any hooks (like <code>useFocusNode</code>, <code>useTextEditingController</code>, etc.)
within **build**.

This provides the ultimate developer experience, combining the power of implicit, boilerplate-free
signal tracking with the rich lifecycle management of Flutter Hooks.

### Dual Reactivity Example
```dart
final globalCartCount = signal(0);

class MyDualWidget extends SignalHookWidget {
  const MyDualWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Declare hooks seamlessly:
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final localCounter = useSignal(0);

    // 2. Implicit tracking of external/global signals:
    // No .watch(context) needed! Just accessing .value tracks it.
    return Column(
      children: [
        TextField(controller: controller, focusNode: focusNode),
        Text('Global Signal: ${globalCartCount.value}'),
        Text('Local Signal: ${localCounter.value}'),
      ],
    );
  }
}
```

### Members of SignalHookWidget

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalHookWidget** | <code>constructor</code> | <code>dart SignalHookWidget({super.key})</code> | Constructor for [SignalHookWidget](/types/signalhookwidget). |
| **createElement** | <code>method</code> | <code>dart StatelessElement createElement()</code> |  |
| **build** | <code>method</code> | <code>dart Widget build(BuildContext context)</code> | Subclasses override this method to define their widget tree. |
| **buildWidget** | <code>method</code> | <code>dart Widget buildWidget(BuildContext context)</code> | Subclasses override this method instead of **build** to define their widget tree. |

## References

The **SignalHookWidget** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [SignalStatefulHookWidget](/packages/signals_hooks/widgets/signal-stateful-hook-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>
* [SignalHookBuilder](/packages/signals_hooks/widgets/signal-hook-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>
* [SignalHookWidget](/packages/signals_hooks/widgets/signal-hook-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>

