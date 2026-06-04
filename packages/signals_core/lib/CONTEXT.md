# Signals Core Public API

This directory defines the public interface and primary entry points for the `signals_core` package.

## Main Entry Point

### [signals_core.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/signals_core.dart)
This is the primary library file. It exports the entire reactive signal ecosystem for Dart, including:
- **Core Primitives**: `signal`, `computed`, `effect`, `batch`, `untracked`.
- **Async Utilities**: `AsyncSignal`, `futureSignal`, `streamSignal`, `connect`, and the `AsyncState` union.
- **Extensions**: Reactive methods for converting and watching standard Dart types (e.g. lists, streams, futures, value listenables).
- **Concrete Values**: Specialized signals for `List`, `Map`, `Set`, `Queue`, and `Timer`.
- **Mixins**: Interfaces for implementing standard collections, streams, or undo/redo stacks.
- **Persistence**: `PersistedSignal` and local storage backend integrations.
- **DevTools**: Signals DevTools inspection and dependency logging.

## Secondary Entry Points

### [extended.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/extended.dart)
A utility library that exposes `SignalObjectUtils`. This is kept separate from the main import to allow users to opt-in to generic object extensions (like `.$` on any object) if they find them useful, while avoiding global namespace pollution by default.

## Implementation Details

The actual implementation logic for all features is located in the **[src/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/CONTEXT.md)** directory. Developers should almost always import `package:signals_core/signals_core.dart` rather than reaching directly into `src`.

## Usage Example

```dart
import 'package:signals_core/signals_core.dart';

final count = signal(0);
final doubled = computed(() => count() * 2);

effect(() {
  print('Count is: ${count()}, Doubled is: ${doubled()}');
});

count.value++; // Triggers the effect
```
