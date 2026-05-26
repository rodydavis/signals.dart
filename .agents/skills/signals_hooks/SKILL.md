---
name: signals_hooks
description: Comprehensive hook utility functions integrating reactive signals seamlessly with flutter_hooks.
---

# Signals Hooks Skill

This skill provides comprehensive instructions and reference guidelines for utilizing `signals_hooks` package in Flutter applications. It integrates `signals_flutter` reactivity with the dynamic widget-state lifecycles of `flutter_hooks`.

## Modern Positional Options API

In **signals.dart v7**, all hooks have been migrated to use a clean **positional Options pattern** instead of verbose named parameters. The positional parameters are structured as `[keys, options]`. To supply options (like `name`, `autoDispose`, or `equality` inside classes like `SignalOptions`, `AsyncSignalOptions`, or `ListSignalOptions`), they must be passed as the **second** positional optional argument, with the `keys` dependency list passed as the **first** positional optional argument (e.g., `useSignal(value, const [], SignalOptions(name: 'counter'))`).

### Hook Reference Summary Table

| Hook Name | Options Type | Description |
| :--- | :--- | :--- |
| [useSignal](hooks/use-signal.md) | `SignalOptions` | Wraps a standard mutable **Signal** bound to the hook state lifecycle. |
| [useComputed](hooks/use-computed.md) | `ComputedOptions` | Creates a read-only **Computed** signal that caches computed values and tracks changes. |
| [useSignalEffect](hooks/use-signal-effect.md) | - | Registers a side-effect callback that automatically disposes when the hook unmounts. |
| [useExistingSignal](hooks/use-existing-signal.md) | - | Safely binds an existing, external signal to automatically rebuild the widget on change. |
| [useSignalValue](hooks/use-signal-value.md) | - | Directly extracts and watches the value of a signal, returning the unwrapped T value. |
| [useFutureSignal](hooks/use-future-signal.md) | `AsyncSignalOptions` | Triggers an asynchronous callback and returns its result wrapped in a **FutureSignal**. |
| [useStreamSignal](hooks/use-stream-signal.md) | `AsyncSignalOptions` | Subscribes to a Stream and exposes its events via a **StreamSignal**. |
| [useAsyncSignal](hooks/use-async-signal.md) | `AsyncSignalOptions` | Wraps an asynchronous task state inside a manageable **AsyncSignal**. |
| [useAsyncComputed](hooks/use-async-computed.md) | `AsyncSignalOptions` | Creates a reactive computed signal driven by an asynchronous callback. |
| [useValueNotifierToSignal](hooks/use-value-notifier-to-signal.md) | `SignalOptions` | Bridges a standard Flutter `ValueNotifier` to a mutable reactive **Signal**. |
| [useValueListenableToSignal](hooks/use-value-listenable-to-signal.md) | `SignalOptions` | Bridges a standard Flutter `ValueListenable` to a read-only **ReadonlySignal**. |
| [useListSignal](hooks/use-list-signal.md) | `ListSignalOptions` | Creates a reactive **ListSignal** for list collections. |
| [useSetSignal](hooks/use-set-signal.md) | `SetSignalOptions` | Creates a reactive **SetSignal** for set collections. |
| [useIterableSignal](hooks/use-iterable-signal.md) | `IterableSignalOptions` | Creates a reactive **IterableSignal** for iterable collections. |
| [useMapSignal](hooks/use-map-signal.md) | `MapSignalOptions` | Creates a reactive **MapSignal** for key-value collections. |
| [useTrackedSignal](hooks/use-tracked-signal.md) | `TrackedSignalOptions` | Creates a **TrackedSignal** that remembers its previous values. |
| [useQueueSignal](hooks/use-queue-signal.md) | `QueueSignalOptions` | Creates a reactive **QueueSignal** for queue collections. |
| [useChangeStackSignal](hooks/use-change-stack-signal.md) | `ChangeStackSignalOptions` | Creates a **ChangeStackSignal** that manages undo/redo history. |
| [useLinkedSignal](hooks/use-linked-signal.md) | `LinkedSignalOptions` | Creates a writable computed **LinkedSignal** bridging two signals. |
| [useLazySignal](hooks/use-lazy-signal.md) | `SignalOptions` | Creates a **LazySignal** initialized lazily on first access. |

---

## Best Practices

1. **Avoid Named Parameters**: Do NOT pass named configuration parameters (like `name` or `autoDispose`) directly to hooks. Always wrap them in the positional `Options` parameter.
2. **Positional Parameter Order**: The first positional optional parameter is `keys` (list of dependencies), and the second positional optional parameter is `options` (the options configuration object).
3. **Memory Safety**: `signals_hooks` automatically disposes all created signals and effects when the widget is unmounted, preventing memory leaks.
