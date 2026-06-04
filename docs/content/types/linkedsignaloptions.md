---
title: "Type: LinkedSignalOptions"
description: "API reference and details for LinkedSignalOptions from signals.dart."
---

# LinkedSignalOptions

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: LinkedSignalOptions

Options for creating a [LinkedSignal](/types/linkedsignal).

### Members of LinkedSignalOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computation** | <code>field</code> | <code>dart T Function(S source, LinkedSignalPreviousState<T, S>? previous)? computation</code> | Custom computation logic that runs when the source changes. |
| **sourceEquality** | <code>field</code> | <code>dart bool Function(S a, S b)? sourceEquality</code> | Optional equality check for the source values. |
| **LinkedSignalOptions** | <code>constructor</code> | <code>dart LinkedSignalOptions({this.computation, this.sourceEquality, super.name, super.autoDispose})</code> | Creates [LinkedSignalOptions](/types/linkedsignaloptions). |
| **copyWith** | <code>method</code> | <code>dart LinkedSignalOptions<T, S> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, T Function(S source, LinkedSignalPreviousState<T, S>? previous)? computation, bool Function(S a, S b)? sourceEquality})</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **LinkedSignalOptions** type is referenced and used in the following pages:

* [LinkedSignal](/packages/signals_flutter/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [LinkedSignal](/packages/signals_core/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [LinkedSignal](/packages/signals/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [useLinkedSignal](/packages/signals_hooks/hooks/use-linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

