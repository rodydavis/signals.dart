---
title: "Type: SignalOptions"
description: "API reference and details for SignalOptions from signals.dart."
---

# SignalOptions

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: SignalOptions

Configuration options for a [Signal](/types/signal).

Extends [ReadonlySignalOptions](/types/readonlysignaloptions) to also support custom **equality** checkers,
which control whether incoming values trigger update events.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final items = signal(
  [1, 2, 3],
  options: SignalOptions(
    name: 'item-list',
    equality: SignalEquality.deep(),
    watched: () => print('Items watch active'),
    unwatched: () => print('Items watch inactive'),
  ),
);
```

### Members of SignalOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **equalityCheck** | <code>method</code> | <code>dart SignalEquality<T> equalityCheck</code> | Get the active equality check |
| **SignalOptions** | <code>constructor</code> | <code>dart SignalOptions({super.name, super.watched, super.unwatched, SignalEquality<T>? equality})</code> | Creates a new [SignalOptions](/types/signaloptions) instance. |
| **copyWith** | <code>method</code> | <code>dart SignalOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## Class: SignalOptions

Configuration options for a [Signal](/types/signal) extending **signals.SignalOptions**.

### Members of SignalOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | <code>field</code> | <code>dart bool autoDispose</code> | Automatically dispose the signal when there are no more listeners. |
| **SignalOptions** | <code>constructor</code> | <code>dart SignalOptions({super.name, this.autoDispose = false, super.watched, super.unwatched, super.equality})</code> | Creates a new [SignalOptions](/types/signaloptions) instance. |
| **copyWith** | <code>method</code> | <code>dart SignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **SignalOptions** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Ticker Signal](/packages/signals_flutter/signals/ticker-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [FlutterSignal](/packages/signals_flutter/signals/flutter-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [SignalEquality](/packages/signals_flutter/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [SignalEquality](/packages/signals_core/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalsPreferUnifiedOptions](/packages/signals_lint/flutter/signals-prefer-unified-options) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [TickerSignal](/packages/signals/signals/ticker-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [FlutterSignal](/packages/signals/signals/flutter-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [SignalEquality](/packages/signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [useSignal](/packages/signals_hooks/hooks/use-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [Signal](/packages/preact_signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [SignalEquality](/packages/preact_signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>

