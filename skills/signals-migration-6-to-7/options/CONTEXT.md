# Signals Migration 6 to 7 Options

This directory provides developer/AI agent guidelines and prompt engineering instructions for migrating options and parameters from version 6.x to version 7.x of `signals.dart`.

## Purpose

To equip AI assistants with rules, syntactic patterns, and code diffs for refactoring scattered signal parameters (such as `autoDispose`, `debugLabel`, `lazy`, etc.) into v7's unified options classes for general, asynchronous, and collection-based signals.

## Detailed File Overviews

### [signal_options.md](signal_options.md)
- **Guidance**: Migration patterns for standard `signal` and `computed` creators.
- **Core Principles**: Standardizes replacing positional or individual named parameters (like `autoDispose: true` or `debugLabel: 'counter'`) with `options: SignalOptions(...)` and `options: ComputedOptions(...)`.

### [async_options.md](async_options.md)
- **Guidance**: Migration patterns for asynchronous signals (`futureSignal`, `streamSignal`).
- **Core Principles**: Restructures parameters into a single named `options` argument passing `AsyncSignalOptions`.

### [collection_options.md](collection_options.md)
- **Guidance**: Migration patterns for collection-based signals (`listSignal`, `setSignal`, `mapSignal`, etc.).
- **Core Principles**: Replaces individual parameters with cohesive collection options (e.g., `ListSignalOptions`, `SetSignalOptions`).

## Dependencies/Relationships

- **`skills/signals-migration-6-to-7`**: Extends the general migration parent guide.
- **`signals_core` package**: Outlines the breaking changes in the options API between major versions 6.x and 7.x.

## Usage/Exports

Exposes migration rules and examples for:
- General signal and computed options refactoring
- Asynchronous signal options refactoring
- Collection signal options refactoring
