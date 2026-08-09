# function `signal`

A <code>Signal</code> is a reactive container for a value that changes over time. It forms the bedrock of the reactive framework, allowing fine-grained, glitch-free propagation of state updates to dependent computeds and effects.

You can read a signal's current state, mutate it to dispatch updates, or subscribe to changes by accessing its <code>.value</code> property inside any active reactive context.

### Core Example
```dart
import 'package:signals/signals.dart';

// Create a reactive signal holding an integer
final counter = signal(0);

// Read the value: prints 0
print(counter.value);

// Write to a signal: dispatches updates to all downstreams synchronously
counter.value = 1;
```

---

## Key API Capabilities

### 1. Reading & Writing via <code>.value</code>
The <code>.value</code> property is the default way to interact with a signal.
- **Inside a Reactive Context:** Accessing <code>.value</code> inside a [computed](/types/computed) block or [effect](/types/effect) callback automatically registers the signal as a dependency, establishing an active subscription.
- **Outside a Reactive Context:** Acts as a standard getter and setter, allowing you to fetch or update the underlying state.

### 2. Non-reactive Reads via <code>.peek()</code>
If you need to read a signal's current value *without* subscribing to its updates inside a reactive context, use the <code>.peek()</code> method. This is invaluable when writing to another signal inside an effect based on the previous state, preventing infinite update loops (cycles).

```dart
final counter = signal(0);
final effectTriggerCount = signal(0);

effect(() {
  // Subscribes to changes of `counter`
  final current = counter.value;
  print('Counter updated: $current');

  // Read current count non-reactively and increment.
  // The effect will NOT subscribe to `effectTriggerCount`.
  effectTriggerCount.value = effectTriggerCount.peek() + 1;
});
```

### 3. Accessing the Previous State via <code>.previousValue</code>
Signals automatically cache their immediately preceding value. Accessing <code>.previousValue</code> lets you perform diffing or historic analysis. Like <code>.peek()</code>, reading <code>.previousValue</code> does not establish a reactive dependency.

```dart
final username = signal("initial_user");

effect(() {
  print('Current Username: ${username.value}');
  print('Previous Username: ${username.previousValue}');
});

username.value = "new_user";
// Prints:
// Current Username: new_user
// Previous Username: initial_user
```

### 4. Force Updates via <code>.set()</code>
When dealing with mutable data types (e.g., custom class instances, collections), mutating properties directly does not change the instance reference. You can force an update using <code>.set(..., force: true)</code> to skip standard equality checks and notify all downstreams.

```dart
final numbers = signal([1, 2, 3]);

// Modify the list in-place and force notify
numbers.value.add(4);
numbers.set(numbers.value, force: true);
```

---

## Lifecycle & Resource Management

### Auto-Disposal
If a signal is constructed with <code>autoDispose: true</code>, it will automatically destroy itself when it no longer has active reactive listeners (subscriptions). This prevents memory leaks by freeing resources as soon as they are out of scope.

```dart
final s = signal(0, options: SignalOptions(autoDispose: true));

s.onDispose(() => print('Signal has been disposed!'));

// Create active subscriber
final dispose = s.subscribe((_) {});

// Cancel subscription: s has no listeners, so it self-disposes
dispose();
// Prints: "Signal has been disposed!"
```

You can manually verify the lifecycle state using <code>.disposed</code>, or register custom clean-up routines via <code>.onDispose(callback)</code>.

---

## Flutter Integration
In Flutter applications, manage state and reactivity seamlessly by using [SignalWidget](/types/signalwidget) (for stateless widgets) or [SignalStatefulWidget](/types/signalstatefulwidget) (for stateful widgets).
These widgets establish an implicit reactive context directly at the element layer. Any signal accessed via <code>.value</code> inside the <code>build</code> method is automatically tracked, and the widget automatically rebuilds when they mutate.

### Stateless Example with [SignalWidget](/types/signalwidget)
```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final counter = signal(0);

class CounterDisplay extends SignalWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Stateful Example with [SignalStatefulWidget](/types/signalstatefulwidget)
```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterDisplay extends SignalStatefulWidget {
  const CounterDisplay({super.key});

  @override
  State<CounterDisplay> createState() => _CounterDisplayState();
}

class _CounterDisplayState extends State<CounterDisplay> {
  // Local signal scoped to this widget state:
  final counter = signal(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Testing Strategies

### 1. Converting to Streams
You can convert any reactive signal into a standard Dart **Stream** by calling <code>.toStream()</code>. This is highly beneficial for testing signal value sequences in order using test matchers.

```dart
test('emits sequential count updates in order', () async {
  final counter = signal(0);
  final stream = counter.toStream();

  counter.value = 1;
  counter.value = 2;

  await expectLater(stream, emitsInOrder([0, 1, 2]));
});
```

### 2. Dependency Injection & Mock Overrides
Global or lazy signals used across your application can be mocked or overridden during testing via <code>.overrideWith(value)</code>. This returns a new signal sharing the same global identifier, helping you mock complex state dependencies seamlessly.

```dart
test('mocking global signals', () {
  final apiToken = signal("production_token");

  // Override with test mock token
  apiToken.overrideWith("mock_test_token");

  expect(apiToken.value, "mock_test_token");
});
```

---

## Signature

```dart
Signal<T> signal(T value, {SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})
```

