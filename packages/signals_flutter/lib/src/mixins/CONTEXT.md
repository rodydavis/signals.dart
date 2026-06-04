# Signals Flutter Mixins

This directory provides mixins that simplify the integration of signals into Flutter's lifecycle and bridge existing Flutter types to signals.

## Purpose

These mixins allow Flutter widgets to reactively bind to signals, automatically handle updates via the widget lifecycle, and bridge core Flutter abstractions (like `ValueNotifier` and `ValueListenable`) with Signals.

## Core Mixin

### [signals.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/mixins/signals.dart)

The **`SignalsMixin`** is a powerful mixin designed for use with Flutter's `State` objects. It bridges Dart's reactive signal-based system with Flutter's standard widget-rendering cycle.
- **Automatic Lifecycle Management**: It tracks all signals and effects created or bound locally within the State. It automatically disposes of all local signals and cleans up registered effects when the widget `State` is disposed to prevent memory leaks.
- **Safe Dynamic Rebuilds**: It schedules widget rebuilds (`setState`) asynchronously at the end of the frame using the `SchedulerBinding` and `WidgetsBinding` post-frame callbacks if the scheduler is active. This avoids scheduling rebuilds during frames, which could trigger Flutter errors.
- **Collection/Signal Creation Helpers**: Provides a full suite of factory methods like `createSignal`, `createComputed`, `createListSignal`, `createSetSignal`, `createMapSignal`, `createQueueSignal`, `createFutureSignal`, `createStreamSignal`, `createComputedAsync`, and `createComputedFrom`. All of these automatically bind their lifetimes to the widget.
- **Interaction Helpers**:
  - `bindSignal(s)`: Starts watching a signal for changes to rebuild the widget.
  - `unbindSignal(s)`: Stops watching a signal.
  - `watchSignal(s)`: Binds a signal and returns its current `.value`.
  - `listenSignal(s, callback)`: Creates an effect to listen to a signal, automatically cleaning up if called repeatedly or when the widget is disposed.
  - `createEffect(cb)`: Registers a custom effect tied to the widget state's lifecycle.

## Bridging Mixins

### [value_listenable.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/mixins/value_listenable.dart)

The **`ValueListenableSignalMixin<T>`** is a mixin class that implements Flutter's `ValueListenable<T>` on top of a `ReadonlySignal<T>`.
- Allows standard Flutter widgets (like `ValueListenableBuilder`) to consume any read-only signal.
- Subscribes to the signal on demand when listeners are added, and cleans up the subscription when the last listener is removed.

### [value_notifier.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/lib/src/mixins/value_notifier.dart)

The **`ValueNotifierSignalMixin<T>`** extends the bridge to full writable signals, implementing Flutter's `ValueNotifier<T>` on top of `Signal<T>`.
- Allows reading and writing values via the `ValueNotifier` interface while propagating changes back to the signal network.
- Implements `notifyListeners()` by invoking `set(value, force: true)`.
