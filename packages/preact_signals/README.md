# preact_signals

Complete Dart port of [Preact.js Signals](https://github.com/preactjs/signals/blob/main/packages/core/src/index.ts).

## Quick Start

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

The `effect` function is the last piece that makes everything reactive. When you access a signal inside an `effect`'s callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [`computed(fn)`](#computedfn). By default all updates are lazy, so nothing will update until you access a signal inside `effect`.

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

#### Warning Cycles

Mutating a signal inside an effect will cause an infinite loop, because the effect will be triggered again. To prevent this, you can use [`untracked(fn)`](#untrackedfn) to read a signal without subscribing to it.

```dart
import 'dart:async';

import 'package:preact_signals/preact_signals.dart';

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

### `createModel(fn, {options})`

The `createModel` function provides a structured way to define disposable model instances that group signals, computed values, and actions together, matching the design of PreactJS Signals Core.

#### 1. Type-Safe Models with Dart Records (Recommended)

The simplest and most built-in way to define a compile-safe model is to return a Dart **record** from your factory. Records provide immediate type safety, autocomplete, and compile-time verification with zero setup/overhead.

```dart
import 'package:preact_signals/preact_signals.dart';

// Define the reactive model constructor returning a Record
final counterModel = createModel(() {
  final count = signal(0);

  // Captured nested side-effect (e.g. logging or syncing to local storage)
  effect(() {
    print('Nested logger: count is ${count.value}');
  });

  return (
    count: count,
    increment: () => count.value++,
  );
});

void main() {
  // Instantiate the model
  final model = counterModel();

  // Access properties type-safely via .value
  print(model.value.count.value); // Prints: 0 (and registers effect print: Nested logger: count is 0)
  model.value.increment();        // Prints: Nested logger: count is 1

  // Clean up all captured effects
  model.dispose();
}
```

#### 2. Defining a Model (Map-based with Dynamic Lookup)

Models can also be defined using a factory function returning a `Map<String, dynamic>`. The returned object is a callable constructor.

When a `Map` is returned, all functions in the map are automatically wrapped in `action()` under the hood, ensuring state-modifying actions run inside implicit batches and untracked contexts.

```dart
import 'package:preact_signals/preact_signals.dart';

// Declare a model constructor with options
final CounterModel = createModel(() {
  final count = signal(0);
  
  return <String, dynamic>{
    'count': count,
    'increment': () => count.value += 1,
    'decrement': () => count.value -= 1,
  };
}, options: const SignalModelOptions(name: 'CounterModel'));

void main() {
  // Instantiate the model
  final counter = CounterModel();

  // Read signals directly
  print(counter['count'].value); // Logs: 0

  // Call actions
  counter['increment']();
  print(counter['count'].value); // Logs: 1

  // Clean up all captured effects
  counter.dispose();
}
```

#### 3. Zero-Overhead Type-Safe Wrappers (Extension Types)

You can use Dart 3.3+ **Extension Types** to create type-safe wrappers around your Map-based model instance with zero runtime allocation overhead when you prefer a class-like API (e.g. implementing getters/setters or hiding subscript lookups):

```dart
import 'package:preact_signals/preact_signals.dart';

extension type TypeSafeCounter(SignalModel<Map<String, dynamic>> _model) {
  int get count => (_model['count'] as Signal<int>).value;
  void increment() => (_model['increment'] as Function)();
  void dispose() => _model.dispose();
}

void main() {
  final myCounter = TypeSafeCounter(CounterModel());
  
  myCounter.increment();
  print(myCounter.count); // Logs: 1

  myCounter.dispose();
}
```

#### 3. Forwarding Parameters during Construction

Parameters can be cleanly forwarded to your model using standard, idiomatic Dart closures:

```dart
import 'package:preact_signals/preact_signals.dart';

SignalModel<Map<String, dynamic>> createCounterWithInitial(int initialCount) {
  return createModel(() {
    final count = signal(initialCount);
    return <String, dynamic>{
      'count': count,
    };
  })();
}

void main() {
  final counter = createCounterWithInitial(10);
  print(counter['count'].value); // Logs: 10
  counter.dispose();
}
```
