[![Tests](https://github.com/rodydavis/signals.dart/actions/workflows/tests.yml/badge.svg)](https://github.com/rodydavis/signals.dart/actions/workflows/tests.yml)
[![Website](https://github.com/rodydavis/signals.dart/actions/workflows/website.yml/badge.svg)](https://github.com/rodydavis/signals.dart/actions/workflows/website.yml)
[![GitHub stars](https://img.shields.io/github/stars/rodydavis/signals.dart)](https://gitHub.com/rodydavis/signals.dart/stargazers/)
[![Coverage](https://codecov.io/gh/rodydavis/signals.dart/branch/main/graph/badge.svg?token=HvJYtaixiW)](https://codecov.io/gh/rodydavis/signals.dart)
[![GitHub issues](https://img.shields.io/github/issues/rodydavis/signals.dart)](https://github.com/rodydavis/signals.dart/issues/)
[![GitHub pull-requests](https://img.shields.io/github/issues-pr/rodydavis/signals.dart.svg)](https://gitHub.com/rodydavis/signals.dart/pull/)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

# Signals

Signals features:

- 🪡 **Fine grained reactivity**: Based on [Preact Signals](https://preactjs.com/blog/signal-boosting/) and provides a fine grained reactivity system that will automatically track dependencies and free them when no longer needed
- ⛓️ **Lazy evaluation**: Signals are lazy and will only compute values when read. If a signal is not read, it will not be computed
- 🗜️ **Flexible API**: Every app is different and signals can be composed in multiple ways. There are a few rules to follow but the API surface is small
- 🔬 **Surgical Rendering**: Widgets can be rebuilt surgically, only marking dirty the parts of the Widget tree that need to be updated and if mounted
- 💙 **100% Dart Native**: Supports Dart JS (HTML), Shelf Server, CLI (and Native), VM, Flutter (Web, Mobile and Desktop). Signals can be used in any Dart project

To start using signals, check out the full [documentation](https://dartsignals.dev/).

## Quick Start

The signals library exposes four functions which are the building blocks to model any business logic you can think of.

### `signal(initialValue)`

The `signal` function creates a new signal. A signal is a container for a value that can change over time. You can read a signal's value or subscribe to value updates by accessing its `.value` property.

```dart
import 'package:signals/signals.dart';

final counter = signal(0);

// Read value from signal, logs: 0
print(counter.value);

// Write to a signal
counter.value = 1;
```

Writing to a signal is done by setting its `.value` property. Changing a signal's value synchronously updates every [computed](#computedfn) and [effect](#effectfn) that depends on that signal, ensuring your app state is always consistent.

#### `signal.peek()`

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

### `untracked(fn)`

In case when you're receiving a callback that can read some signals, but you don't want to subscribe to them, you can use `untracked` to prevent any subscriptions from happening.

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

### `computed(fn)`

Data is often derived from other pieces of existing data. The `computed` function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");

final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
print(fullName.value);

// Updates flow through computed, but only if someone
// subscribes to it. More on that later.
name.value = "John";
// Logs: "John Doe"
print(fullName.value);
```

Any signal that is accessed inside the `computed`'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.

### `effect(fn)`

The `effect` function is the last piece that makes everything reactive. When you access a signal inside an `effect`'s callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [`computed(fn)`](#computedfn). By default all updates are lazy, so nothing will update until you access a signal inside `effect`.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
effect(() => print(fullName.value));

// Updating one of its dependencies will automatically trigger
// the effect above, and will print "John Doe" to the console.
name.value = "John";
```

You can destroy an effect and unsubscribe from all signals it was subscribed to, by calling the returned function.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
final dispose = effect(() => print(fullName.value));

// Destroy effect and subscriptions
dispose();

// Update does nothing, because no one is subscribed anymore.
// Even the computed `fullName` signal won't change, because it knows
// that no one listens to it.
surname.value = "Doe 2";
```

#### Warning Cycles

Mutating a signal inside an effect will cause an infinite loop, because the effect will be triggered again. To prevent this, you can use [`untracked(fn)`](#untrackedfn) to read a signal without subscribing to it.

```dart
import 'dart:async';

import 'package:signals/signals.dart';

Future<void> main() async {
  final completer = Completer<void>();
  final age = signal(0);

  effect(() {
    print('You are ${age.value} years old');
    age.value++; // <-- This will throw a cycle error
  });

  await completer.future;
}
```

### `batch(fn)`

The `batch` function allows you to combine multiple signal writes into one single update that is triggered at the end when the callback completes.

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

### Flutter

To make signals reactive in Flutter, you can use the `createSignal`/`createComputed` function inside a stateful widget.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> with SignalsMixin {
  late final counter = createSignal(0);
  late final isEven = createComputed(() => counter.value.isEven);
  late final isOdd = createComputed(() => counter.value.isOdd);

  @override
  Widget build(BuildContext context) {
	return Column(
	  children: [
		Text('Counter: $counter'), // <- No need to use .value since .toString() is overridden to return the value
		Text('Is Even: $isEven'),
		Text('Is Odd: $isOdd'),
		ElevatedButton(
		  onPressed: () => counter.value++,
		  child: Text('Increment'),
		),
	  ],
	);
  }
}
```

The `SignalsMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.

#### Fine Grained Rebuilding

By default signals will rebuild the widget that is using the signal.

If you want to rebuild sub-widgets, you can use the `Watch` widget in combination with a signal created with `signal`/`computed`.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final counter = signal(0);

  @override
  Widget build(BuildContext context) {
	return Column(
	  children: [
		Watch((context) => Text('Counter: $counter')),
		ElevatedButton(
		  onPressed: () => counter.value++,
		  child: Text('Increment'),
		),
	  ],
	);
  }
}
```

There is a drop in replacement for `Builder` in the `Watch` widget that will rebuild the widget when the signal changes.

```diff
- Builder(builder: (context) {
+ Watch.builder(builder: (context) {
  return Text('Counter: $counter');
});
```

There is also the `.watch(context)` extension method that can be used to rebuild a widget when a signal changes.

```dart
...
final counter = signal(0);
...
@override
Widget build(BuildContext context) {
  return Column(
	children: [
	  Text('Counter: ${counter.watch(context)}'),
	  ElevatedButton(
		onPressed: () => counter.value++,
		child: Text('Increment'),
	  ),
	],
  );
}
```

## DevTools

There is an early version of a devtools extension included with this package.

![](https://github.com/rodydavis/signals.dart/blob/main/packages/signals//doc/screenshots/graph.png?raw=true)
![](https://github.com/rodydavis/signals.dart/blob/main/packages/signals//doc/screenshots/list.png?raw=true)

## Other packages

| Package           | Pub                                                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------|
| `signals_core`    | [![signals_core](https://img.shields.io/pub/v/signals_core.svg)](https://pub.dev/packages/signals_core)          |
| `signals_flutter` | [![signals_flutter](https://img.shields.io/pub/v/signals_flutter.svg)](https://pub.dev/packages/signals_flutter) |
| `signals_lint`    | [![signals_lint](https://img.shields.io/pub/v/signals_lint.svg)](https://pub.dev/packages/signals_lint)          |
