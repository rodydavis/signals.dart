---
title: "Type: SignalWidget"
description: "API reference and details for SignalWidget from signals.dart."
---

# SignalWidget

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: SignalWidget

A reactive **StatelessWidget** that implicitly tracks and rebuilds on signal changes.

<code>SignalWidget</code> establishes a dynamic reactive context directly at the Flutter element layer.
Any signal accessed via <code>.value</code> inside the **build** method is **implicitly tracked** and
subscribed to. When any of these signals mutate, only this widget is rebuilt.

This offers a clean, Javascript-style reactivity experience without needing manual
builder widgets (like <code>SignalBuilder</code>) or deprecated context watch extensions.

### Implicit Reactivity Example (Stateless)
```dart
final username = signal('Rody');
final status = signal('Online');

class UserProfileView extends SignalWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // 'username' and 'status' are implicitly tracked on access:
    return Column(
      children: [
        Text('Name: ${username.value}'),
        Text('Status: ${status.value}'),
      ],
    );
  }
}
```

> [!IMPORTANT]
> Only signals accessed *synchronously* during the execution of the <code>build</code> method are tracked.
> Signals read inside async callbacks, listeners, or deferred tasks are not subscribed to.

### Members of SignalWidget

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalWidget** | <code>constructor</code> | <code>dart SignalWidget({super.key})</code> | Constructor for [SignalWidget](/types/signalwidget). |
| **createElement** | <code>method</code> | <code>dart StatelessElement createElement()</code> |  |

## References

The **SignalWidget** type is referenced and used in the following pages:

* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ConvertedSignalWidget](/packages/signals_flutter/extensions/converted-signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Stateless Widget Convert Widget Extension](/packages/signals_flutter/extensions/stateless-widget-convert-widget-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalElement](/packages/signals_flutter/extensions/signal-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalWidget](/packages/signals_flutter/widgets/signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalsAvoidDeprecatedWatchExtension](/packages/signals_lint/flutter/signals-avoid-deprecated-watch-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [ConvertStatelessToSignalWidget](/packages/signals_lint/flutter/convert-stateless-to-signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsAvoidDeprecatedSignalsMixin](/packages/signals_lint/flutter/signals-avoid-deprecated-signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ConvertedSignalWidget](/packages/signals/extensions/converted-signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Stateless Widget Convert Widget Extension](/packages/signals/extensions/stateless-widget-convert-widget-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalElement](/packages/signals/extensions/signal-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [signals](/packages/signals)
* [SignalWidget](/packages/signals/widgets/signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-lint AI Skill](/skills/signals-lint) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

