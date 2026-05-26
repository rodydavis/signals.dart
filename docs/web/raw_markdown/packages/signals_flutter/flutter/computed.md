---
title: FlutterComputed
description: A read-only reactive signal whose value is automatically computed and cached.
---

A read-only reactive signal whose value is automatically computed and cached
based on other signals it depends on.

`FlutterComputed` extends the core `Computed` signal and implements Flutter's
**ValueListenable**, making it seamlessly compatible with native Flutter widgets
(like `ValueListenableBuilder`) and other ecosystem packages.

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
you can extend `FlutterComputed` directly or mix in `ValueListenableSignalMixin`.


### Constructors

##### <a name="fluttercomputed"></a><a name="fluttercomputed"></a>`FlutterComputed(super.internalValue, {super.options, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: ComputedOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})`

Create a new signal that is computed based on the values of other signals.

The returned computed signal is read-only, and its value is automatically
updated when any signals accessed from within the callback function change.


### Properties

##### <a name="runcallbackonlisten"></a>`bool runCallbackOnListen`
