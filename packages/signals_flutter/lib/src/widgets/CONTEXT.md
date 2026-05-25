# Signals Flutter Widgets

This directory provides highly optimized Flutter widgets and elements that implicitly and explicitly subscribe to reactive signals, enabling precise rebuilds of specific subtrees rather than whole widget layers.

## Purpose

To bridge `signals_core` reactivity into Flutter's widget build phase. It allows widgets to automatically detect when a signal value is accessed and subscribe to rebuilds of only the relevant elements when those signals change, optimizing UI performance and simplifying state binding.

## Detailed File Overviews

### [signal_widget.dart](signal_widget.dart)
Provides implicit signal tracking for stateless widgets.
- **`SignalWidget`**: An abstract subclass of `StatelessWidget` that automatically rebuilds when any signal accessed during its `build()` method updates, without needing manual builder wrapping or `.watch(context)` calls.
- **`SignalElement`**: A custom `StatelessElement` that overrides `build()` to intercept signal access via `core.onSignalRead`. It registers subscriptions to accessed signals, handles changes dynamically between builds, and completely unsubscribes during `unmount()` to prevent memory leaks.

### [signal_stateful_widget.dart](signal_stateful_widget.dart)
Provides implicit signal tracking for stateful widgets.
- **`SignalStatefulWidget`**: An abstract subclass of `StatefulWidget` providing implicit signal tracking identical to `SignalWidget`.
- **`SignalStatefulElement`**: A custom `StatefulElement` that intercepts signal reads inside the state's `build()` method using `core.onSignalRead`, subscribing to changes and cleaning them up automatically on `unmount()`.

### [signal_builder.dart](signal_builder.dart)
Provides localized widget building.
- **`SignalBuilder`**: A lightweight wrapper around `SignalWidget`. It surgically rebuilds only its own builder subtree when accessed signals or explicitly listed `dependencies` change, preventing wider parent widget rebuilds.

### [signal_animated_builder.dart](signal_animated_builder.dart)
Provides optimized rendering performance.
- **`SignalAnimatedBuilder`**: A drop-in replacement for Flutter's native `AnimatedBuilder`. It extends `SignalWidget` and accepts an optional pre-built `child` widget. This avoids rebuilding heavy subtrees while rebuilding outer signal-bound structures.

### [signal_effect.dart](signal_effect.dart)
Provides reactive inline effects.
- **`SignalEffect`** (Typedef **`SignalListener`**): A stateful widget that registers a reactive `core.effect` during its state lifecycle. It executes a callback whenever watched signals change and automatically disposes of the effect subscription when disposed.

### [watch.dart](watch.dart)
- **`Watch`**: A deprecated wrapper around `SignalBuilder`, maintained for backwards compatibility. Users are encouraged to migrate to `SignalBuilder`.

### [watch_builder.dart](watch_builder.dart)
- **`WatchBuilder`**: A deprecated wrapper around `SignalAnimatedBuilder`, maintained for backwards compatibility. Users are encouraged to migrate to `SignalAnimatedBuilder`.

### [widgets.dart](widgets.dart)
- An export umbrella file exposing the library's widgets and builders.

## Dependencies/Relationships

- **`signals_core`**: Integrates with the signal read listener registry (`core.onSignalRead`) and low-level subscription and effect systems.
- **Flutter Widget Pipeline (`package:flutter/widgets.dart`)**: Overrides low-level element and widget build/unmount cycles (`StatelessElement`, `StatefulElement`, `StatelessWidget`, `StatefulWidget`).

## Usage/Exports

Exposes the following builder widgets and tracking abstractions:
- `SignalWidget` / `SignalElement`
- `SignalStatefulWidget` / `SignalStatefulElement`
- `SignalBuilder`
- `SignalAnimatedBuilder`
- `SignalEffect` / `SignalListener`
