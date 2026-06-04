# Signals Hooks Implementation

This directory contains the implementations of Flutter Hooks for the Signals ecosystem.

## Base Architecture (`base.dart`)
The foundation is the `SignalHook` and `SignalHookState`.
- **Subscription**: When a hook is initialized, it subscribes to the target signal.
- **Rebuild**: Any change in the signal triggers `setState()` on the `HookState`, causing the `HookWidget` to rebuild.
- **Lifecycle**: Automatically unsubscribes index the `dispose()` method.

## Core Hooks (`core.dart` & `flutter.dart`)
Standard reactive primitives integrated with hooks.
- **`useSignal(initialValue)`**: Creates and persists a signal across rebuilds.
- **`useComputed(callback)`**: Creates a memoized computed signal.
- **`useExistingSignal(signal)`**: Subscribes to a signal created outside the widget.
- **`useSignalEffect(callback)`**: Runs a side effect that is automatically disposed.
- **`useValueNotifierToSignal(notifier)`**: Bridges a standard `ValueNotifier` to a signal hook.

## Async Hooks (`async.dart`)
Simplified handling of asynchronous state.
- **`useFutureSignal`**: Wraps a future in a reactive signal.
- **`useStreamSignal`**: Wraps a stream in a reactive signal.
- **`useAsyncComputed`**: Creates a computed value from an asynchronous computation.

## Collection Hooks (`value.dart`)
Specialized hooks for reactive collections and complex state:
- `useListSignal`, `useSetSignal`, `useMapSignal`
- `useTrackedSignal` (value with history)
- `useChangeStackSignal` (undo/redo support)
