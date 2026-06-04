# Signals Flutter Async Skills

This directory provides developer/AI agent guidelines and coding instructions for managing asynchronous operations reactively within the `signals_flutter` environment.

## Purpose

To provide comprehensive documentation and best practices for bridging standard Dart asynchronous paradigms (Futures, Streams) into the reactive state framework for Flutter, ensuring consistent and elegant rendering of loading, success, and error states in UI widgets.

## Detailed File Overviews

### [async_signal.md](async_signal.md)
- **Guidance**: High-level rules for representing async state transitions (`AsyncState`) in Flutter.
- **Core Principles**: Explains how to model and inspect async states (Loading, Value/Data, and Error) reactively inside widgets.

### [future_signal.md](future_signal.md)
- **Guidance**: Instructions for wrapping a Dart `Future` inside a reactive `FutureSignal<T>`.
- **Core Principles**: Emphasizes dynamic status updates and automatic handling of resolution and cancellation events in Flutter lifecycles.

### [stream_signal.md](stream_signal.md)
- **Guidance**: Patterns for wrapping a Dart `Stream` into a reactive `StreamSignal<T>`.
- **Core Principles**: Discusses subscribing to streams, mapping emissions to reactive state, and automatically cleaning up subscriptions when widgets dispose.

### [computed_async.md](computed_async.md)
- **Guidance**: Guidelines for setting up derived asynchronous tasks via `computedAsync()`.
- **Core Principles**: Explains lazy loading and caching of async computations that depend on other reactive signals.

### [computed_from.md](computed_from.md)
- **Guidance**: Rules for reacting to asynchronous events derived from specific trigger signals using `computedFrom()`.
- **Core Principles**: Guides the developer on how to refresh async content whenever a target trigger (like a search query signal) updates.

## Dependencies/Relationships

- **`skills/signals-flutter`**: Extends the general Flutter reactivity parent guide.
- **`signals_flutter` package**: Maps directly to async primitives (like `FutureSignal`, `StreamSignal`, and async state models).

## Usage/Exports

Exposes instructions for:
- Asynchronous reactive state representation
- Future/Stream integration in Flutter
- Asynchronous derived computed signals (`computedAsync`, `computedFrom`)
