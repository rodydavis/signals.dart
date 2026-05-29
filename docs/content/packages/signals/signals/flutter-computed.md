---
title: FlutterComputed
description: A read-only reactive signal whose value is automatically computed and cached.
---

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="fluttercomputed"></a><a name="fluttercomputed"></a><code>FlutterComputed(super.internalValue, {super.options, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: ComputedOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})</code>

Create a new signal that is computed based on the values of other signals.

The returned computed signal is read-only, and its value is automatically
updated when any signals accessed from within the callback function change.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="runcallbackonlisten"></a><code>bool runCallbackOnListen</code>

</details>
