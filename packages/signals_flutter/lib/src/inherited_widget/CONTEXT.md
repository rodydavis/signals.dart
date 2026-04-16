# Signals Flutter Inherited Widgets

This directory provides dependency injection (DI) mechanisms for signals using Flutter's inherent `InheritedWidget` system.

## Components

### [signal.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/inherited_widget/signal.dart)
Defines **`SignalProvider`**, an `InheritedNotifier` that takes a `FlutterSignal`.
- **Purpose**: It allows a signal to be provided high up in the widget tree and accessed by children widgets via `SignalProvider.of<T>(context)`.
- **Efficiency**: Since it uses `InheritedNotifier`, changes to the signal only trigger rebuilds in the widgets that explicitly call `of(context)`.

## Comparison
While standard signals can be watched directly using `context.watch(signal)`, `SignalProvider` is useful when the signal itself is not globally defined and needs to be scoped to a specific part of the widget tree (e.g., in a multi-page form or a specific feature module).
