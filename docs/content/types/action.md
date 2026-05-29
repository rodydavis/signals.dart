---
title: "Type: action"
description: "API reference and details for action from signals.dart."
---

# action

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Function: action

```dart
Function action(Function fn)
```

Wraps a callback function into a reusable, batched, and untracked action.

An **action** is a higher-order function that takes a callback and returns a new function
with the exact same signature. When the returned function is executed, it runs the original
callback inside both a [batch](/types/batch) and an [untracked](/types/untracked) block.

### Why use <code>action</code> instead of <code>batch</code>?

1. **Reusability**: <code>batch(fn)</code> executes the callback immediately. In contrast, <code>action(fn)</code>
   returns a *reusable function* that you can store, pass around, and invoke multiple times
   to perform batch transactions on demand.
2. **Untracked Execution**: The callback runs inside <code>untracked</code>. If you invoke the action
   from within an <code>effect</code> or a <code>computed</code> signal, the outer reactive context **will not**
   establish subscriptions to any signals read inside the action.

---

### Example: Comparing Normal Updates vs. Action Batching

#### Without Actions (Standard Sequential Updates)

Every signal write immediately notifies active subscribers. This causes transient states
and redundant, intermediate executions:

```dart
import 'package:preact_signals/preact_signals.dart';

final a = signal('a');
final b = signal('b');

void main() {
  // Set up a subscriber effect
  effect(() => print('${a.value} ${b.value}'));
  // Prints immediately: "a b"

  a.value = 'aa'; // Prints: "aa b"
  b.value = 'bb'; // Prints: "aa bb"
}
```
Total prints: **3** (initial execution + 2 updates).

#### With Actions (Coalesced Transaction)

By wrapping the state-mutating function in [action](/types/action), all updates are postponed and flushed
in a single notification block once the function completes:

```dart
import 'package:preact_signals/preact_signals.dart';

final a = signal('a');
final b = signal('b');

// Create a reusable action
final updateFields = action((String nextA, String nextB) {
  a.value = nextA;
  b.value = nextB;
});

void main() {
  effect(() => print('${a.value} ${b.value}'));
  // Prints immediately: "a b"

  updateFields('aa', 'bb');
  // The effect is deferred during execution and triggers exactly once at the end.
  // Prints: "aa bb"
}
```
Total prints: **2** (initial execution + 1 coalesced update).

---

### Type-Safety & Extensions

While <code>action</code> accepts any generic <code>Function</code>, Dart's static analysis benefits greatly from
type-safe variants or extensions.

- **Type-safe functions**: Use <code>action0</code> through <code>action10</code> (e.g. <code>action2(...)</code> for 2 arguments) to preserve type arguments.
- **Extensions**: Call <code>.action</code> directly on any Dart function (e.g., <code>myFunction.action</code>).

## References

The **action** type is referenced and used in the following pages:

* [Signals.dart](/)
* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [MapSignalMixin](/packages/signals_flutter/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [QueueSignalMixin](/packages/signals_flutter/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [IterableSignalMixin](/packages/signals_flutter/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [StreamSignalMixin](/packages/signals_flutter/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Model](/packages/signals_flutter/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalProvider](/packages/signals_flutter/widgets/signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [MapSignalMixin](/packages/signals_core/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [QueueSignalMixin](/packages/signals_core/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [IterableSignalMixin](/packages/signals_core/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [StreamSignalMixin](/packages/signals_core/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Model](/packages/signals_core/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [MapSignalMixin](/packages/signals/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [QueueSignalMixin](/packages/signals/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [IterableSignalMixin](/packages/signals/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [StreamSignalMixin](/packages/signals/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Model](/packages/signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals](/packages/signals)
* [SignalProvider](/packages/signals/widgets/signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Model](/packages/preact_signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [preact_signals](/packages/preact_signals)

