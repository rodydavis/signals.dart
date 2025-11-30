---
title: Signal
description: How to create and use a signal
sidebar:
  order: 0
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

Writing to a signal is done by setting its `.value` property. Changing a signal's value synchronously updates every [computed](/core/computed) and [effect](/core/effect) that depends on that signal, ensuring your app state is always consistent.

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

## Force Update

If you want to force an update for a signal, you can call the `.set(..., force: true)` method. This will trigger all effects and mark all computed as dirty.

```dart
final counter = signal(0);
counter.set(1, force: true);
```

## Options

Signals can be created with optional parameters to customize their behavior.

### Name

You can assign a name to a signal for debugging purposes.

```dart
final s = signal(0, options: SignalOptions(name: 'counter'));
print(s.name); // counter
```

### Equality Check

You can provide a custom equality check function to determine if the signal value has changed.

```dart
final s = signal(
  0,
  options: SignalOptions(
    equalityCheck: SignalEquality.custom((a, b) => a == b),
  ),
);
```

### Auto Dispose

If a signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.

```dart
final s = signal(0, options: SignalOptions(autoDispose: true));
```

### Watch Callbacks

You can provide callbacks to be notified when the signal is watched or unwatched.

```dart
final s = signal(
  0,
  options: SignalOptions(
    watched: (val) => print('watched: $val'),
    unwatched: (val) => print('unwatched: $val'),
  ),
);
```

## Disposing

### Auto Dispose

If a signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.

```dart
final s = signal(0, options: SignalOptions(autoDispose: true));
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

## Custom Signal

You can create a custom signal by extending the `Signal` class.

```dart
class MySignal extends Signal<int> {
  MySignal(int value) : super(value);
}
```

:::tip
You can apply any number of mixins to a custom signal to add additional functionality.

Mixins:
- [ValueListenableSignalMixin](/mixins/value-listenable) to implement ValueListenable<T>
- [ValueNotifierSignalMixin](/mixins/value-notifier) to implement ValueNotifier<T>
- [ChangeStackSignalMixin](/mixins/change-stack) to add undo and redo functionality
- [TrackedSignalMixin](/mixins/tracked) to add initial and previous value tracking
- [StreamSignalMixin](/mixins/stream) to implement Stream
- [SinkSignalMixin](/mixins/sink) to implement Sink
- [EventSinkSignalMixin](/mixins/event-sink) to implement EventSink
- [ListSignalMixin](/mixins/list) for List value types
- [MapSignalMixin](/mixins/map) for Map value types
- [SetSignalMixin](/mixins/set) for Set value types
- [IterableSignalMixin](/mixins/iterable) for Iterable<T> value types
- [QueueSignalMixin](/mixins/queue) for Queue value types
:::

## Flutter

In Flutter if you want to create a signal that automatically disposes itself when the widget is removed from the widget tree and rebuilds the widget when the signal changes, you can use the `createSignal` inside a stateful widget.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> with SignalsMixin {
  late final counter = createSignal(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $counter'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

No `Watch` widget or extension is needed, the signal will automatically dispose itself when the widget is removed from the widget tree.

The `SignalsMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.

## Testing

Testing signals is possible by converting a signal to a stream and testing it like any other stream in Dart.

```dart
test('test as stream', () {
  final s = signal(0);
  final stream = s.toStream(); // create a stream of values

  s.value = 1;
  s.value = 2;
  s.value = 3;

  expect(stream, emitsInOrder([0, 1, 2, 3]));
});
```

`emitsInOrder` is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.

You can also override the initial value of a signal when testing. This is is useful for mocking and testing specific value implementations.

```dart
test('test with override', () {
  final s = signal(0).overrideWith(-1);

  final stream = s.toStream();

  s.value = 1;
  s.value = 2;
  s.value = 3;

  expect(stream, emitsInOrder([-1, 1, 2, 3]));
});
```

`overrideWith` returns a new signal with the same global id sets the value as if it was created with it. This can be useful when using async signals or global signals used for dependency injection.
