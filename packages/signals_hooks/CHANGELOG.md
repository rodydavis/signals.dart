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
