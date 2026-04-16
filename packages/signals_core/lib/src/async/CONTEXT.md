# Async Reactivity Utilities

This directory provides specialized signal types and state management for asynchronous operations, such as working with `Future` and `Stream` objects.

## Purpose

The async module extends the core reactivity system to handle the inherent complexity of asynchronous data. it introduces `AsyncState`, a robust way to represent loading, data, and error states, and specialized signals that automatically manage the lifecycle of futures and streams.

## Detailed File Overviews

### [state.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/async/state.dart)
Defines the `AsyncState` sealed union, which is the cornerstone of async handling in this library. It includes:
- `AsyncLoading`: Indicates that an operation is in progress.
- `AsyncData`: Contains the successfully resolved value.
- `AsyncError`: Contains an error and stack trace.
- `Refreshing` and `Reloading` variants: Allow for tracking background updates while still holding onto previous data or errors.

### [signal.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/async/signal.dart)
Implements `AsyncSignal`, a writable signal that holds an `AsyncState`. It provides helper methods like `setValue`, `setError`, and `setLoading`, as well as a `.future` getter to await the next resolved value.

### [future.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/async/future.dart)
Implements `FutureSignal`, which executes an asynchronous callback and stores the result in an `AsyncState`. It supports automatic re-execution when dependent signals change and provides methods for refreshing or reloading the underlying future.

### [stream.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/async/stream.dart)
Implements `StreamSignal`, which listens to a `Stream` and updates its `AsyncState` with every new event. It handles subscription management, pausing, resuming, and automatic disposal.

### [connect.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/async/connect.dart)
Exposes the `connect` utility, which allows piping one or more `Stream` objects into a single `Signal`. This is useful for synchronizing external event sources with the internal reactive state.

### [computed.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/async/computed.dart)
Provides "syntax sugar" for creating `FutureSignal` instances:
- `computedFrom`: Takes a explicit list of dependencies.
- `computedAsync`: Automatically tracks dependencies read within the callback (provided they are read before any `await`).

## Dependencies/Relationships

- **Core module**: Inherits from `Signal` and `Computed` classes defined in `lib/src/core`.
- **Preact Signals**: Uses the underlying reactivity primitives for tracking dependencies.

## Usage/Exports

- `asyncSignal(state)`: Manual async state management.
- `futureSignal(() => ...)`: Reactive future handling.
- `streamSignal(() => ...)`: Reactive stream handling.
- `connect(signal).from(stream)`: Pipe streams to signals.
- `computedFrom(...)` and `computedAsync(...)`: Async derived state.
- `AsyncState`: The unified state representing async transitions.
