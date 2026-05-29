---
title: "Type: valueListenableToSignal"
description: "API reference and details for valueListenableToSignal from signals.dart."
---

# valueListenableToSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Function: valueListenableToSignal

```dart
ReadonlySignal<T> valueListenableToSignal(ValueListenable<T> valueListenable, {String? debugLabel, bool autoDispose = false})
```

A global helper function to convert a Flutter **ValueListenable** to a [ReadonlySignal](/types/readonlysignal).

This helper is a functional equivalent of the <code>toSignal()</code> extension method.

### Example
```dart
final scrollPosition = ValueNotifier(0.0);
final scrollSignal = valueListenableToSignal(scrollPosition);
```

## References

The **valueListenableToSignal** type is referenced and used in the following pages:

* [Value Listenable To Signal](/packages/signals_flutter/extensions/value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Value Listenable To Signal](/packages/signals/extensions/value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>

