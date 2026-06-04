# signals_core

The foundational reactivity library for Dart, providing fine-grained state management based on the Preact Signals model.

## Overview

`signals_core` is the high-performance engine that powers the entire `signals.dart` ecosystem. Written as a 100% pure Dart library, it operates perfectly in any environment (CLI, server-side Dart, web, or Flutter). It provides standard reactive primitives with automatic dependency tracking, lazy evaluation, and smart cache invalidation.

## Key Features

- **Fine-grained Reactivity**: Recomputes only nodes in the graph that are strictly affected by mutations.
- **Lazy Evaluation**: Calculations and computations are deferred until their result values are actually read.
- **Async Support**: Native wrappers for Futures and Streams via `AsyncSignal`, `futureSignal()`, and `streamSignal()`, exposing clean loading/error/data states.
- **Rich Extensions**: Idiomatic Dart extension methods to easily cast standard objects (e.g. lists, maps, sets, futures) directly into reactive signals.
- **State Persistence**: Supports persisted signals that automatically serialize to and deserialize from disk or local key-value stores.
- **DevTools Integrated**: Built-in observation hooks to stream reactive graph structures and updates directly to standard developer tooling.

## Directory Structure

### [lib/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/CONTEXT.md)
The public entry points (`signals_core.dart` and `extended.dart`).

- **[src/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/CONTEXT.md)**: Internal implementation.
  - **[core/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/core/CONTEXT.md)**: The reactivity engine.
  - **[async/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/async/CONTEXT.md)**: Future and Stream handlers.
  - **[extensions/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/extensions/CONTEXT.md)**: Dart type enhancements.
  - **[value/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/value/CONTEXT.md)**: Collection signals (List, Map, Set).
  - **[mixins/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/CONTEXT.md)**: Reusable interface behaviors (List, Set, Map, Stream).
  - **[persisted/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/persisted/CONTEXT.md)**: Persistent storage logic.
  - **[utils/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/utils/CONTEXT.md)**: Constants, environment flags, and deep equality helpers.

### [example/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/example/)
Contains basic CLI examples of using signals.

### [test/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/test/)
Comprehensive unit tests for the reactivity engine, collection overrides, and all async and persistent extensions.

## Core Dependencies

- `preact_signals`: The underlying primitive implementation.
- `meta`: Used for annotations.

## Development

The package is part of a Melos monorepo. Use `melos bootstrap` to initialize and `dart test` to run the suite.
