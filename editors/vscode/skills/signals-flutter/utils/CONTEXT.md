# Signals Flutter Utility Skills

This directory provides developer/AI agent guidelines and coding instructions for high-level utility primitives and extensions in the `signals_flutter` environment.

## Purpose

To equip AI assistants with rules and syntactic examples for advanced state-management patterns in Flutter, including syncing signals, time-based updates, change tracking, and connecting external data sources.

## Detailed File Overviews

### [connect.md](connect.md)
- **Guidance**: Best practices for piping and connecting values between signals using the `.connect()` extension.
- **Core Principles**: Standardizes linking a source signal or stream to a target destination signal for automatic propagation in Flutter.

### [linked_signal.md](linked_signal.md)
- **Guidance**: Guidelines for using `linkedSignal()` to synchronize dependent states.
- **Core Principles**: Allows child signals to dynamically reset or update their values when a parent source signal updates, preventing out-of-sync states in complex Flutter forms or navigation.

### [timer_signal.md](timer_signal.md)
- **Guidance**: Implementation rules for time-driven states via `timerSignal()`.
- **Core Principles**: Exposes periodic emissions (e.g. clock ticks or polling intervals) into a reactive signal.

### [tracked_signal.md](tracked_signal.md)
- **Guidance**: Guidelines for historic change tracking using `trackedSignal()`.
- **Core Principles**: Enables undo/redo operations or previous value comparisons by storing history of signal value transitions in Flutter state.

## Dependencies/Relationships

- **`skills/signals-flutter`**: Extends the general Flutter reactivity parent guide.
- **`signals_flutter` package**: Maps directly to utility extensions and specialized signal subclasses.

## Usage/Exports

Exposes instructions for:
- Connecting signal endpoints (`connect`)
- Synchronized/dependent child states (`linkedSignal`)
- Periodic time-driven signals (`timerSignal`)
- Historical state tracking (`trackedSignal`)
