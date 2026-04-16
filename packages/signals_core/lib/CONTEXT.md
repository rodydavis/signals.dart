# Signals Core Public API

This directory defines the public interface for the `signals_core` package.

## Main Entry Point

### [signals_core.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/signals_core.dart)
This is the primary library file. It exports the entire reactivity system, including:
- **Core Primitives**: `signal`, `computed`, `effect`, `batch`, `untracked`.
- **Async Utilities**: `AsyncSignal`, `futureSignal`, `streamSignal`, `connect`, and the `AsyncState` union.
- **Extensions**: All helper methods for creating signals from standard Dart types.
- **Concrete Values**: Specialized signals for `List`, `Map`, `Set`, and `Timer`.
- **Mixins**: Interfaces for implementing standard Dart types on signals.
- **Persistence**: `PersistedSignal` and various storage backends.
- **DevTools**: Integration with the Dart DevTools ecosystem.

## Secondary Entry Points

### [extended.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/extended.dart)
A utility library that exposes `SignalObjectUtils`. This is kept separate from the main import to allow users to opt-in to generic object extensions (like `.$` on any object) if they find them useful, while avoiding global namespace pollution by default.

## Implementation Details

The actual logic for all features is located in the **[src/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/CONTEXT.md)** directory. Developers should almost always import `package:signals_core/signals_core.dart` rather than reaching into `src`.

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
