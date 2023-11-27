[![flutter_preact_signals](https://img.shields.io/pub/v/flutter_preact_signals.svg)](https://pub.dev/packages/flutter_preact_signals)
[![Tests](https://github.com/rodydavis/preact_signals.dart/actions/workflows/tests.yml/badge.svg)](https://github.com/rodydavis/preact_signals.dart/actions/workflows/tests.yml)
[![Publish Example](https://github.com/rodydavis/preact_signals.dart/actions/workflows/main.yml/badge.svg)](https://github.com/rodydavis/preact_signals.dart/actions/workflows/main.yml)

# Preact Signals (Flutter)

Complete dart port of [Preact signals](https://preactjs.com/blog/introducing-signals/) and takes full advantage of [signal boosting](https://preactjs.com/blog/signal-boosting/).

This package is a set of Flutter extensions for the [`preact_signals`](https://pub.dev/packages/preact_signals) package.

## Guide / API

The signals library exposes four functions which are the building blocks to model any business logic you can think of.

### `signal(initialValue)`

The `signal` function creates a new signal. A signal is a container for a value that can change over time. You can read a signal's value or subscribe to value updates by accessing its `.value` property.

```dart
import 'package:preact_signals/preact_signals.dart';

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
import 'package:preact_signals/preact_signals.dart';

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

The `effect` function is the last piece that makes everything reactive. When you access a signal inside its callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [`computed(fn)`](#computedfn). By default all updates are lazy, so nothing will update until you access a signal inside `effect`.

```dart
import 'package:preact_signals/preact_signals.dart';

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
import 'package:preact_signals/preact_signals.dart';

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

### `batch(fn)`

The `batch` function allows you to combine multiple signal writes into one single update that is triggered at the end when the callback completes.

```dart
import 'package:preact_signals/preact_signals.dart';

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
import 'package:preact_signals/preact_signals.dart';

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
import 'package:preact_signals/preact_signals.dart';

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

## Value Signals

To provide a more connivent API for common value types, various wrappers are created that implement all the public methods and notify on mutations will keeping the same object reference.

### List

List signals can be created by extension, method or class:

```dart
import 'package:preact_signals/preact_signals.dart';

final list = ['a', 'b', 'c'];

final s1 = list.toSignal();
final s2 = listSignal(list);
final s3 = ListSignal(list);
```

Mutations can also be done directly:

```dart
final s = listSignal([1, 2, 3]);
s[0] = -1;
print(s.length); // 3
s.addAll([4, 5, 6]);
s.first = 1;
```

### Set

Set signals can be created by extension, method or class:

```dart
import 'package:preact_signals/preact_signals.dart';

final set = {'a', 'b', 'c'};

final s1 = set.toSignal();

final s2 = setSignal(set);

final s3 = SetSignal(set);
```

### Map

Map signals can be created by extension, method or class:

```dart
import 'package:preact_signals/preact_signals.dart';

final map = {'a': 1, 'b': 2, 'c': 3};

final s1 = map.toSignal();

final s2 = mapSignal(map);

final s3 = MapSignal(map);
```

### Iterable

Iterable signals can be created by extension, method or class:

```dart
import 'package:preact_signals/preact_signals.dart';

final iterable = () sync* {
	yield '1';
	yield '2';
	yield '3';
	return '4';
};

final s1 = iterable.toSignal();

final s2 = iterableSignal(iterable);

final s3 = IterableSignal(iterable);
```

## Extensions

### `Future`

Futures can be converted to signals by either a method `signalFromFuture` or as an extension method on a `Future`:

```dart
import 'package:preact_signals/preact_signals.dart';

final future = Future(() => 1);
final signal = future.toSignal(); // or signalFromFuture(future)
```

> This will return a sealed union based on `SignalState` that will return `SignalValue` for success, `SignalError` for errors (and `SignalTimeout` on optional timeout), and `SignalLoading`.

### `Stream`

Futures can be converted to signals by either a method `signalFromFuture` or as an extension method on a `Future`:

```dart
import 'package:preact_signals/preact_signals.dart';

Stream<int> createStream() async* {
    yield 1;
    yield 2;
    yield 3;
}
final stream = createStream();
final signal = stream.toSignal(); // or signalFromStream(stream)
```

> This will return a sealed union based on `SignalState` that will return `SignalValue` for success, `SignalError` for errors (and `SignalTimeout` on optional timeout), and `SignalLoading`.

### `ValueListenable`

To create a `ReadonlySignal` from `ValueListenable`:

```dart
import 'package:flutter_preact_signals/flutter_preact_signals.dart';
import 'package:flutter/material.dart';

final ValueListenable listenable = ValueNotifier(10);
final signal = listenable.toSignal(); // or signalFromValueListenable(listenable)
```

### `ValueNotifier`

To create a `MutableSignal` from `ValueNotifier`:

```dart
import 'package:flutter_preact_signals/flutter_preact_signals.dart';
import 'package:flutter/material.dart';

final notifier = ValueNotifier(10);
final signal = notifier.toSignal(); // or signalFromValueNotifier(notifier)
```

### `BuildContext` and Widgets

`StatefulWidget` and `StatelessWidget` widgets can both react to changes on a signal by adding a `watch`` command:

```dart
import 'package:flutter_preact_signals/flutter_preact_signals.dart';

Text(
  '${counter.watch(context)}',
  style: Theme.of(context).textTheme.headlineMedium!,
)
```

or with `watchSignal`:

```dart
import 'package:flutter_preact_signals/flutter_preact_signals.dart';

Text(
  '${watchSignal(context, counter)}',
  style: Theme.of(context).textTheme.headlineMedium!,
)
```

This will mark the widget as dirty and rebuild on next frame. This will all be optimized for batched effects and multiple signals being updated at the same time.

## Example

Reacting to signal changes can be done with one extension method: `watch(context)`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_preact_signals/flutter_preact_signals.dart';

void main() {
  runApp(const MyApp());
}

final brightness = signal(Brightness.light);
final counter = signal(0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: brightness.watch(context) == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  void _incrementCounter() {
    counter.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Builder(builder: (context) {
            final isDark = brightness.watch(context) == Brightness.dark;
            return IconButton(
              onPressed: () {
                brightness.value = isDark ? Brightness.light : Brightness.dark;
              },
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            );
          }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.watch(context)}',
              style: Theme.of(context).textTheme.headlineMedium!,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## DevTools

There is an early version of a devtools extension included with the [preact_signals] package.
