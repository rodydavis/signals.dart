---
title: "Type: valueNotifierToSignal"
description: "API reference and details for valueNotifierToSignal from signals.dart."
---

# valueNotifierToSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Function: valueNotifierToSignal

```dart
Signal<T> valueNotifierToSignal(ValueNotifier<T> valueNotifier, {String? debugLabel, bool autoDispose = false})
```

A global helper function to convert a Flutter **ValueNotifier** to a mutable [Signal](/types/signal).

Updates to either the notifier or the returned signal will automatically update the other.
This helper is a functional equivalent of the <code>toSignal()</code> extension method.

### Example
```dart
final textControllerValue = ValueNotifier('');
final textSignal = valueNotifierToSignal(textControllerValue);
```

## References

The **valueNotifierToSignal** type is referenced and used in the following pages:

* [Value Notifier To Signal](/packages/signals_flutter/extensions/value-notifier-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Value Notifier To Signal](/packages/signals/extensions/value-notifier-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

