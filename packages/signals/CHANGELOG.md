## 1.5.10

- Updating `signal_devtools` to 0.0.6

## 1.5.9

- Updating `signal_devtools` to 0.0.5 which now works with hot reload (adding effect remove)
- Signal `watch` and `listen` can now call the cleanup method on hot reload if any `Watch` widgets are used

## 1.5.8

- Updating `signal_devtools` to 0.0.4 with graph view updated colors and debug label

## 1.5.7

- Fixing Computed bug in debug mode
- Updating `signal_devtools` to 0.0.3 with graph view showing effects
- Adding `toAsyncSignal` for `Future` and `Stream` to convert to optional value `AsyncSignal`

## 1.5.6

- Adding `debugLabel` to `AsyncSignal`

## 1.5.5

- Adding `reloading` state to AsyncSignal
- Adding `reload` to AsyncSignal

## 1.5.4

- Fixing pubspec Dart filters on pub.dev
- Adding `map` and `maybeMap` to `AsyncSignal`
- Adding `listen` to signal extensions for Flutter
- Adding `listenSignal` for Flutter

## 1.5.3

- Adding `SignalsObserver` and `LoggingSignalsObserver`
- Updating `signal_devtools` to 0.0.2 with graph view and reactive values

## 1.5.2

- Migrating `TimerSignal` to `AsyncSignal`
- Fixing `watch(context)` calls inside `Watch` widget

## 1.5.1

- Adding `isCompleted` and `future` to `AsyncSignal` to async methods to wait for a signal to complete

## 1.5.0

- Adding `AsyncSignal` with helpers `asyncSignalFromFuture` and `asyncSignalFromStream`
- Adding async example
- Adding `previousValue` to signal
- Adding `reloading` state to `FutureSignal` and `StreamSignal`
- Deprecating `FutureSignal` and `StreamSignal` in favor of `AsyncSignal`
- Moving `forceUpdate` to `ValueSignal`

## 1.4.2

- Adding `Timer` to emit `TimerEvent`
- Adding `initial` to `StreamSignal` to skip loading state and avoid emit null value

## 1.4.1

- Adding `sorted` to `ListSignal` that returns new list with sorted values (does not mutate original list)

## 1.4.0

- Deprecating `MutableSignal` in favor of `Signal` (abstract class)
- Adding `ValueSignal` that can be used in a class and extended (similar to ValueNotifier)
- Exposing all classes for value signal and future/stream (for lint issues)
- Rename `to` to `from` in `connect`

## 1.3.4

- Adding inject `<<`, `&` fork and `|` pipe operators on collections

## 1.3.3

- Adding `requireValue` to `FutureSignal` and `StreamSignal` which return the value (non null) or throw an error
- Switching `Exception` to `Error`

## 1.3.2

- Adding `connect` to make it easier to connect a signal to a set of streams

## 1.3.1

- `FutureSignal` now implements `ReadonlySignal` instead of `Signal`
- `StreamSignal` now implements `ReadonlySignal` instead of `Signal`

## 1.3.0

- Removing `SignalWidget` since it will cause unnecessary rebuilds if used at the root and too easy to use incorrectly

## 1.2.2

- Fixing `FutureSignal` and `StreamSignal` in watch
- Adding `Watch` and `SignalWidget`

## 1.2.1

- Fixing `computed` and `signal` to work the same in debug mode as in release mode
- Passing through `debugLabel` to all methods

## 1.2.0

- Fixing public API and removing public classes (Computed, Effect, StreamSignal, etc.)

## 1.1.1

- Migrated to single package `signals` from `preact_signals` and `flutter_preact_signals`

## 1.1.0

- Updating `preact_signals` to 0.4.1
- Updating `flutter_preact_signals` to 0.4.1

## 1.0.1

- Updating `preact_signals` to 0.3.3

## 1.0.0

- Updating `preact_signals` to 0.3.2
- Updating `flutter_preact_signals` to 0.3.2
