# Signals Flutter Extended (System Signals)

This directory contains pre-built reactive signals that wrap global Flutter framework state. These allow developers to react to platform-level changes using the signals API.

## Global Signals

- **[material.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extended/material.dart)**: Provides a global signal for **`ThemeData`**, allowing widgets to respond to theme changes (e.g., dark/light mode toggle) without manual listener management.
- **[widgets.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extended/widgets.dart)**: Contains signals for **`MediaQuery`**, **`Locale`**, and **`TextDirection`**.
- **[widgets_binding.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extended/widgets_binding.dart)**: Provides a signal for **`AppLifecycleState`** (resumed, inactive, paused, detached).
- **[scheduler_binding.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extended/scheduler_binding.dart)**: Exposes a **`frameTimer`** signal that emits the elapsed time of the current frame, useful for high-performance animations or frame-rate monitoring.

## Usage

These signals are lazy and only subscribe to their underlying Flutter bindings when they have active observers. For example, reading `brightnessSignal.value` inside a `Watch` widget will automatically rebuild that widget when the system brightness changes.
