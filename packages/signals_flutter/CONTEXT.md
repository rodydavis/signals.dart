# signals_flutter

The Flutter integration layer for the Signals ecosystem, enabling seamless reactivity within the Flutter widget tree.

## Overview

`signals_flutter` bridges the gap between the high-performance `signals_core` reactivity engine and Flutter's UI rendering. It provides widgets, mixins, and extensions that allow developers to build user interfaces that respond surgically and efficiently to state changes without triggering unnecessary parent or widget tree rebuilds.

## Key Features

- **Bridged Primitives**: `Signal` and `Computed` implement `ValueListenable` and `ValueNotifier`, making them fully compatible with all native Flutter widgets that consume listeners (e.g. `AnimatedBuilder`, `ValueListenableBuilder`).
- **Surgical Rebuilds**: The `Watch` widget, `WatchBuilder`, and `context.watch(signal)` extension ensure only the specific widgets reading the signal update.
- **State Lifecycle**: `SignalsMixin` manages the automatic creation, subscription, and lifecycle-bound disposal of signals within a `State` object to completely eliminate memory leaks.
- **Global Tickers**: Drive animations outside of standard `StatefulWidget`s using `TickerSignal`.
- **System Signals**: Reactive, auto-synchronized access to Flutter `Theme`, `MediaQuery`, and `AppLifecycleState`.

## Directory Structure

### [lib/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/CONTEXT.md)
The public API exports.

- **[src/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/CONTEXT.md)**: Implementation details.
  - **[watch/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/watch/CONTEXT.md)**: Automatic rebuild logic.
  - **[core/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/core/CONTEXT.md)**: Flutter-specific reactive classes.
  - **[mixins/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/mixins/CONTEXT.md)**: State management helpers.
  - **[extensions/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/extensions/CONTEXT.md)**: Flutter-specific API extensions.
  - **[inherited_widget/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/inherited_widget/CONTEXT.md)**: Dependency injection logic.
  - **[extended/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/extended/CONTEXT.md)**: Global system state signals.

### [example/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/example/)
Contains various Flutter examples demonstrating counters, lists, and advanced patterns.

### [test/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/test/)
Unit and widget tests for the Flutter integration layer.

## Dependencies

- **[signals_core](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/CONTEXT.md)**: The underlying reactivity engine.
- `flutter`: The Flutter framework SDK.

## Development

Use `melos bootstrap` to initialize the workspace. Testing can be done with `flutter test`.
