# Signals Flutter API

This directory defines the public interface for the `signals_flutter` package.

## Main Entry Points

### [signals_flutter.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/signals_flutter.dart)
The primary library file for most Flutter applications. It exports:
- **Core Flutter Signals**: `signal`, `computed`, and `readonly` overrides that implement `ValueNotifier`.
- **Rebuild Mechanism**: The `Watch` widget and `WatchBuilder`.
- **Lifecycle Management**: `SignalsMixin` for use in `State` objects.
- **Dependency Injection**: `SignalProvider` for providing signals via the widget tree.
- **Animations**: `TickerSignal` for driving animations globally.

### [extended.dart](file:///Users/rodydavis/Developer/signals_flutter/lib/extended.dart)
This optional library provides access to global reactive state wrappers for the Flutter framework. It depends on `updateWidgetsSignals(context)` or `initWidgetsBindingSignals()` being called to synchronize data from the system.
- `themeDataSignal`
- `mediaQueryDataSignal`
- `appLifecycleSignal`

## Supporting Libraries

- **[signals_core.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/signals_core.dart)**: Re-exports from the base `signals_core` package.
- **[signals_core_extended.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/signals_core_extended.dart)**: Re-exports extended features from `signals_core`.

## Directory Overview

The actual implementation logic is nested in the **[src/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/CONTEXT.md)** directory, organized by feature area (watch, mixins, extensions, etc.).
