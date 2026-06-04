# Signals Dart Skills

This directory contains advanced prompt instructions and developer guides for `signals_core` in the `signals.dart` monorepo reactivity system.

## Purpose

To organize, store, and provide structured patterns for writing pure Dart reactive state components. It maps coding assistants to best practices for core reactivity, async signal binding, high-performance collections, and state utility extensions.

## Structure & Subdirectories

This folder is structured into focused areas:

### 1. [core/](core/CONTEXT.md)
Contains guidelines for standard reactivity primitives:
- [signal.md](core/signal.md): Writable signals.
- [readonly.md](core/readonly.md): Unidirectional read-only signal encapsulation.
- [computed.md](core/computed.md): Side-effect-free, lazy derived state.
- [effect.md](core/effect.md): Lifecycle-bound observer blocks.
- [batch.md](core/batch.md): Grouping state updates to prevent re-rendering churn.

### 2. [async/](async/CONTEXT.md)
Covers asynchronous integration:
- [async_signal.md](async/async_signal.md): Unified loading/success/error state containers.
- [future_signal.md](async/future_signal.md): Optimized future resolution signals.
- [stream_signal.md](async/stream_signal.md): Auto-disposing stream listeners.
- [computed_async.md](async/computed_async.md): Composable async operations with race condition protection.
- [computed_from.md](async/computed_from.md): Trigger-based async re-evaluations.

### 3. [collections/](collections/CONTEXT.md)
Documents reactive collection structures:
- [list_signal.md](collections/list_signal.md): Element-level list reactivity.
- [set_signal.md](collections/set_signal.md): Duplicate-ignoring unique item sets.
- [map_signal.md](collections/map_signal.md): Key-value map reactivity.
- [iterable_signal.md](collections/iterable_signal.md): Lazy traversal subscriptions.
- [queue_signal.md](collections/queue_signal.md): Double-ended queue pipelines.

### 4. [utils/](utils/CONTEXT.md)
Covers utility helpers:
- [linked_signal.md](utils/linked_signal.md): Computations with manual overrides.
- [tracked_signal.md](utils/tracked_signal.md): Time-travel / history tracking (undo/redo).
- [timer_signal.md](utils/timer_signal.md): Periodic time-based clock ticks.
- [connect.md](utils/connect.md): Multi-source event piping.

## Core Content Overview

- **Quick Start Guide (`SKILL.md`)**: Contains absolute basics (how to write a signal, access `.value`, use `.peek()` to prevent subscription loops, wrap untracked code, batch writes, and use memoized `computed` or `effect` observations).
- **Options Equality**: Defines options class semantics (e.g. `SignalOptions`, `ComputedOptions`), ensuring custom copyable configurations and structural value semantics.

## Usage/Exports

This directory is utilized in developer training and AI prompt injection to ensure all generated Dart code implements `signals.dart` correctly and optimally.
