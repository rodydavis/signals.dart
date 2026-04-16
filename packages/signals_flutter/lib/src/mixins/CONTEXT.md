# Signals Flutter Mixins

This directory provides mixins that simplify the integration of signals into Flutter's lifecycle and bridge existing Flutter types to signals.

## Core Mixin

### [signals.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/mixins/signals.dart)
The **`SignalsMixin`** is designed for use with Flutter's `State` objects.
- **Automatic Lifecycle**: It tracks all signals and effects created or bound within the state and ensures they are automatically disposed of when the widget is disposed.
- **`watchSignal`**: Provides a way to subscribe to a signal such that the widget automatically calls `setState()` when the signal changes.

## Bridging Mixins

### [value_notifier.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/mixins/value_notifier.dart) & [value_listenable.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/mixins/value_listenable.dart)
These mixins provide the underlying implementation for signals that need to behave like Flutter's `ValueNotifier` and `ValueListenable`. They handle the registration of listeners and the dispatching of notifications to the Flutter framework.
