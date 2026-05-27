## 7.1.0

- Added native `Widget build(BuildContext context)` override support directly on `SignalHookWidget`.
- Introduced `SignalHookElement` (extending `StatelessHookElement`) to implicitly track reactive signals inside standard `build` methods.
- Deprecated `buildWidget` in favor of direct `build` overrides.
- Streamlined `SignalHookBuilder` to support direct standard `build` scope.

## 7.0.0

- Modernized all hook APIs to accept a positional `options` parameter instead of named options.
- Added new `useLinkedSignal` and `useLazySignal` hooks.
- Added support for passing positional `SignalOptions` and `AsyncSignalOptions` across all hooks.
- Re-exported core reactive primitives from `signals_core` including `action`, `action0`-`action10`, and `createModel`.
- Bump `signals` dependency to `^7.0.0`.

## 6.3.1

 - **FIX**: call super.dispose in SignalHookState.

## 0.4.0

- Bump signals to 6.3.0
- Change return type for useSignal to FlutterSignal
- Change return type for useComputed to FlutterComputed

## 0.3.1

- Bump signals_flutter to 6.2.0

## 0.3.0

- feat: add debugLabel to signals in hooks @dickermoshe
- Bump signals_flutter to 6.1.0

## 0.2.1

- fix: Check if widget is mounted before rebuilding

## 0.2.0

- feat: Add `useSignalValue` to get the value of a signal directly
- feat: Add `useFutureSignal`, `useStreamSignal`, `useAsyncSignal`, and `useAsyncComputed` for async signals
- feat: Add `useValueNotifierToSignal` and `useValueListenableToSignal` to convert `ValueNotifier` and `ValueListenable` to signals
- feat: Add `useListSignal`, `useSetSignal`, `useIterableSignal`, `useMapSignal`, `useTrackedSignal`, `useQueueSignal`, and `useChangeStackSignal` for collection signals
- chore: Re-export `signals_flutter`
- chore: Split hooks into multiple files for better organization

## 0.1.1

- bump flutter_hooks to 0.20.0

## 0.1.0

- Add useSignal
- Add useComputed
- Add useSignalEffect
- Add useExistingSignal
