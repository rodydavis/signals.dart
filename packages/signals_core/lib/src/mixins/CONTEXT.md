# Signal Mixins

This directory provides a set of reusable mixins that enhance basic signals with specialized interfaces and behaviors.

## Purpose

The mixins allow the library to provide "fat" interfaces (like a `Signal` that is also a `List`) without duplicating code. They bridge the gap between reactive state and common Dart patterns such as Collections, Sinks, and Streams.

## Key Categories

### Collection Interface Mixins
These mixins implement standard Dart collection interfaces. They delegate read operations to the underlying `value` and wrap mutation operations to trigger signal updates.
- **[iterable.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/iterable.dart)**: Base mixin for all iterables.
- **[list.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/list.dart)**: Implements `List<E>`, including operator `[]=` and search/sort methods.
- **[map.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/map.dart)**: Implements `Map<K, V>`.
- **[set.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/set.dart)**: Implements `Set<E>`.
- **[queue.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/queue.dart)**: Implements `Queue<E>`.

### Behavioral Mixins
Add cross-cutting concerns to signals.
- **[changestack.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/changestack.dart)**: Adds `undo()` and `redo()` history management.
- **[tracked.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/tracked.dart)**: Maintains `initialValue` and `previousValue` snapshots.

### Sink/Stream Mixins
Enable interoperability with Dart's async primitives.
- **[sink.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/sink.dart)**: Implements `Sink<T>`, where `add(val)` calls `set(val)`.
- **[event_sink.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/event_sink.dart)**: Specialized sink for signals holding `AsyncState`.
- **[stream.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/stream.dart)**: Bridges a signal to the `Stream` interface, allowing it to be used with `Stream` utilities.

## Usage Note
These mixins are primarily used by the concrete signal implementations found in `lib/src/value` and by the various extension methods in `lib/src/extensions`.
