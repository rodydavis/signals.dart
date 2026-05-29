---
title: "Type: batch"
description: "API reference and details for batch from signals.dart."
---

# batch

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Function: batch

```dart
T batch(T Function() fn)
```

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

## Function: batch

```dart
T batch(BatchCallback<T> fn)
```

The <code>batch</code> function allows you to combine multiple signal writes into one single update that is triggered at the end when the callback completes.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
effect(() => print(fullName.value));

// Combines both signal writes into one update. Once the callback
// returns the `effect` will trigger and we'll log "Foo Bar"
batch(() {
	name.value = "Foo";
	surname.value = "Bar";
});
```

When you access a signal that you wrote to earlier inside the callback, or access a computed signal that was invalidated by another signal, we'll only update the necessary dependencies to get the current value for the signal you read from. All other invalidated signals will update at the end of the callback function.

```dart
import 'package:signals/signals.dart';

final counter = signal(0);
final _double = computed(() => counter.value * 2);
final _triple = computed(() => counter.value * 3);

effect(() => print(_double.value, _triple.value));

batch(() {
	counter.value = 1;
	// Logs: 2, despite being inside batch, but `triple`
	// will only update once the callback is complete
	print(_double.value);
});
// Now we reached the end of the batch and call the effect
```

Batches can be nested and updates will be flushed when the outermost batch call completes.

```dart
import 'package:signals/signals.dart';

final counter = signal(0);
effect(() => print(counter.value));

batch(() {
	batch(() {
		// Signal is invalidated, but update is not flushed because
		// we're still inside another batch
		counter.value = 1;
	});

	// Still not updated...
});
// Now the callback completed and we'll trigger the effect.
```

## References

The **batch** type is referenced and used in the following pages:

* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Batch](/packages/signals_flutter/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [signals_flutter](/packages/signals_flutter)
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Batch](/packages/signals_core/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [signals_core](/packages/signals_core)
* [signals_devtools_extension](/packages/signals_devtools_extension)
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Batch](/packages/signals/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals](/packages/signals)
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Batch](/packages/preact_signals/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [preact_signals](/packages/preact_signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [AI Integration](/reference/ai) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>

