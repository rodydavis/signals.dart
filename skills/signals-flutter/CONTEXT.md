# Signals Flutter Skills

This directory contains prompt instructions and developer guides for `signals_flutter` in the `signals.dart` monorepo.

## Purpose

To organize, store, and provide structured patterns for integrating pure Dart reactive state components into Flutter applications. It instructs coding assistants on how to build high-performance, memory-safe, and GPU-optimized user interfaces.

## Structure & Subdirectories

This folder is structured into focused areas:

### 1. [core/](core/CONTEXT.md)
Covers core primitives in Flutter:
- [signal.md](core/signal.md): Writable signals in widgets.
- [readonly.md](core/readonly.md): Encapsulation patterns.
- [computed.md](core/computed.md): Side-effect-free, lazy derived state.
- [effect.md](core/effect.md): Lifecycle-bound observer blocks.
- [batch.md](core/batch.md): Grouping mutations to prevent rebuild churn.

### 2. [async/](async/CONTEXT.md)
Covers asynchronous integration in Flutter:
- [async_signal.md](async/async_signal.md): Loading/success/error UI states.
- [future_signal.md](async/future_signal.md): Optimized future resolution.
- [stream_signal.md](async/stream_signal.md): Auto-disposing stream listeners.
- [computed_async.md](async/computed_async.md): Composable async operations with race condition protection.
- [computed_from.md](async/computed_from.md): Trigger-based async re-evaluations.

### 3. [collections/](collections/CONTEXT.md)
Documents reactive collection structures for Flutter:
- [list_signal.md](collections/list_signal.md): Element-level list reactivity.
- [set_signal.md](collections/set_signal.md): Unique item sets.
- [map_signal.md](collections/map_signal.md): Key-value map updates.
- [iterable_signal.md](collections/iterable_signal.md): Lazy traversal subscriptions.
- [queue_signal.md](collections/queue_signal.md): Double-ended queue pipelines.

### 4. [utils/](utils/CONTEXT.md)
Covers utility helpers:
- [linked_signal.md](utils/linked_signal.md): Derived values with override resets.
- [tracked_signal.md](utils/tracked_signal.md): State history (undo/redo).
- [timer_signal.md](utils/timer_signal.md): Time-based clock ticks.
- [connect.md](utils/connect.md): Multi-source event piping.

### 5. [widgets/](widgets/CONTEXT.md)
Documents widget and builder components:
- [signal_builder.md](widgets/signal_builder.md): Isolated builder subtrees.
- [signal_widget.md](widgets/signal_widget.md): Component-level implicit reactive state.
- [signal_effect.md](widgets/signal_effect.md): Layout-safe side effect orchestration.
- [signal_custom_paint.md](widgets/signal_custom_paint.md): GPU-direct 120fps painting.

### 6. [extensions/](extensions/CONTEXT.md)
Documents context-level reactivity:
- [watch.md](extensions/watch.md): Element-level context subscriptions with automatic VM Expando teardowns.

## Core Content Overview

- **Quick Start Guide (`SKILL.md`)**: Basic signal patterns and operations, detailing widget rebuild optimizations, high-frequency rendering (`SignalCustomPaint` and `SignalPainterWidget`), and layout-safe async side-effects in the widget lifecycle using `SignalEffect` / `SignalListener`.

## Usage/Exports

This directory is utilized in developer training and AI prompt injection to ensure all generated Flutter UI code uses `signals_flutter` in the most optimal and memory-safe manner.
