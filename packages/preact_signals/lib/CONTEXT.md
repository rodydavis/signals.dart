# Preact Signals API

This directory defines the public interface for the `preact_signals` package.

## Core API

The [preact_signals.dart](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/lib/preact_signals.dart) library exposes the four core functions and their base classes which are the building blocks of the reactivity system:

- **signal**: Create a writable state container.
- **computed**: Create derived, memoized state.
- **effect**: Execute side effects when dependencies change.
- **batch**: Group multiple updates into a single transaction.
- **untracked**: Read signals without creating a subscription.
- **readonly**: Create a read-only view of a signal.

## Architecture

This package is a low-level port of the original Preact Signals logic. It avoids higher-level abstractions and focus on a fast, memory-efficient dependency graph.

Most applications should not depend on this package directly, but rather on **[signals_core](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/CONTEXT.md)**, which provides additional Dart-friendly extensions and utilities on top of these primitives.

## Internal Implementation

The raw logic, including the graph node management and evaluation contexts, is contained in the **[src/](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/lib/src/CONTEXT.md)** directory.
