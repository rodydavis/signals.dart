# Core Reactivity Logic

This directory contains the fundamental building blocks of the `signals` reactivity system. It implements signals, computed values, effects, and batching mechanisms.

## Purpose

The core provides a high-performance, fine-grained reactivity system inspired by Preact Signals. It allows developers to create observable values (signals) and derive state (computeds) or trigger side effects (effects) automatically when those signals change.

## Detailed File Overviews

### [auto_dispose.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/auto_dispose.dart)
Provides `SignalsAutoDisposeMixin`, which adds automatic resource management to signals. Signals using this mixin can be configured to dispose themselves when they no longer have any active listeners, helping prevent memory leaks.

### [batch.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/batch.dart)
Exposes the `batch` function, which allows multiple signal updates to be grouped together. Reactivity updates (effects and computeds) are deferred until the end of the batch callback, preventing intermediate or redundant re-evaluations.

### [computed.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/computed.dart)
Implements the `Computed` class and the `computed` factory function. Computed signals derive their value from other signals and are lazily evaluated and memoized. They automatically track their dependencies and re-evaluate only when needed.

### [container.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/container.dart)
Implements `SignalContainer`, a utility for creating and managing signals based on arguments. This is useful for caching signals that depend on specific keys or identifiers (e.g., parameter-based state).

### [effect.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/effect.dart)
Defines the `Effect` class and `effect` function. Effects are observers that run a callback whenever any accessed signal changes. They are used for side effects like logging, UI updates, or networking.

### [observer.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/observer.dart)
Provides the `SignalsObserver` abstract class and a default logging implementation. This allows for global monitoring of signal creation, updates, and disposal events, which is particularly useful for debugging and DevTools integration.

### [readonly.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/readonly.dart)
Defines the `ReadonlySignal` interface and `ReadonlySignalMixin`. This provides a way to expose signals that can be read but not directly modified from the outside.

### [signal.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/signal.dart)
Contains the primary `Signal` class, representing a writable reactive value. It supports custom equality checks, lazy initialization, and manual disposal.

### [signals.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/signals.dart)
The central orchestrator for this module. It manages the `part` and `part of` relationships and defines shared error types like `SignalsError`, `SignalsReadAfterDisposeError`, and `EffectCycleDetectionError`.

### [untracked.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/core/untracked.dart)
Provides the `untracked` function, which executes a callback without creating any signal subscriptions. This is useful for reading signals inside an effect without causing the effect to re-run when those signals change.

## Dependencies/Relationships

- **Preact Signals**: This module is a Dart wrapper and extension of the `preact_signals` primitive logic.
- **DevTools**: Integrates with `SignalsObserver` to provide visibility into the reactivity graph.
- **Internal Mixins**: Heavily utilizes `SignalsAutoDisposeMixin` and `ReadonlySignalMixin` for consistent behavior across different signal types.

## Usage/Exports

- `signal()`: Create a writable signal.
- `computed()`: Create a derived signal.
- `effect()`: Create a side effect.
- `batch()`: Group multiple updates.
- `untracked()`: Read without subscribing.
- `SignalContainer`: Manage keyed signals.
