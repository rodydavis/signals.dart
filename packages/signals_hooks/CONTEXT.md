# signals_hooks

A integration layer that combines the power of Signals with the declarative lifecycle management of `flutter_hooks`.

## Overview

`signals_hooks` allows developers to use signals directly inside a `HookWidget` via a collection of over 20+ specialized hooks. This eliminates the need for manual `initState`/`dispose` or the `SignalsMixin` when using hooks, while still providing surgical rebuilds.

## Key Features

- **Lifecycle Aware**: Signals and effects created with hooks are automatically disposed of when the widget is unmounted.
- **Full Library Coverage**: Includes hooks for all signal types, including `ListSignal`, `MapSignal`, `FutureSignal`, and `TrackedSignal`.
- **Easy Bridging**: Convert standard `ValueNotifier` objects to reactive signals with a single line: `useValueNotifierToSignal(notifier)`.

## Directory Structure

### [lib/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_hooks/lib/CONTEXT.md)
The main hook collection and re-exports.
- **[src/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_hooks/lib/src/CONTEXT.md)**: Categorized hook implementations (async, value, core).

### [example/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_hooks/example/)
Examples demonstrating how to replace `SignalsMixin` or `Watch` widgets with hooks for more concise code.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  signals_hooks: any
  flutter_hooks: any
```

## Usage Example

```dart
class CounterWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // Persistent signal across rebuilds
    final count = useSignal(0);
    
    // Automatic cleanup
    useSignalEffect(() => print('Count: ${count.value}'));
    
    return IconButton(
      onPressed: () => count.value++,
      icon: const Icon(Icons.add),
    );
  }
}
```
