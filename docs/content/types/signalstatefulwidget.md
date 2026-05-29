---
title: "Type: SignalStatefulWidget"
description: "API reference and details for SignalStatefulWidget from signals.dart."
---

# SignalStatefulWidget

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: SignalStatefulWidget

A reactive **StatefulWidget** that implicitly tracks and rebuilds on signal changes.

Subclasses of <code>SignalStatefulWidget</code> establish a dynamic reactive context directly at the
Flutter element layer. Any signal value accessed synchronously inside State's **build** method
is **implicitly tracked** and subscribed to. When a signal changes, only that element is rebuilt.

This offers a clean, Javascript-style reactivity experience while retaining all stateful lifecycles.
It is the modern, highly recommended replacement for the legacy, deprecated <code>SignalsMixin</code>.

### Implicit Reactivity Example (Stateful)
```dart
class CounterControl extends SignalStatefulWidget {
  const CounterControl({super.key});

  @override
  State<CounterControl> createState() => _CounterControlState();
}

class _CounterControlState extends State<CounterControl> {
  // Create state signals directly inside the State object:
  final count = signal(0);

  @override
  Widget build(BuildContext context) {
    // Automatically tracked on access and safely unsubscribed on unmount:
    return ElevatedButton(
      onPressed: () => count.value++,
      child: Text('Count: ${count.value}'),
    );
  }
}
```

> [!IMPORTANT]
> Only signals accessed *synchronously* during the execution of the <code>build</code> method are tracked.
> Signals read inside async callbacks, listeners, or deferred tasks are not subscribed to.

### Members of SignalStatefulWidget

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalStatefulWidget** | <code>constructor</code> | <code>dart SignalStatefulWidget({super.key})</code> | Constructor for [SignalStatefulWidget](/types/signalstatefulwidget). |
| **createElement** | <code>method</code> | <code>dart StatefulElement createElement()</code> |  |

## References

The **SignalStatefulWidget** type is referenced and used in the following pages:

* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SignalStatefulElement](/packages/signals_flutter/extensions/signal-stateful-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Stateful Widget Convert Widget Extension](/packages/signals_flutter/extensions/stateful-widget-convert-widget-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [ConvertedSignalStatefulWidget](/packages/signals_flutter/extensions/converted-signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalStatefulWidget](/packages/signals_flutter/extensions/signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalsAvoidDeprecatedWatchExtension](/packages/signals_lint/flutter/signals-avoid-deprecated-watch-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [ConvertStatefulToSignalStatefulWidget](/packages/signals_lint/flutter/convert-stateful-to-signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsAvoidDeprecatedSignalsMixin](/packages/signals_lint/flutter/signals-avoid-deprecated-signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [MigrateSignalsMixinToSignalStatefulWidget](/packages/signals_lint/flutter/migrate-signals-mixin-to-signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SignalStatefulElement](/packages/signals/extensions/signal-stateful-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Stateful Widget Convert Widget Extension](/packages/signals/extensions/stateful-widget-convert-widget-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [ConvertedSignalStatefulWidget](/packages/signals/extensions/converted-signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalStatefulWidget](/packages/signals/extensions/signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [signals](/packages/signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-lint AI Skill](/skills/signals-lint) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

