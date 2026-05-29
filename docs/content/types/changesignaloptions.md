---
title: "Type: ChangeSignalOptions"
description: "API reference and details for ChangeSignalOptions from signals.dart."
---

# ChangeSignalOptions

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: ChangeSignalOptions

Configuration options for a [ChangeStackSignal](/types/changestacksignal).

### Members of ChangeSignalOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **limit** | <code>field</code> | <code>dart int? limit</code> | The limit of changes to keep in the undo/redo stack. |
| **ChangeSignalOptions** | <code>constructor</code> | <code>dart ChangeSignalOptions({this.limit, super.name, super.autoDispose, super.watched, super.unwatched})</code> | Creates a new [ChangeSignalOptions](/types/changesignaloptions) instance. |
| **copyWith** | <code>method</code> | <code>dart ChangeSignalOptions<T> copyWith({int? limit, String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **ChangeSignalOptions** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [ChangeStackSignal](/packages/signals_flutter/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [ChangeStackSignal](/packages/signals_core/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [ChangeStackSignal](/packages/signals/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>

