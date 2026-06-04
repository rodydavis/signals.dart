---
title: "Type: ReadonlySignalOptions"
description: "API reference and details for ReadonlySignalOptions from signals.dart."
---

# ReadonlySignalOptions

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: ReadonlySignalOptions

Configuration options for a [ReadonlySignal](/types/readonlysignal).

Allows intercepting the signal's active subscription state changes
via **watched** and **unwatched** callback event listeners. This is extremely useful
for initiating or canceling active background fetching, web sockets, or timer loops.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final stockTicker = signal(
  0.0,
  options: ReadonlySignalOptions(
    name: 'stock-ticker',
    watched: () => print('Stock Ticker is actively being listened to!'),
    unwatched: () => print('No more listeners, sleeping the ticker.'),
  ),
);
```

### Members of ReadonlySignalOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **watched** | <code>field</code> | <code>dart void Function()? watched</code> | Callback called when the signal goes from 0 to >=1 listeners. |
| **unwatched** | <code>field</code> | <code>dart void Function()? unwatched</code> | Callback called when the signal goes from >=1 to 0 listeners. |
| **ReadonlySignalOptions** | <code>constructor</code> | <code>dart ReadonlySignalOptions({super.name, this.watched, this.unwatched})</code> | Creates a new [ReadonlySignalOptions](/types/readonlysignaloptions) instance. |
| **copyWith** | <code>method</code> | <code>dart ReadonlySignalOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})</code> | Creates a copy of this options with custom overrides. |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## Class: ReadonlySignalOptions

Configuration options for a [ReadonlySignal](/types/readonlysignal) extending **signals.ReadonlySignalOptions**.

### Members of ReadonlySignalOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | <code>field</code> | <code>dart bool autoDispose</code> | Automatically dispose the signal when there are no more listeners. |
| **toSignalOptions** | <code>method</code> | <code>dart SignalOptions<T> toSignalOptions</code> | Convert to [SignalOptions](/types/signaloptions) |
| **ReadonlySignalOptions** | <code>constructor</code> | <code>dart ReadonlySignalOptions({super.name, this.autoDispose = false, super.watched, super.unwatched})</code> | Creates a new [ReadonlySignalOptions](/types/readonlysignaloptions) instance. |
| **copyWith** | <code>method</code> | <code>dart ReadonlySignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **ReadonlySignalOptions** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Signal](/packages/preact_signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>

