---
title: "Type: ComputedOptions"
description: "API reference and details for ComputedOptions from signals.dart."
---

# ComputedOptions

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: ComputedOptions

Configuration options for a [Computed](/types/computed) signal.

Enables configuring debugging names and subscription state event listeners
for computed derivations.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final doubleCount = computed(
  () => count.value * 2,
  options: ComputedOptions(
    name: 'double-count',
    watched: () => print('Computed doubleCount is active'),
    unwatched: () => print('Computed doubleCount is inactive'),
  ),
);
```

### Members of ComputedOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **ComputedOptions** | <code>constructor</code> | <code>dart ComputedOptions({super.name, super.watched, super.unwatched})</code> | Creates a new [ComputedOptions](/types/computedoptions) instance. |
| **copyWith** | <code>method</code> | <code>dart ComputedOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## Class: ComputedOptions

Configuration options for a [Computed](/types/computed) extending **signals.ComputedOptions**.

### Members of ComputedOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | <code>field</code> | <code>dart bool autoDispose</code> | Automatically dispose the signal when there are no more listeners. |
| **ComputedOptions** | <code>constructor</code> | <code>dart ComputedOptions({super.name, this.autoDispose = false, super.watched, super.unwatched})</code> | Creates a new [ComputedOptions](/types/computedoptions) instance. |
| **copyWith** | <code>method</code> | <code>dart ComputedOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **ComputedOptions** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Computed](/packages/signals_flutter/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [FlutterComputed](/packages/signals_flutter/signals/flutter-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Computed](/packages/signals_core/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [SignalsPreferUnifiedOptions](/packages/signals_lint/flutter/signals-prefer-unified-options) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Computed](/packages/signals/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [FlutterComputed](/packages/signals/signals/flutter-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [Signal](/packages/preact_signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Computed](/packages/preact_signals/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

