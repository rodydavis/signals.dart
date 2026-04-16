# preact_signals

A micro-library for high-performance reactivity, ported from Preact.js Signals to Dart.

## Overview

`preact_signals` provides the foundational building blocks for reactive programming. It uses a graph-based dependency tracking system that ensures surgical updates and automatic cleanup of unused reactivity nodes. This package is the core engine upon which the rest of the signals ecosystem is built.

## Key Features

- **Fine-grained Reactivity**: Only updates the parts of the code that depend on a changed value.
- **Lazy Evaluation**: Computes values only when they are read, avoiding unnecessary work.
- **Automatic Cleanup**: Unsubscribes from dependencies when they are no longer needed.
- **Minimal API**: Focuses on core primitives like `signal`, `computed`, `effect`, and `batch`.

## Directory Structure

### [lib/](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/lib/CONTEXT.md)
The public API for the engine.
- **[src/](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/lib/src/CONTEXT.md)**: The internal "Pulse" reactivity algorithm.

### [test/](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/test/)
Comprehensive unit tests for the core engine behavior, including edge cases for dependency cycles and nested batches.

## Usage

This package is intended for low-level usage or as a foundation for other libraries. For general application development, it is recommended to use **[signals_core](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/CONTEXT.md)** which provides more ergonomic Dart extensions.
