---
title: "Type: AsyncSignalOptions"
description: "API reference and details for AsyncSignalOptions from signals.dart."
---

# AsyncSignalOptions

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: AsyncSignalOptions

Configuration options for an [AsyncSignal](/types/asyncsignal).

### Members of AsyncSignalOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **initialValue** | <code>field</code> | <code>dart T? initialValue</code> | The initial value of the async signal. |
| **dependencies** | <code>field</code> | <code>dart List<ReadonlySignal<dynamic>> dependencies</code> | The list of dependencies to watch/listen to. |
| **onDone** | <code>field</code> | <code>dart void Function()? onDone</code> | Optional function called when a stream completes. |
| **cancelOnError** | <code>field</code> | <code>dart bool? cancelOnError</code> | Whether to cancel the stream subscription on error. |
| **lazy** | <code>field</code> | <code>dart bool lazy</code> | Whether the execution is lazy. |
| **AsyncSignalOptions** | <code>constructor</code> | <code>dart AsyncSignalOptions({this.initialValue, this.dependencies = const [], this.onDone, this.cancelOnError, this.lazy = true, super.name, super.autoDispose, super.watched, super.unwatched})</code> | Creates a new [AsyncSignalOptions](/types/asyncsignaloptions) instance. |
| **copyWith** | <code>method</code> | <code>dart AsyncSignalOptions<T> copyWith({T? initialValue, List<ReadonlySignal<dynamic>>? dependencies, void Function()? onDone, bool? cancelOnError, bool? lazy, bool? autoDispose, String? name, void Function()? watched, void Function()? unwatched})</code> | Creates a copy of this options with custom overrides. |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **AsyncSignalOptions** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [FutureSignal](/packages/signals_flutter/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Stream](/packages/signals_flutter/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [FutureSignal](/packages/signals_core/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Stream](/packages/signals_core/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [SignalsPreferUnifiedOptions](/packages/signals_lint/flutter/signals-prefer-unified-options) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [FutureSignal](/packages/signals/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Stream](/packages/signals/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [useAsyncComputed](/packages/signals_hooks/hooks/use-async-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

