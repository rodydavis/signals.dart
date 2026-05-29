---
title: "Type: SignalEffect"
description: "API reference and details for SignalEffect from signals.dart."
---

# SignalEffect

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: SignalEffect

A widget that enables executing scoped reactive side-effects inline within the widget tree.

<code>SignalEffect</code> (and its direct type alias **SignalListener**) allows you to run side-effects
(such as showing snackbars, opening dialogs, navigating, or logging metrics) in response
to signal updates, without triggering rebuilds of the child widget tree.

The [effect](/types/effect) callback runs immediately on mount and dynamically tracks any signals accessed
within its scope. The underlying subscription is automatically disposed when this widget
is removed from the tree. You can optionally return a cleanup function (e.g. <code>void Function()</code>)
to run before the next execution or when the widget is disposed.

### Dialog and Snackbar Trigger Example
```dart
final count = signal(0);

class SnackBarTrigger extends StatelessWidget {
  const SnackBarTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalEffect(
      effect: (context) {
        // Triggers whenever 'count' updates:
        if (count.value >= 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Limit reached: ${count.value}!')),
          );
        }
        // Optional: return cleanup callback
        return () => print('Cleaning up effect');
      },
      child: ElevatedButton(
        onPressed: () => count.value++,
        child: const Text('Increment and Watch'),
      ),
    );
  }
}
```

> [!IMPORTANT]
> Do not perform synchronous state changes or trigger widget rebuilds directly inside
> the effect callback to prevent infinite reactive loops.

### Members of SignalEffect

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalEffect** | <code>constructor</code> | <code>dart SignalEffect({dynamic Function(BuildContext context)? effect, @Deprecated('Use effect instead') void Function(BuildContext context)? callback, required this.child, this.debugLabel, super.key})</code> | Creates a [SignalEffect](/types/signaleffect) widget. |
| **effect** | <code>method</code> | <code>dart dynamic Function(BuildContext context) effect</code> | Gets the effect callback to run inside the reactive effect. |
| **child** | <code>field</code> | <code>dart Widget child</code> | The child widget to render. |
| **debugLabel** | <code>field</code> | <code>dart String? debugLabel</code> | Optional debug label for the effect. |
| **createState** | <code>method</code> | <code>dart State<SignalEffect> createState()</code> |  |

## References

The **SignalEffect** type is referenced and used in the following pages:

* [signals_flutter](/packages/signals_flutter)
* [SignalEffect](/packages/signals_flutter/effects/signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/effects)</span>
* [signals](/packages/signals)
* [SignalEffect](/packages/signals/effects/signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals/effects)</span>

