# Signals Dart Collection Skills

This directory provides developer/AI agent guidelines and coding instructions for high-performance reactive collections in the `signals.dart` framework.

## Purpose

To equip AI assistants with patterns, APIs, and constraints for managing reactive lists, sets, maps, and queues. Standard collections do not trigger updates on in-place mutations; this skill explains how to use reactive collections to ensure changes are propagated automatically to computed signals and observers.

## Detailed File Overviews

### [iterable_signal.md](iterable_signal.md)
- **Guidance**: High-level rules for wrapping generic Dart iterables.
- **Core Principles**: Standardizes reading and filtering elements inside a reactive pipeline.

### [list_signal.md](list_signal.md)
- **Guidance**: Instructions for `ListSignal<E>` (created via `listSignal()` or `.toListSignal()`).
- **Core Principles**: Emphasizes using index mutation operators and custom list methods that automatically notify observers of granular changes.

### [set_signal.md](set_signal.md)
- **Guidance**: Best practices for `SetSignal<E>` (created via `setSignal()` or `.toSetSignal()`).
- **Core Principles**: Tracks insertion, removal, and presence checking of unique elements reactively.

### [map_signal.md](map_signal.md)
- **Guidance**: Guidelines for `MapSignal<K, V>` (created via `mapSignal()` or `.toMapSignal()`).
- **Core Principles**: Focuses on key-value insertions, lookups, updates, and removals that propagate updates down to subscribers.

### [queue_signal.md](queue_signal.md)
- **Guidance**: Patterns for `QueueSignal<E>` (created via `queueSignal()` or `.toQueueSignal()`).
- **Core Principles**: Manages FIFO (First-In, First-Out) or LIFO (Last-In, First-Out) operations reactively.

## Dependencies/Relationships

- **`skills/signals-dart`**: Extends the general Dart reactivity parent guide.
- **`signals_core` package**: Maps onto collections bindings like `ListSignal`, `SetSignal`, `MapSignal`, etc.

## Usage/Exports

Exposes instructions for:
- Reactive arrays and indices (`ListSignal`)
- Reactive unique sets (`SetSignal`)
- Reactive dictionaries and pairs (`MapSignal`)
- Reactive double-ended buffers (`QueueSignal`)
