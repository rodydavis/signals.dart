---
title: "Type: EffectOptions"
description: "API reference and details for EffectOptions from signals.dart."
---

# EffectOptions

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: EffectOptions

Configuration options for reactive [Effect](/types/effect)s.

Permits naming the effect for debugging, performance profiling,
and tracing within the signals developer tools.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);

final logger = effect(
  () => print('Count changed to: ${count.value}'),
  options: const EffectOptions(name: 'counter-logger'),
);
```

### Members of EffectOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **EffectOptions** | <code>constructor</code> | <code>dart EffectOptions({super.name})</code> | Creates a new [EffectOptions](/types/effectoptions) instance. |
| **copyWith** | <code>method</code> | <code>dart EffectOptions copyWith({String? name})</code> | Creates a copy of this options with custom overrides. |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## Class: EffectOptions

Configuration options for reactive [Effect](/types/effect)s extending **signals.EffectOptions**.

### Members of EffectOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | <code>field</code> | <code>dart bool autoDispose</code> | Automatically dispose the signal when there are no more listeners. |
| **onDispose** | <code>field</code> | <code>dart void Function()? onDispose</code> | Callback called when the effect is disposed. |
| **EffectOptions** | <code>constructor</code> | <code>dart EffectOptions({super.name, this.autoDispose = false, this.onDispose})</code> | Creates a new [EffectOptions](/types/effectoptions) instance. |
| **copyWith** | <code>method</code> | <code>dart EffectOptions copyWith({String? name, bool? autoDispose, void Function()? onDispose})</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **EffectOptions** type is referenced and used in the following pages:

* [Effect](/packages/signals_flutter/core/effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Effect](/packages/signals_core/core/effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Effect](/packages/signals/core/effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Effect](/packages/preact_signals/core/effect) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Signal](/packages/preact_signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

