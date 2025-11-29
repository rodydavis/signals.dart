# Usage

## Packages

- `signals`: The main package for Flutter apps (includes `signals_core` and `signals_flutter`).
- `signals_core`: For pure Dart projects (CLI, Server, etc.).
- `signals_flutter`: Flutter specific extensions (included in `signals`).
- `signals_hooks`: Integration with `flutter_hooks`.

## Core (signals_core)

### Signals

Create a signal:

```dart
import 'package:signals_core/signals_core.dart';

final counter = signal(0);
```

Read value:

```dart
print(counter.value);
```

Update value:

```dart
counter.value++;
```

#### Peek

Read a signal's value without subscribing to it (useful inside effects):

```dart
effect(() {
  // Read value without subscribing
  final current = counter.peek();
  print('Current: $current');
});
```

### Computed

Derive state from other signals. Computed signals are lazy and memoized.

```dart
final count = signal(0);
final doubleCount = computed(() => count.value * 2);
```

### Effects

React to changes. Effects subscribe to all signals read within them.

```dart
effect(() {
  print('Count: ${count.value}');
});
```

#### Cleanup

Return a cleanup function from an effect to unsubscribe:

```dart
final dispose = effect(() {
  print('Count: ${count.value}');
});

// Later
dispose();
```

#### Cycle Warning

Mutating a signal inside an effect that reads it will cause an infinite loop. Use `untracked` or `peek` to avoid this.

```dart
effect(() {
  print(count.value);
  // count.value++; // THROWS CYCLE ERROR
});
```

### Untracked

Run a function without tracking any signal reads:

```dart
effect(() {
  print(count.value);
  untracked(() {
    // Reading signals here won't cause the effect to re-run
    print(otherSignal.value);
  });
});
```

### Batch

Combine multiple updates into a single notification:

```dart
batch(() {
  name.value = "Foo";
  surname.value = "Bar";
});
```

### Collections

Signals for mutable collections that implement the standard Dart interfaces (`List`, `Map`, `Set`).

#### ListSignal

```dart
final list = listSignal([1, 2, 3]);
// or
final list = [1, 2, 3].toSignal();

list.add(4); // Triggers updates
list[0] = 10; // Triggers updates
```

#### MapSignal

```dart
final map = mapSignal({'a': 1});
// or
final map = {'a': 1}.toSignal();

map['b'] = 2; // Triggers updates
```

#### SetSignal

```dart
final set = setSignal({1, 2});
// or
final set = {1, 2}.toSignal();

set.add(3); // Triggers updates
```

### Advanced

#### ChangeStack (Undo/Redo)

Track history of a signal:

```dart
final s = ChangeStackSignal(0, limit: 5);
s.value = 1;
s.value = 2;

s.undo(); // value is 1
s.redo(); // value is 2
```

#### Signal Container

Create signals dynamically based on arguments, with optional caching.

```dart
final users = signalContainer<String, User>((id) {
  return signal(fetchUser(id));
}, cache: true);

final user1 = users('1'); // Creates signal
final user1Again = users('1'); // Returns cached signal
```

#### SignalsObserver

Observe all signal updates (useful for debugging/logging).

```dart
SignalsObserver.instance = LoggingSignalsObserver();
```

## Flutter (signals_flutter)

### Watch

Rebuild widgets when signals change. This is the preferred way to consume signals in widgets.

```dart
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart'; // or package:signals/signals.dart

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return Text('Count: ${counter.value}');
    });
  }
}
```

### Watch.builder

Drop-in replacement for `Builder`:

```dart
Watch.builder(
  builder: (context) => Text('Count: ${counter.value}'),
)
```

### SignalsMixin

Manage signal lifecycle in StatefulWidgets. Signals created with `createSignal` or `createComputed` are automatically disposed when the widget is removed.

```dart
class _MyState extends State<MyWidget> with SignalsMixin {
  late final counter = createSignal(0);
  late final doubleCount = createComputed(() => counter.value * 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Count: $counter'), // .toString() returns value
          Text('Double: $doubleCount'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value++,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### Extensions

Watch a signal in a widget (alternative to `Watch` widget):

```dart
Text('Count: ${counter.watch(context)}')
```

## Hooks (signals_hooks)

Integration with `flutter_hooks`.

### useSignal

Create a signal in a HookWidget:

```dart
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class Example extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);
    return Text('Count: $count');
  }
}
```

### useComputed

Create a computed signal in a HookWidget:

```dart
final count = useSignal(0);
final doubleCount = useComputed(() => count.value * 2);
```

### useSignalEffect

Create an effect in a HookWidget:

```dart
useSignalEffect(() {
  print('count: $count');
});
```
