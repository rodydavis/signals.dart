---
title: Untracked
description: Runs a callback function **fn** that can read signal values without establishing a reactive subscription.
---

Runs a callback function **fn** that can read signal values without establishing a reactive subscription.

Normally, reading a signal's value (via `.value` or `()`) inside an [effect](/packages/signals/core/effect) or a [computed](/packages/signals/flutter/computed) callback
automatically subscribes the surrounding context to that signal. If the signal changes, the context is
re-executed.

In some scenarios, you want to read a signal's current value inside a reactive context but *avoid* creating
a subscription. This is where [untracked](/packages/signals/core/untracked) is useful. It temporarily suspends active tracking, executes **fn**,
and then restores tracking.

Parameters:
- **fn**: The callback function to execute. Any signal read inside this callback will not register a dependency.

Returns:
- The value returned by the callback function **fn**.

### Example Usage

````dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  final counter = signal(0);
  final loggingThreshold = signal(5);

  effect(() {
    final currentCount = counter.value; // Establishing a subscription to `counter`

    // We want to read `loggingThreshold` but we do NOT want this effect to
    // trigger whenever `loggingThreshold` changes.
    final threshold = untracked(() => loggingThreshold.value);

    if (currentCount > threshold) {
      print("Counter ($currentCount) has exceeded the threshold ($threshold)!");
    }
  });

  counter.value = 6; // Prints: "Counter (6) has exceeded the threshold (5)!"

  // Updating the threshold will NOT trigger the effect, because it was read inside `untracked`
  loggingThreshold.value = 10;
}
````

<Success>
[untracked] is particularly useful inside event handlers, conditional logging, or when you are performing
a write to a signal based on another signal's value inside an effect to prevent infinite dependency cycles.
</Success>

<Error>
Be cautious when using [untracked], as it bypasses the dependency tracking system. If the values read inside
[untracked] change, your reactive side effects or computed derivations will *not* automatically re-run.
</Error>
