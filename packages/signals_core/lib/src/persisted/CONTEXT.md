# Persistent Signals

This directory contains signals that automatically synchronize their state with a persistent key-value store.

## Purpose

`PersistedSignal` allows application state (like user preferences or session data) to survive application restarts without manual boilerplate for loading and saving.

## Core Components

### [store.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/persisted/store.dart)
Defines the `SignalsKeyValueStore` interface, which is a simple bridge to any storage backend (like `shared_preferences`, `hive`, or a local file). It provides an in-memory implementation for testing and fallback.

### [signal.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/persisted/signal.dart)
Contains the `PersistedSignalMixin`, which:
- Calls `init()` upon creation to load the value asynchronously.
- Intercepts the `value` setter to trigger a background `save()` whenever the signal changes.
- Provides `encode` and `decode` hooks (defaulting to JSON) for serialization.

## Typed Implementations

The library provides predefined signals for common types, handling serialization automatically:
- **Primitives**: `bool.dart`, `int.dart`, `double.dart`, `num.dart`, `string.dart`.
- **Enums**: `enum.dart` (uses the enum `.name` for persistence).
- **Core barrel**: `core.dart` exports all available persistent types.

## Lifecycle

1. **Creation**: The signal starts with an initial "fallback" value. `init()` is called immediately.
2. **Loading**: `getItem(key)` is called on the store. If a value exists, it is decoded and the signal's internal value is updated.
3. **Updating**: Any change to `.value` triggers `setItem(key, encodedValue)`.
4. **Access**: Accessing `.value` before the initial load completes will trigger a lazy `init()`.

## Relationships

- **Core Module**: Extends the base `Signal` class from `lib/src/core`.
- **JSON**: Uses `dart:convert` for default serialization in the mixin.
