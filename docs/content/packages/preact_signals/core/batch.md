---
title: Batch
description: Combines multiple signal writes into a single update transaction that is flushed only after the callback completes.
---

Combines multiple signal writes into a single update transaction that is flushed only after the callback completes.

Under normal circumstances, writing to a signal immediately notifies all of its active subscribers
(effects and computed signals), which can cause multiple redundant updates or temporary inconsistent/glitchy states
if you are updating several related signals sequentially.

By wrapping your mutations in [batch](/types/batch), notification events are deferred. Subscribed [effect](/types/effect)s and [computed](/types/computed)
signals will only run once at the very end of the batch callback block.

<Info>
  Always use <a href="/types/batch">batch</a> when performing multiple state transitions together. This avoids flickering UI, unnecessary
  rebuilds, and transient states where some dependencies are updated but others are not.
</Info>

### Nested Batches

Batches can be nested. Updates are only flushed when the *outermost* batch callback completes.

### Mid-Batch Reads

If you read a mutated signal *inside* the batch callback, or access a computed signal that depends on a
mutated signal, that signal is immediately computed and updated inline to ensure your code always operates
on consistent, up-to-date data. However, other independent signals and effects are still deferred until
the batch finishes.

Parameters:
- **fn**: The callback function containing the signal write operations to be batched.

Returns:
- The value returned by the callback function **fn**.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  final name = signal("Jane");
  final surname = signal("Doe");
  final fullName = computed(() => "${name.value} ${surname.value}");

  // Set up an effect that reacts to changes
  effect(() => print("Name changed to: ${fullName.value}"));

  // Batching mutations ensures the effect runs only once
  batch(() {
    name.value = "John";
    surname.value = "Smith";
  });
  // Prints: "Name changed to: John Smith" (Only once, not twice!)
}
```
