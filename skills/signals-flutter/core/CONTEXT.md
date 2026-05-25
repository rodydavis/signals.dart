# Signals Flutter Core Skills

This directory provides developer/AI agent guidelines and prompt engineering instructions for the fundamental reactivity primitives of the `signals.dart` framework, specifically when applied in a Flutter environment.

## Purpose

To equip AI assistants with rules, syntax examples, and best practices for writing clean, optimized, and memory-safe code using Flutter-compatible core reactive primitives: signals, computed, effects, read-only signals, and batching.

## Detailed File Overviews

### [signal.md](signal.md)
- **Guidance**: Best practices for creating and modifying writable reactive signals (`Signal<T>`) in Flutter apps.
- **Core Principles**: Emphasizes standard `.value` syntax for reading/writing and how to instantiate state variables cleanly within widgets.

### [readonly.md](readonly.md)
- **Guidance**: Patterns for encapsulation and data hiding by converting writable signals into read-only interfaces (`ReadonlySignal<T>`).
- **Core Principles**: Explains how to keep private state signals hidden in controllers or providers while exposing standard public states as read-only to widgets.

### [computed.md](computed.md)
- **Guidance**: Implementation rules for derived states using `computed()`.
- **Core Principles**: Enforces lazy evaluation (only runs when read), automatic dependency tracking, and the strict requirement that computed values must be pure (free of side effects).

### [effect.md](effect.md)
- **Guidance**: How to set up side-effect listeners via `effect()`.
- **Core Principles**: Documents automatic tracking of all signal reads inside the effect, execution upon changes, and return of cleanups to prevent persistent leakage when widgets unmount.

### [batch.md](batch.md)
- **Guidance**: Optimizing performance through transaction grouping via `batch()`.
- **Core Principles**: Groups multiple signal mutations together, postponing downstream computed, effect, and widget rebuild updates until the batch transaction completes.

## Dependencies/Relationships

- **`skills/signals-flutter`**: Extends the general Flutter reactivity parent guide.
- **`signals_flutter` & `signals_core` packages**: Direct guidance for integrating core reactivity into the Flutter framework.

## Usage/Exports

Exposes coding instructions for:
- Standard writable signals (`Signal`)
- Encapsulated read-only signals (`ReadonlySignal`)
- Lazy derived calculations (`Computed`)
- Side-effect tracking listeners (`Effect`)
- Update coalescing transactions (`Batch`)
