# Signals Dart Async Skills

This directory provides developer/AI agent guidelines and coding instructions for managing asynchronous operations reactively within the `signals.dart` ecosystem.

## Purpose

To provide comprehensive documentation and best practices for bridging standard Dart asynchronous paradigms (Futures, Streams) into the reactive state framework, ensuring consistent handling of loading, success, and error states.

## Detailed File Overviews

### [async_signal.md](async_signal.md)
- **Guidance**: High-level rules for representing async state transitions (`AsyncState`).
- **Core Principles**: Explains how to model and inspect async states (Loading, Value/Data, and Error) reactively.

### [future_signal.md](future_signal.md)
- **Guidance**: Instructions for wrapping a Dart `Future` inside a reactive `FutureSignal<T>`.
- **Core Principles**: Emphasizes dynamic status updates and automatic handling of resolution and cancellation events.

### [stream_signal.md](stream_signal.md)
- **Guidance**: Patterns for wrapping a Dart `Stream` into a reactive `StreamSignal<T>`.
- **Core Principles**: Discusses subscribing to streams, mapping emissions to reactive state, and automatically cleaning up subscriptions.

### [computed_async.md](computed_async.md)
- **Guidance**: Guidelines for setting up derived asynchronous tasks via `computedAsync()`.
- **Core Principles**: Explains lazy loading and caching of async computations that depend on other reactive signals.

### [computed_from.md](computed_from.md)
- **Guidance**: Rules for reacting to asynchronous events derived from specific trigger signals using `computedFrom()`.
- **Core Principles**: Guides the developer on how to refresh async content whenever a target trigger (like a search query signal) updates.

## Dependencies/Relationships

- **`skills/signals-dart`**: Extends the general Dart reactivity parent guide.
- **`signals_core` package**: Maps directly to async primitives (like `FutureSignal`, `StreamSignal`, and async state models).

## Usage/Exports

Exposes instructions for:
- Asynchronous reactive state representation
- Future/Stream integration
- Asynchronous derived computed signals (`computedAsync`, `computedFrom`)
