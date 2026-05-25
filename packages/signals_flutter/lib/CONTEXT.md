# Signals Flutter API

This directory defines the public interface and primary entry points for the `signals_flutter` package.

## Main Entry Points

### [signals_flutter.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/signals_flutter.dart)
The primary entry library for Flutter applications. It re-exports core signals and exports Flutter-specific signal extensions:
- **Core Flutter Signals**: `signal`, `computed`, and `readonly` overrides that implement `ValueNotifier` and `ValueListenable`.
- **Rebuild Mechanism**: The `Watch` widget, `WatchBuilder`, and custom `watch` extension methods for `BuildContext` and `Element`.
- **Lifecycle Management**: `SignalsMixin` for integrating reactive tracking into standard `StatefulWidget` states.
- **Dependency Injection**: `SignalProvider` and `MultiSignalProvider` for propagating signals down the widget tree using Flutter's `InheritedWidget`.
- **Animations**: `TickerSignal` and its helper factories for driving animations cleanly outside widgets.

### [extended.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/extended.dart)
This library provides access to global, reactive system signals. It synchronizes Flutter environment attributes into the reactive graph:
- `themeDataSignal` (reacts to the current `ThemeData`)
- `mediaQueryDataSignal` (reacts to `MediaQueryData`)
- `appLifecycleSignal` (reacts to `AppLifecycleState`)
- `onPersistentFrameSignal` (fires a Duration on every scheduler tick)

These signals are initialized via `initWidgetsBindingSignals()` or dynamically via `updateWidgetsSignals(context)`.

## Supporting Libraries

- **[signals_core.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/signals_core.dart)**: Convenience re-export library for the base `signals_core` package APIs (such as `AsyncState`, `futureSignal`, `streamSignal`, etc.).
- **[signals_core_extended.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/signals_core_extended.dart)**: Re-exports advanced features from `signals_core` (like `computedFrom` and `computedAsync`).

## Directory Overview

The actual implementation logic is nested inside the **[src/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/CONTEXT.md)** directory, which is divided into core modules, mixins, extensions, watchers, and inherited widget providers.
