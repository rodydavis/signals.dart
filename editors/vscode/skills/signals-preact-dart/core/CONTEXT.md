# Signals Preact Dart Core Skills

This directory provides developer/AI agent guidelines and coding instructions for the core reactivity primitives of the `preact_signals` package.

## Purpose

To equip AI assistants with rules, syntax examples, and best practices for writing clean, optimized, and memory-safe code using the low-level `preact_signals` reactive primitives: signals, computed values, effects, read-only signals, and batching.

## Detailed File Overviews

### [signal.md](signal.md)
- **Guidance**: Best practices for creating and modifying standard writable reactive signals (`Signal<T>`).
- **Core Principles**: Emphasizes standard `.value` syntax for reading/writing and how to instantiate state variables cleanly.

### [readonly.md](readonly.md)
- **Guidance**: Patterns for encapsulation and data hiding by converting writable signals into read-only interfaces (`ReadonlySignal<T>`).
- **Core Principles**: Explains how to keep private state signals hidden in classes/libraries while exposing standard public states as read-only.

### [computed.md](computed.md)
- **Guidance**: Implementation rules for derived states using `computed()`.
- **Core Principles**: Enforces lazy evaluation (only runs when read), automatic dependency tracking, memoization, and the strict requirement that computed values must be pure (free of side effects).

### [effect.md](effect.md)
- **Guidance**: How to set up side-effect listeners via `effect()`.
- **Core Principles**: Documents automatic tracking of all signal reads inside the effect, execution upon changes, and return of cleanups to prevent persistent leakage.

### [batch.md](batch.md)
- **Guidance**: Optimizing performance through transaction grouping via `batch()`.
- **Core Principles**: Groups multiple signal mutations together, postponing downstream computed and effect updates until the batch transaction completes.

## Dependencies/Relationships

- **`skills/signals-preact-dart`**: Extends the general Preact Dart reactivity parent guide.
- **`preact_signals` package**: Maps directly to the low-level core primitives of the underlying Dart package.

## Usage/Exports

Exposes coding instructions for:
- Standard writable signals (`Signal`)
- Encapsulated read-only signals (`ReadonlySignal`)
- Lazy derived calculations (`Computed`)
- Side-effect tracking listeners (`Effect`)
- Update coalescing transactions (`Batch`)
