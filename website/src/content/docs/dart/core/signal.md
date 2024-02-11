---
title: Signal
description: How to create and use a signal
---

The `signal` function creates a new signal. A signal is a container for a value that can change over time. You can read a signal's value or subscribe to value updates by accessing its `.value` property.

```dart
import 'package:signals/signals.dart';

final counter = signal(0);

// Read value from signal, logs: 0
print(counter.value);

// Write to a signal
counter.value = 1;
```

Signals can be created globally, inside classes or functions. It's up to you how you want to structure your app.

It is not recommended to create signals inside effects or computed, as this will create a new signal every time the effect or computed is triggered. This can lead to unexpected behavior.

In Flutter do not create signals inside `build` methods, as this will create a new signal every time the widget is rebuilt.

## Writing to a signal

Writing to a signal is done by setting its `.value` property. Changing a signal's value synchronously updates every [computed](/signals.dart/dart/core/computed) and [effect](/signals.dart/dart/core/effect) that depends on that signal, ensuring your app state is always consistent.

## .peek()

In the rare instance that you have an effect that should write to another signal based on the previous value, but you _don't_ want the effect to be subscribed to that signal, you can read a signals's previous value via `signal.peek()`.

```dart
final counter = signal(0);
final effectCount = signal(0);

effect(() {
	print(counter.value);

	// Whenever this effect is triggered, increase `effectCount`.
	// But we don't want this signal to react to `effectCount`
	effectCount.value = effectCount.peek() + 1;
});
```

Note that you should only use `signal.peek()` if you really need it. Reading a signal's value via `signal.value` is the preferred way in most scenarios.

## .value

The `.value` property of a signal is used to read or write to the signal. If used inside an effect or computed, it will subscribe to the signal and trigger the effect or computed whenever the signal's value changes.

```dart
final counter = signal(0);

effect(() {
	print(counter.value);
});

counter.value = 1;
```

## .previousValue

The `.previousValue` property of a signal is used to read the previous value of the signal. If used inside an effect or computed, it will not subscribe to the signal and not trigger the effect or computed whenever the signal's value changes.

```dart
final counter = signal(0);

effect(() {
	print('Current value: ${counter.value}');
	print('Previous value: ${counter.previousValue}');
});

counter.value = 1;
```

## Force Update

If you want to force an update for a signal, you can call the `.set(..., force: true)` method. This will trigger all effects and mark all computed as dirty.

```dart
final counter = signal(0);
counter.set(1, force: true);
```

## Disposing

### Auto Dispose

If a signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.

```dart
final s = signal(0, autoDispose: true);
s.onDispose(() => print('Signal destroyed'));
final dispose = s.subscribe((_) {});
dispose();
final value = s.value; // 0
// prints: Signal destroyed
```

A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.

```dart
final s = signal(0);
s.dispose();
final c = computed(() => s.value);
// c will not react to changes in s
```

You can check if a signal is disposed by calling the `.disposed` method.

```dart
final s = signal(0);
print(s.disposed); // false
s.dispose();
print(s.disposed); // true
```

### On Dispose Callback

You can attach a callback to a signal that will be called when the signal is destroyed.

```dart
final s = signal(0);
s.onDispose(() => print('Signal destroyed'));
s.dispose();
```
