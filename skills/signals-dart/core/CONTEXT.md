# Signals Dart Core Skills

This directory provides developer/AI agent guidelines and prompt engineering instructions for the fundamental reactivity primitives of the `signals.dart` framework.

## Purpose

To equip AI assistants with rules, syntax examples, and best practices for writing clean, optimized, and memory-safe code using Dart's core reactive primitives: signals, computed, effects, read-only signals, and batching.

## Detailed File Overviews

### [signal.md](signal.md)
- **Guidance**: Best practices for creating and modifying writable reactive signals (`Signal<T>`).
- **Core Principles**: Emphasizes using standard `.value` syntax for reading/writing and how to instantiate state variables cleanly.

### [readonly.md](readonly.md)
- **Guidance**: Patterns for encapsulation and data hiding by converting writable signals into read-only interfaces (`ReadonlySignal<T>`).
- **Core Principles**: Recommends keeping private `_state` signals hidden while exposing standard public `state` as read-only to external callers to enforce unidirectional data flow.

### [computed.md](computed.md)
- **Guidance**: Implementation rules for derived state using `computed()`.
- **Core Principles**: Enforces lazy evaluation (only runs when read), automatic dependency tracking, and the strict requirement that computed values must be pure (free of side effects).

### [effect.md](effect.md)
- **Guidance**: How to set up side-effect listeners via `effect()`.
- **Core Principles**: Documents automatic tracking of all signal reads inside the effect, execution upon changes, and return of cleanups to prevent persistent leakage.

### [batch.md](batch.md)
- **Guidance**: Optimizing performance through transaction grouping via `batch()`.
- **Core Principles**: Groups multiple signal mutations together, postponing downstream computed and effect updates until the batch transaction completes.

## Dependencies/Relationships

- **`skills/signals-dart`**: Extends the general Dart reactivity parent guide.
- **`signals_core` package**: These rules directly map onto the implementation details of the core Dart package.

## Usage/Exports

Exposes coding instructions for:
- Standard writable signals (`Signal`)
- Encapsulated read-only signals (`ReadonlySignal`)
- Lazy derived calculations (`Computed`)
- Side-effect tracking listeners (`Effect`)
- Update coalescing transactions (`Batch`)
