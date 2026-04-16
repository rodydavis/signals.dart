# Signals Flutter Internal Implementation

This directory contains the internal source code for the `signals_flutter` package, bridging the core reactivity engine with the Flutter framework.

## Core Architecture

The package extends `signals_core` to make reactive primitives "Flutter-native" by implementing standard Flutter interfaces like `ValueListenable` and `ValueNotifier`.

## Key Modules

### [core/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/core/CONTEXT.md)
Contains `FlutterSignal` and `FlutterComputed`, which are drop-in replacements for their core counterparts that work seamlessly with Flutter's built-in listening mechanisms.

### [watch/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/watch/CONTEXT.md)
The engine for "surgical" rebuilds.
- `Watch` and `WatchBuilder` widgets automatically track signals accessed in their builder.
- `ElementWatcher` manages signal subscriptions tied to the lifecycle of any Flutter `Element`.

### [mixins/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/mixins/CONTEXT.md)
- `SignalsMixin`: Adds signal-awareness to any `State` object, handling automatic disposal and rebuilds.
- `ValueListenableSignalMixin`: Implementation bridge for the `ValueListenable` interface.

### [extensions/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extensions/CONTEXT.md)
Adds convenience methods like `mysignal.watch(context)` and `listenable.toSignal()`.

### [inherited_widget/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/inherited_widget/CONTEXT.md)
`SignalProvider` allows passing signals down the widget tree using Flutter's `InheritedWidget` mechanism, combined with `InheritedNotifier` for efficient updates.

### [extended/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extended/CONTEXT.md)
Global reactive wrappers for Flutter system state:
- `themeDataSignal` (Theme)
- `mediaQueryDataSignal` (MediaQuery)
- `appLifecycleSignal` (AppLifecycleState)
- `onPersistentFrameSignal` (Scheduler)

### [ticker.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/ticker.dart)
`TickerSignal` implements `TickerProvider`, enabling the use of `AnimationController`s outside of `StatefulWidget`s by driving them via the global scheduler.

## Integration Pattern
The package aims to make signals feel like a native part of Flutter. By implementing `ValueListenable`, signals can be used with any existing widget that supports listeners, while the `watch` logic provides a more modern, declarative way to handle reactivity.
