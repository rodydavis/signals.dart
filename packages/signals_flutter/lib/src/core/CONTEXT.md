# Signals Flutter Core

This directory contains the Flutter-specific implementations of reactive primitives that integrate with the Flutter framework's listening systems.

## Key Classes

### [signal.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/core/signal.dart)
Defines **`FlutterSignal`**, which implements both `Signal` (from core) and `ValueNotifier`. This allows any standard Flutter widget (like `ValueListenableBuilder`) to subscribe to a signal directly.

### [computed.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/core/computed.dart)
Defines **`FlutterComputed`**, which implements `ValueListenable`. It provides a read-only, reactive view of derived state that works with Flutter listeners.

### [readonly.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/core/readonly.dart)
Provides the base interfaces for read-only signals in a Flutter context.

## Integration Strategy

By implementing `ValueListenable` and `ValueNotifier`, these classes act as a bridge. The core reactivity engine handles the dependency tracking and efficient updates, while the Flutter interfaces allow the signals to be dropped into existing Flutter UI patterns without modification.
