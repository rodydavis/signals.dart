---
title: "Type: QueueSignalOptions"
description: "API reference and details for QueueSignalOptions from signals.dart."
---

# QueueSignalOptions

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: QueueSignalOptions

Configuration options for a [QueueSignal](/types/queuesignal).

### Members of QueueSignalOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **QueueSignalOptions** | <code>constructor</code> | <code>dart QueueSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})</code> | Creates a new [QueueSignalOptions](/types/queuesignaloptions) instance. |
| **copyWith** | <code>method</code> | <code>dart QueueSignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Queue<T>>? equality})</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **QueueSignalOptions** type is referenced and used in the following pages:

* [QueueSignalMixin](/packages/signals_flutter/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [QueueSignalMixin](/packages/signals_core/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [QueueSignalMixin](/packages/signals/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>

