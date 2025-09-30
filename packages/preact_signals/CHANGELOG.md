## 1.9.0

- Add SignalEffectException for getting the error and StackTrace for a failed effect callback

## 1.8.3

- Add Computed.isInitialized

## 1.8.2

- Adding lazy signal
- Rename some internal methods

## 1.8.1

- Updating documentation comments
- Making private APIs public with internal annotation
- Lower Dart version

## 1.8.0

- Upstream changes with @preactjs/signals-core to 1.8.0

## 0.4.1

- Fixing issue with computed on null value check

## 0.4.0

- Adding fireImmediately for FutureSignal, StreamSignal
- Removing SignalState and providing methods directly on each class

## 0.3.2

- Fixing generics for FutureSignal, StreamSignal via SignalState

## 0.3.1

- Fixing generics for FutureSignal, StreamSignal, IterableSignal, - ListSignal, MapSignal and SetSignal

## 0.3.0

- Adding value signals: ListSignal, MapSignal, SetSignal, - IterableSignal
- Adding extension methods for value signals
- Adding methods: listSignal, mapSignal, setSignal, - iterableSignal, futureSignal, streamSignal
- Making all devtool methods private

## 0.2.1

- Adding Preact Signals 0.0.1 DevTools extension

## 0.2.0

- Adding FutureSignal and removing signalFromFuture
- Adding StreamSignal and removing signalFromStream

## 0.1.1

- Updating inline code documentation

## 0.1.0

- Rename futureToSignal to signalFromFuture
- Rename streamToSignal to signalFromStream

## 0.0.2

- Fixing recursive call after refactor

## 0.0.1

- Adding computed, effect, signal, untracked
- Adding tests
- Adding web example
- Adding extensions for Future and Stream
