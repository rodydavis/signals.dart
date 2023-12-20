## 2.1.10

- Updating `signals_flutter` package to **1.0.8**
- Updating `signals_core` package to **1.0.6**

## 2.1.9

- Updating `signals_core` package to **1.0.5**

## 2.1.8

- Updating `signals_core` package to **1.0.4**

## 2.1.7

- Updating `signals_flutter` package to **1.0.7**

## 2.1.6

- Updating `signals_flutter` package to **1.0.6**

## 2.1.5

- Updating `signals_flutter` package to **1.0.5**
- Updating `signals_core` package to **1.0.3**

## 2.1.4

- Updating `signals_flutter` package to **1.0.4**
- Updating `signals_core` package to **1.0.2**

## 2.1.3

- Updating `signals_flutter` package to **1.0.3**

## 2.1.2

- Updating `signals_flutter` package to **1.0.2**

## 2.1.1

- Updating `signals_flutter` package to **1.0.1**

## 2.1.0

- Moving core api from `signals` package to `signals_core` package
- Moving Flutter extensions from `signals` package to `signals_flutter` package
- Reexporting `signals` package to `signals_core` and `signals_flutter` packages
- Depending on `signals_core` package **1.0.1**
- Depending on `signals_flutter` package **1.0.0**

## 2.0.4

- Fixing `AsyncState` on void signals
- Fixing `FutureSignal` with void Future

## 2.0.3

- Rename `AsyncSignalState` to `AsyncState`
- Rename `AsyncSignalStateLoading` to `AsyncLoading`
- Rename `AsyncSignalStateError` to `AsyncError`
- Rename `AsyncSignalStateLoaded` to `AsyncLoaded`
- Deprecate `AsyncSignalState` (and subclasses) in favor of `AsyncState`

## 2.0.2

- Exporting `AsyncSignalState` for `AsyncSignal` state
- Fixing `FutureSignal` reloading state not triggering

## 2.0.1

- Fixing issue with `StreamSignal` on `resetStream`

## 2.0.0

- Refactor `AsyncSignal`
- Adding back `FutureSignal` and `StreamSignal` as `AsyncSignal` subclasses
- Adding `AsyncSignalState`sealed class for `AsyncSignal` state
- Adding `reload` to `AsyncSignal`
- Adding `refresh` to `AsyncSignal`

## 1.5.11

- Adding `disableSignalsDevTools` to disable the dev tools extension in debug/profile mode
- Adding `getSignalListenSubscriberCount` for testing
- Adding `getSignalWatchSubscriberCount` for testing
- Fixing watch/listen extension to dedupe signals by context
- Performance improvements based on benchmark examples by context_watch
- Adding `debugLabel` to effect
- Adding `unwatch`, `unlisten` signals extension to stop watching a signal for watch/listen
- Adding `unwatchSignal`, `unlistenSignal` and `unwatchElement`

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
