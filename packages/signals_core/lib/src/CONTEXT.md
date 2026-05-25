# Signals Core Internal Implementation

This directory contains the internal source code for the `signals_core` package, organized into highly specialized modules.

## Architecture Overview

The reactivity system is built on a modular foundation, separating core reactive engine logic from asynchronous primitives, collection-level overrides, behavioral mixins, and developer inspection tooling.

## Key Modules

### [core/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/core/CONTEXT.md)
The fundamental reactivity engine. It defines `Signal`, `Computed`, `Effect`, `SignalsObserver`, and the dependency tracking orchestrator.

### [async/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/async/CONTEXT.md)
Extensions for asynchronous data. Introduces `AsyncState` (Data, Error, Loading) and specialized `FutureSignal` and `StreamSignal` types for wrapping asynchronous data sources natively into the signal graph.

### [value/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/value/CONTEXT.md)
Concrete signal implementations for common data structures like list, map, set, queue, as well as specialized behaviors like tracked and changestack.

### [mixins/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/mixins/CONTEXT.md)
Reusable logic mixins that implement standard Dart interfaces (like `Iterable`, `List`, `Map`, `Queue`, `Set`, `Sink`, `Stream`) or append cross-cutting capabilities (like undo/redo stack histories) to signals.

### [extensions/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/extensions/CONTEXT.md)
Developer-friendly API enhancements. Exposes reactive extension operators on core Dart types, signal-to-stream shortcuts, and proxies.

### [persisted/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/persisted/CONTEXT.md)
Concrete signal extensions designed to automatically persist their state to, and restore their state from, key-value stores (e.g., local storage or shared preferences).

### [utils/](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/utils/CONTEXT.md)
Internal constants, helper utilities, and debugging checks.

## Developer Tooling

### [devtool.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/lib/src/devtool.dart)
This module implements the **`DevToolsSignalsObserver`**. 
- It logs signal/computed creation, update, and deletion lifecycle events.
- It registers custom Dart Service Extensions (`ext.signals.getAllNodes` and others) to expose the full dependency graph and live signal values to the Signals DevTools browser extension or standard Dart/Flutter DevTools.

## Update Propagation Flow
Updates flow reactively from `Signal` (source nodes) -> `Computed` (intermediate nodes) -> `Effect` (leaf nodes). The graph engine in `core` manages automatic subscription pruning and dynamic dependency tracking during evaluations. Batching operations are supported via `batch()` to defer notification dispatches until all mutations finish.
