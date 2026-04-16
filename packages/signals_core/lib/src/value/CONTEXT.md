# Concrete Value Signals

This directory contains specialized signal implementations that provide first-class support for Dart collections and advanced state behaviors.

## Purpose

While a basic `Signal<T>` can hold any value, these specialized subclasses offer better APIs and optimized reactivity for specific types, such as Lists, Maps, and trackable values.

## Key Classes

### Collection Signals
These signals implement the core Dart collection interfaces. They use mixins to provide both the reactive signal behavior and the standard collection API.
- **[list.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/value/list.dart)**: `ListSignal<E>` - A reactive list.
- **[map.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/value/map.dart)**: `MapSignal<K, V>` - A reactive map.
- **[set.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/value/set.dart)**: `SetSignal<E>` - A reactive set.
- **[queue.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/value/queue.dart)**: `QueueSignal<T>` - A reactive queue.
- **[iterable.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/value/iterable.dart)**: `IterableSignal<E>` - A reactive generic iterable.

### Behavioral Signals
Signals that add specific state-tracking logic.
- **[change_stack.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/value/change_stack.dart)**: `ChangeStackSignal<T>` - Maintains an undo/redo history of values.
- **[tracked.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/value/tracked.dart)**: `TrackedSignal<T>` - Automatically stores the `initialValue` and `previousValue` snapshots.

## Structural Features

- **Part/Part of**: The directory uses a central `value.dart` file as a container, with each implementation defined in its own `.dart` file as a "part".
- **Operator Overloads**: Collection signals often support:
    - `<<`: Inject/Add data to the existing collection.
    - `&`: Create a new signal representing the concatenation of the source and a parameter.
    - `|`: Pipe values from one signal/iterable to another.

## Relationships

- **Mixins**: These classes rely heavily on the mixins defined in `lib/src/mixins`.
- **Core Module**: All classes inherit from the base `Signal<T>` in `lib/src/core`.
