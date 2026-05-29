---
title: "Type: SignalHookBuilder"
description: "API reference and details for SignalHookBuilder from signals.dart."
---

# SignalHookBuilder

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Class: SignalHookBuilder

A premium, localized builder widget that behaves exactly like [SignalHookWidget](/types/signalhookwidget)
but in a builder format.

Allows mixing hooks and implicit signal tracking within a localized subtree builder callback.

### Example Usage
```dart
final count = signal(0);

Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: SignalHookBuilder(
        builder: (context) {
          // Call standard hooks inside the builder:
          final controller = useTextEditingController();
          final focusNode = useFocusNode();

          // Access signals implicitly. Only this subtree will rebuild when count changes:
          return Column(
            children: [
              TextField(controller: controller, focusNode: focusNode),
              Text('Counter: ${count.value}'),
            ],
          );
        },
      ),
    ),
  );
}
```

### Members of SignalHookBuilder

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalHookBuilder** | <code>constructor</code> | <code>dart SignalHookBuilder({super.key, required this.builder})</code> | Creates a [SignalHookBuilder](/types/signalhookbuilder) widget. |
| **builder** | <code>field</code> | <code>dart Widget Function(BuildContext context) builder</code> | The widget builder callback. |
| **build** | <code>method</code> | <code>dart Widget build(BuildContext context)</code> |  |

## References

The **SignalHookBuilder** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [SignalHookBuilder](/packages/signals_hooks/widgets/signal-hook-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>

