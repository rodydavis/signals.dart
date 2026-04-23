# Signals Nocterm

Reactive state management for [Nocterm](https://nocterm.dev) terminal UIs using [Signals](https://dartsignals.dev).

## Features

- **SignalsMixin** - Mixin for `State` classes to automatically manage signal lifecycle
- **Watch** - Component for fine-grained rebuilds
- **WatchBuilder** - Builder pattern for watching a single signal
- **watchSignal** - Function to watch signals in any build method

## Installation

```yaml
dependencies:
  signals_nocterm: ^0.1.0
```

## Quick Start

### Using SignalsMixin

The most common way to use signals in Nocterm is with the `SignalsMixin`:

```dart
import 'package:nocterm/nocterm.dart';
import 'package:signals_nocterm/signals_nocterm.dart';

class Counter extends StatefulComponent {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> with SignalsMixin {
  // Create signals - they're automatically disposed
  late final _count = createSignal(0);
  late final _doubled = createComputed(() => _count() * 2);

  @override
  void initState() {
    super.initState();
    // Create effects - also automatically disposed
    createEffect(() {
      print('Count: ${_count()}, Doubled: ${_doubled()}');
    });
  }

  @override
  Component build(BuildContext context) {
    return Focusable(
      focused: true,
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKey.space) {
          _count.value++;
          return true;
        }
        return false;
      },
      child: Center(
        child: Text('Count: ${_count()}, Doubled: ${_doubled()}'),
      ),
    );
  }
}
```

### Using Watch for Fine-Grained Rebuilds

Use `Watch` to only rebuild specific parts of your component tree:

```dart
final count = signal(0);

class MyComponent extends StatelessComponent {
  const MyComponent({super.key});

  @override
  Component build(BuildContext context) {
    return Column(
      children: [
        // Only this part rebuilds when count changes
        Watch((context) => Text('Count: ${count()}')),
        // This part never rebuilds
        const Text('Static text'),
      ],
    );
  }
}
```

### Using WatchBuilder

`WatchBuilder` provides a builder pattern for watching a single signal:

```dart
final count = signal(0);

WatchBuilder<int>(
  signal: count,
  builder: (context, value, child) {
    return Text('Count: $value');
  },
  // Optional child that doesn't rebuild
  child: const Text('Static child'),
)
```

### Using watchSignal Extension

You can also use the `watch` extension on any signal:

```dart
class MyComponent extends StatelessComponent {
  final count = signal(0);

  @override
  Component build(BuildContext context) {
    // This component rebuilds when count changes
    final value = count.watch(context);
    return Text('Count: $value');
  }
}
```

## API Reference

### SignalsMixin

Methods available when using `SignalsMixin`:

| Method | Description |
|--------|-------------|
| `createSignal<T>(value)` | Create a signal that's automatically disposed |
| `createComputed<T>(fn)` | Create a computed signal |
| `createEffect(fn)` | Create an effect that's automatically disposed |
| `createListSignal<T>(list)` | Create a list signal |
| `createMapSignal<K,V>(map)` | Create a map signal |
| `createSetSignal<T>(set)` | Create a set signal |
| `createFutureSignal<T>(fn)` | Create a future-based signal |
| `createStreamSignal<T>(fn)` | Create a stream-based signal |
| `bindSignal(signal)` | Watch an external signal |
| `unbindSignal(signal)` | Stop watching a signal |
| `watchSignal(signal)` | Get value and watch signal |
| `listenSignal(signal, callback)` | Listen to signal changes |
| `disposeSignal(id)` | Manually dispose a signal |

### Components

| Component | Description |
|-----------|-------------|
| `Watch` | Rebuilds its child when any accessed signal changes |
| `WatchBuilder<T>` | Builder pattern for a single signal |

### Functions

| Function | Description |
|----------|-------------|
| `watchSignal<T>(context, signal)` | Watch a signal in any build method |
| `unwatchSignal<T>(context, signal)` | Stop watching a signal |

## License

MIT
