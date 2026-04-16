# signals_core

The foundational reactivity library for Dart, providing fine-grained state management based on the Preact Signals model.

## Overview

`signals_core` is the engine that powers the entire `signals.dart` ecosystem. It is a 100% Dart native library that works in any environment (CLI, Server, Web, Flutter). It provides the essential primitives needed to model complex business logic with automatic dependency tracking and lazy evaluation.

## Key Features

- **Fine-grained Reactivity**: Recomputes only what is strictly necessary.
- **Lazy Evaluation**: Calculations are deferred until a value is actually read.
- **Async First**: Built-in support for Futures and Streams via `AsyncState`.
- **Natural API**: Extensions move reactive logic directly onto standard Dart types.
- **Persistence**: Built-in hooks for saving state to disk/memory.
- **DevTools Integrated**: Deep visibility into the reactive graph via Dart DevTools.

## Directory Structure

### [lib/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/CONTEXT.md)
The public entry points (`signals_core.dart` and `extended.dart`).

- **[src/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/CONTEXT.md)**: Internal implementation.
  - **[core/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/CONTEXT.md)**: The reactivity engine.
  - **[async/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/async/CONTEXT.md)**: Future and Stream handlers.
  - **[extensions/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/extensions/CONTEXT.md)**: Dart type enhancements.
  - **[value/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/value/CONTEXT.md)**: Collection signals (List, Map).
  - **[mixins/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/CONTEXT.md)**: Reusable interface behaviors.
  - **[persisted/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/persisted/CONTEXT.md)**: Persistent storage logic.
  - **[utils/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/utils/CONTEXT.md)**: Constants and equality helpers.

### [example/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/example/)
Contains basic CLI examples of using signals.

### [test/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/test/)
Comprehensive unit tests for the reactivity engine and all extensions.

## Core Dependencies

- `preact_signals`: The underlying primitive implementation.
- `meta`: Used for annotations.

## Development

The package is part of a Melos monorepo. Use `melos bootstrap` to initialize and `dart test` to run the suite.
