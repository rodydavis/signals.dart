# signals_hooks

An integration layer that combines the power of Signals with the declarative lifecycle management of `flutter_hooks`.

## Overview

`signals_hooks` allows developers to use signals directly inside a `HookWidget` via a collection of specialized hooks. This eliminates the need for manual `initState`/`dispose` lifecycles or the `SignalsMixin` when using hooks, while still providing surgical, optimized rebuilds.

## Key Features

- **Lifecycle Aware**: Signals and effects created via hooks are automatically registered, tracked, and disposed of when the widget is unmounted.
- **Comprehensive Hook Collection**: Includes specialized hooks for creating and observing collections and async utilities, such as `useSignal`, `useComputed`, `useSignalEffect`, `useFutureSignal`, `useStreamSignal`, `useListSignal`, `useSetSignal`, `useMapSignal`, and `useTrackedSignal`.
- **Interoperability**: Convert standard Flutter `ValueNotifier` objects to reactive signals with a single line: `useValueNotifierToSignal(notifier)`.

## Directory Structure

### [lib/](file:///Users/rodydavis/dev/signals.dart/packages/signals_hooks/lib/CONTEXT.md)
The main hook collection and re-exports.
- **[src/](file:///Users/rodydavis/dev/signals.dart/packages/signals_hooks/lib/src/CONTEXT.md)**: Categorized hook implementations.

### [example/](file:///Users/rodydavis/dev/signals.dart/packages/signals_hooks/example/)
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
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class CounterWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // Persistent signal across rebuilds
    final count = useSignal(0);
    
    // Automatic cleanup on unmount
    useSignalEffect(() => print('Count: ${count.value}'));
    
    return IconButton(
      onPressed: () => count.value++,
      icon: const Icon(Icons.add),
    );
  }
}
```
