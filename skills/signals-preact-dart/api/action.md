# function `action`

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

---

## Signature

```dart
Function action(Function fn)
```

