---
title: "Type: untracked"
description: "API reference and details for untracked from signals.dart."
---

# untracked

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Function: untracked

```dart
T untracked(T Function() fn)
```

Runs a callback function **fn** that can read signal values without establishing a reactive subscription.

Normally, reading a signal's value (via <code>.value</code> or <code>()</code>) inside an [effect](/types/effect) or a [computed](/types/computed) callback
automatically subscribes the surrounding context to that signal. If the signal changes, the context is
re-executed.

In some scenarios, you want to read a signal's current value inside a reactive context but *avoid* creating
a subscription. This is where [untracked](/types/untracked) is useful. It temporarily suspends active tracking, executes **fn**,
and then restores tracking.

Parameters:
- **fn**: The callback function to execute. Any signal read inside this callback will not register a dependency.

Returns:
- The value returned by the callback function **fn**.

### Example Usage

```dart
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
```

<Info>
  <a href="/types/untracked">untracked</a> is particularly useful inside event handlers, conditional logging, or when you are performing
  a write to a signal based on another signal's value inside an effect to prevent infinite dependency cycles.
</Info>

<Warning>
  Be cautious when using <a href="/types/untracked">untracked</a>, as it bypasses the dependency tracking system. If the values read inside
  <a href="/types/untracked">untracked</a> change, your reactive side effects or computed derivations will <em>not</em> automatically re-run.
</Warning>

## Function: untracked

```dart
T untracked(UntrackedCallback<T> fn)
```

In case when you're receiving a callback that can read some signals, but you don't want to subscribe to them, you can use <code>untracked</code> to prevent any subscriptions from happening.

```dart
final counter = signal(0);
final effectCount = signal(0);
final fn = () => effectCount.value + 1;

effect(() {
	print(counter.value);

	// Whenever this effect is triggered, run `fn` that gives new value
	effectCount.value = untracked(fn);
});
```

## References

The **untracked** type is referenced and used in the following pages:

* [Bi-directional Data Flow](/guides/bi-directional-data-flow) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [Untracked](/packages/signals_flutter/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [signals_flutter](/packages/signals_flutter)
* [Untracked](/packages/signals_core/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [signals_core](/packages/signals_core)
* [Untracked](/packages/signals/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals](/packages/signals)
* [Untracked](/packages/preact_signals/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [preact_signals](/packages/preact_signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [AI Integration](/reference/ai) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>

