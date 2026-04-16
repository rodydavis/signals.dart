# Signals Core Internal Implementation

This directory contains the internal source code for the `signals_core` package, organized into specialized modules.

## Architecture Overview

The reactivity system is built on a modular foundation, separating core logic from asynchronous primitives, behavioral mixins, and developer tooling.

## Key Modules

### [core/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/CONTEXT.md)
The fundamental reactivity engine. Defines `Signal`, `Computed`, `Effect`, and the dependency tracking orchestrator.

### [async/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/async/CONTEXT.md)
Extensions for asynchronous data. Introduces `AsyncState` and specialized `FutureSignal`/`StreamSignal` types for handling futures and streams reactively.

### [value/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/value/CONTEXT.md)
Concrete signal implementations for common data structures (List, Map, Set) and patterns (Tracked, ChangeStack).

### [mixins/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/mixins/CONTEXT.md)
Reusable logic blocks that implement standard Dart interfaces (like `Collection` or `Stream`) or add behavior (like undo/redo) to signals.

### [extensions/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/extensions/CONTEXT.md)
Dev-friendly API enhancements. Provides the `$` shortcut for signal creation and proxy methods to access value properties directly on signals.

### [persisted/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/persisted/CONTEXT.md)
Signals that automatically save and load state from a key-value store.

### [utils/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/utils/CONTEXT.md)
Internal constants, environment detection (debug/release), and auxiliary logic like deep equality.

## Developer Tooling

### [devtool.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/devtool.dart)
This file implements the `DevToolsSignalsObserver`, which registers Dart Service Extensions. This allows the Signals browser extension or Dart DevTools to visualize the reactive dependency graph and inspect signal values in real-time.

## Communication Pattern
Updates typically flow from `Signal` -> `Computed` -> `Effect`. The tracking system in `core` ensures that only affected nodes are recomputed, and `batch` operations can defer these updates for performance.
