# Signal Core Mixins

This directory provides a set of reusable mixins that enhance core signals with specialized interfaces and behaviors.

## Purpose

The mixins allow `signals_core` to expose comprehensive, feature-rich interfaces (like treating a `Signal` as a standard Dart `List`, `Set`, `Map`, `Queue`, or `Stream`) without duplicating implementation details across concrete subclasses. They bridge the gap between reactive state management and standard Dart collections/APIs.

## Key Categories

### Collection Interface Mixins
These mixins implement standard Dart collection interfaces, delegating read operations to the underlying signal `.value` and wrapping mutation operations to trigger signal updates automatically.
- **[iterable.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/iterable.dart)**: Base mixin that implements the standard Dart `Iterable<E>` interface on top of a `ReadonlySignal<Iterable<E>>`. It delegates iteration, search, and checking methods to the underlying elements.
- **[list.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/list.dart)**: Implements the full `List<E>` interface on a `Signal<List<E>>`. It intercepts all mutation methods (e.g., `[]=` operator, `add()`, `insert()`, `remove()`, `clear()`, `sort()`) to automatically update the signal's value and notify observers.
- **[map.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/map.dart)**: Implements the full `Map<K, V>` interface on a `Signal<Map<K, V>>`, overriding mutators like `[]=`, `addAll()`, `clear()`, `remove()`, and `putIfAbsent()`.
- **[set.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/set.dart)**: Implements the `Set<E>` interface on a `Signal<Set<E>>`, managing set-specific operations like adding, removing, and lookup.
- **[queue.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/queue.dart)**: Implements the `Queue<E>` interface on a `Signal<Queue<E>>` for double-ended queues.

### Behavioral Mixins
Add cross-cutting capabilities to signals.
- **[changestack.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/changestack.dart)**: Implements `ChangeStackSignalMixin<T>`, which provides undo/redo history management for signals. It maintains an internal `_undo` and `_redo` stack with an optional size limit.
- **[tracked.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/tracked.dart)**: Implements `TrackedSignalMixin<T>`, which captures and tracks the `initialValue` and `previousValue` (if one exists) across signal updates.

### Sink/Stream/EventSink Mixins
Enable seamless interoperability with Dart's async primitives.
- **[sink.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/sink.dart)**: Implements the `Sink<T>` interface on a `Signal<T>`, mapping `add(val)` to calling `set(val)`.
- **[event_sink.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/event_sink.dart)**: Specialized sink mixin for signals holding `AsyncState<T>`, implementing `EventSink<T>`.
- **[stream.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/stream.dart)**: Implements the full Dart `Stream<T>` interface on a signal. It handles stream controller lifecycle, listening, pausing, resuming, and closing automatically when the signal is disposed.

## Usage Note
These mixins are primarily used by concrete signal classes defined in `lib/src/value/` and by the reactive extensions in `lib/src/extensions/`.
