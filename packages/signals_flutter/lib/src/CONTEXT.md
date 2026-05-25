# Signals Flutter Internal Implementation

This directory contains the internal source code for the `signals_flutter` package, bridging the core reactivity engine with the Flutter framework.

## Core Architecture

The package extends `signals_core` to make reactive primitives "Flutter-native" by implementing standard Flutter interfaces like `ValueListenable` and `ValueNotifier`. It leverages Flutter's rendering lifecycle and scheduler binding to drive reactive state changes and widgets.

## Key Modules

### [core/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/core/CONTEXT.md)
Contains `FlutterSignal` and `FlutterComputed`, which are drop-in replacements for their core counterparts. They integrate seamlessly with Flutter's built-in listening mechanisms by implementing `ValueListenable`.

### [watch/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/watch/CONTEXT.md)
The engine for "surgical" and optimized rebuilds.
- `Watch` and `WatchBuilder` widgets automatically track signals accessed within their builder closure, rebuilding only when those specific signals update.
- `ElementWatcher` manages signal subscriptions tied to the lifecycle of any Flutter `Element` or widget tree context.

### [mixins/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/mixins/CONTEXT.md)
- `SignalsMixin`: Integrates signals directly into Flutter `State` lifecycles, enabling automatic tracking, safe scheduling of `setState` via `SchedulerBinding`, and automatic disposal of locally created signals/effects.
- `ValueListenableSignalMixin` and `ValueNotifierSignalMixin`: Internal bridges providing standard `ValueListenable` and `ValueNotifier` interfaces for core read-only and read-write signals.

### [extensions/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/extensions/CONTEXT.md)
Adds reactive extension methods to core Flutter and Dart types, such as `mysignal.watch(context)` to register a build-context listener, or `listenable.toSignal()` to turn a standard `ValueListenable` into a Signal.

### [inherited_widget/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/inherited_widget/CONTEXT.md)
Contains `SignalProvider`, which allows passing signals down the widget tree using Flutter's `InheritedWidget` mechanism, combined with `InheritedNotifier` for efficient local updates.

### [extended/](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/extended/CONTEXT.md)
Global reactive wrappers for Flutter system state:
- `themeDataSignal` (Theme)
- `mediaQueryDataSignal` (MediaQuery)
- `appLifecycleSignal` (AppLifecycleState)
- `onPersistentFrameSignal` (Scheduler)

### [ticker.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/ticker.dart)
Provides `TickerSignal`, which implements `TickerProvider`. This enables using standard Flutter `AnimationController`s completely outside of `StatefulWidget`s (e.g. in view models or global controllers) by driving their updates via the global scheduler framework.

## Integration Pattern
The package is designed to make signals feel like a native, idiomatic part of Flutter. By implementing Flutter's native listening contracts, it bridges existing widget architectures with the modern, declarative, and high-performance reactive paradigms of signals.
