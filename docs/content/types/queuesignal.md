---
title: "Type: QueueSignal"
description: "API reference and details for QueueSignal from signals.dart."
---

# QueueSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: QueueSignal

A [Signal](/types/signal) that holds a **Queue**.

### Members of QueueSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **QueueSignal** | <code>constructor</code> | <code>dart QueueSignal(super.value, {QueueSignalOptions<T>? options, @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: QueueSignalOptions(name: ...) instead') String? debugLabel})</code> | Creates a [QueueSignal](/types/queuesignal) with the given **value**. |

## Function: queueSignal

```dart
QueueSignal<T> queueSignal(Queue<T> list, {QueueSignalOptions<T>? options, @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: QueueSignalOptions(name: ...) instead') String? debugLabel})
```

Creates a [QueueSignal](/types/queuesignal) with the given **list** (Queue).

## References

The **QueueSignal** type is referenced and used in the following pages:

* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [QueueSignalMixin](/packages/signals_flutter/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [QueueSignalMixin](/packages/signals_core/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [QueueSignalMixin](/packages/signals/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [useQueueSignal](/packages/signals_hooks/hooks/use-queue-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

