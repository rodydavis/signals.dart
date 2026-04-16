# Preact Signals Internal Engine

This directory contains the low-level "Pulse" reactivity engine, ported from Preact Signals to Dart. It is the fundamental dependency for the entire ecosystem.

## Core Concepts

### Dependency Graph (`node.dart`)
The system uses a doubly-linked list of `Node` objects to track relationships between **sources** (Signals/Computeds) and **targets** (Computeds/Effects).
- **Sources**: The nodes that provide data.
- **Targets**: The nodes that consume data.
- **Version Tracking**: Each node stores the `version` of the source it last saw. If the source version matches the node version, no recomputation is needed.

### Evaluation Context (`globals.dart`)
The `evalContext` global variable tracks the currently executing Computed or Effect. When a signal is read, it automatically registers itself as a source for the `evalContext`.

### Listenable Mixin (`listenable.dart`)
A mixin that provides common logic for nodes that can have sources (Computed and Effect). It handles `prepareSources()` and `cleanupSources()` to manage dynamic dependency tracking (e.g., in `if` statements).

## Modules

- **[signal.dart](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/lib/src/signal.dart)**: The basic writable primitive. Increments `version` and `globalVersion` on update.
- **[computed.dart](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/lib/src/computed.dart)**: A derived signal that is both a source and a target. It is lazy and only recomputes when its version is stale.
- **[effect.dart](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/lib/src/effect.dart)**: A terminal consumer that runs a callback when dependencies change.
- **[batch.dart](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/lib/src/batch.dart)**: Defers `notify()` calls until the end of a block, preventing unnecessary intermediate recomputations.
- **[untracked.dart](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/lib/src/untracked.dart)**: Temporarily nullifies `evalContext` to allow reading signals without creating a subscription.

## Performance Design

- **@internal**: Almost everything is internal, as this package provides the raw engine.
- **Pragma inlining**: Extensive use of `vm:prefer-inline` and `wasm:prefer-inline` for critical hot paths (getters/setters).
- **Linked Lists**: Using linked lists instead of `Set` or `List` for dependencies avoids allocations and allows for efficient O(1) addition/removal.
