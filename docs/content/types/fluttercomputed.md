---
title: "Type: FlutterComputed"
description: "API reference and details for FlutterComputed from signals.dart."
---

# FlutterComputed

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: FlutterComputed

A read-only reactive signal whose value is automatically computed and cached
based on other signals it depends on.

<code>FlutterComputed</code> extends the core <code>Computed</code> signal and implements Flutter's
**ValueListenable**, making it seamlessly compatible with native Flutter widgets
(like <code>ValueListenableBuilder</code>) and other ecosystem packages.

### Example Usage

```dart
final count = signal(2);
final doubled = computed(() => count.value * 2);

print(doubled.value); // 4
count.value = 5;
print(doubled.value); // 10
```

### Custom Signals
To create a custom signal that behaves like a computed value and implements **ValueListenable**,
you can extend <code>FlutterComputed</code> directly or mix in <code>ValueListenableSignalMixin</code>.

### Members of FlutterComputed

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **FlutterComputed** | <code>constructor</code> | <code>dart FlutterComputed(super.internalValue, {super.options, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: ComputedOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})</code> | Create a new signal that is computed based on the values of other signals. |
| **runCallbackOnListen** | <code>field</code> | <code>dart bool runCallbackOnListen</code> |  |

## References

The **FlutterComputed** type is referenced and used in the following pages:

* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [FlutterComputed](/packages/signals_flutter/signals/flutter-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [FlutterComputed](/packages/signals/signals/flutter-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [signals](/packages/signals)
* [useComputed](/packages/signals_hooks/hooks/use-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

