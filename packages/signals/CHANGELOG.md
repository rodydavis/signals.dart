## 6.1.0

- Bump signals_core to 6.1.0
- Fix error in effect not showing StackTrace
- Add extensions for List, Map, Set, Iterable, bool, String, int, double, num, Comparable, Pattern, Enum
- Add persisted signals for bool, double, Enum, int, num, String and Json (including nullable for each)
- Add SignalsKeyValueStore and SignalsInMemoryKeyValueStore for storage
- Add $ extension method for common types to create signal and function for computed

```dart
Signal<int> count = 0.$;
Computed<double> doubleValue => (() => count() * 2).$;
Signal<String> name = 'Flutter'.$;
Signal<bool> isTrue = true.$;
Signal<Brightness> brightness = Brightness.light.$;
Signal<double> progress = 0.5.$;
````

- Add SignalEffectException for getting the error and StackTrace for a failed effect callback

## 6.0.2

- Fix cycle error with TrackedSignalMixin and Computed
- Add `AsyncErrorReloading`, `AsyncErrorRefreshing`, `AsyncDataReloading`, `AsyncDataRefreshing`

## 6.0.1

- Fix issue with StreamSignal `_stream not initialized`

## 6.0.0

- Remove SignalStream controller
- Upgrade SignalsProvider to default import
- Add FlutterSignal to extends ValueNotifier
- Add FlutterComputed/FlutterReadonlySignal to extends ValueListenable
- Removing deprecated methods
- Add more methods to SignalsMixin
- Switching to **preact_signals** package for core implementation
- Removing old deprecated methods
- Add new mixins: EventSinkSignalMixin, SinkSignalMixin, StreamSignalMixin, SetSignalMixin, ListSignalMixin, MapSignalMixin, QueueSignalMixin, ChangeStackSignalMixin, IterableSignalMixin
- Update AsyncSignal to implement EventSink
- Removing previous/initial value from Signal and Computed in favor of TrackedSignal, TrackedSignalMixin and trackedSignal()
- Update SignalsObserver to include value for signal created (instead of peek())
- Updated examples
- Remove callback to signal
- Remove toSignal extension method (causing unintended casts) in favor of .$ for Object/Object?
- Add WatchBuilder to include a child callback for caching a widget between rebuilds
- Removing ComputedProvider/ReadonlySignalProvider

## 5.5.0

- Fix for hot reload
- Removing deprecation warning for watch/unwatch

## 5.4.0

- Add SignalsMixin to replace .watch, createComputed/createSignal, SignalsAutoDisposeMixin and implementation for Watch
- Signals now render with fewer rebuilds
- Adding new deprecated warnings
- **Fix**: https://github.com/rodydavis/signals.dart/issues/292
- Update to `signals_core` 5.4.0
- Update to `signals_flutter` 5.4.0

## 5.3.0

- Add Signal.lazy and lazySignal
- Add signal.isLazy and computed.isLazy
- Add await future to refresh/reload for FutureSignal
- Update to `signals_core` 5.3.0
- **FIX**: https://github.com/rodydavis/signals.dart/issues/279
- Fixing signal/computed not disposing in SignalsAutoDisposeMixin
- createSignal/createComputed now are autoDispose=true by default
- Update to `signals_flutter` 5.3.0

## 5.2.3

- **FIX**: https://github.com/rodydavis/signals.dart/issues/283
- Changing toJson from T to dynamic
- Update to `signals_core` 5.2.3
- Update to `signals_flutter` 5.2.3

## 5.2.2

- **FIX**: https://github.com/rodydavis/signals.dart/issues/265
- Update to `signals_core` 5.2.2
- **FIX**: https://github.com/rodydavis/signals.dart/issues/266
- Update to `signals_flutter` 5.2.2

## 5.2.1

 - **FIX**: https://github.com/rodydavis/signals.dart/issues/258
 - **FIX**: https://github.com/rodydavis/signals.dart/issues/262
 - Update to `signals_core` 5.2.0
 - Update to `signals_flutter` 5.2.1

## 5.2.0

- Update to `signals_flutter` 5.2.0
- Update to `signals_core` 5.1.0
- Sync core implementation with [`@preactjs/signals`](https://github.com/preactjs/signals/commit/26cd3ab41313ebccbc38ed0b7af605a4e868b93b) package
- Allow mutations in computed
- Share peek implementation for signal/computed
- Inline various methods for performance

## 5.1.0

- Update to `signals_flutter` 5.1.0
- Fix #247 - element watcher causing effect cycle error
- Fix #245 - unmounted widget causing error on context read
- Adding `InheritedSignalProvider` and `ReadonlySignalProvider` for Flutter
- Update to `signals_core` 5.0.1
- Switching `SignalsObserver` to use `log` instead of `print`
- Only setting `SignalsObserver` to use `DevToolsSignalsObserver` in `kDebugMode`
- Changing `SignalProvider` default constructor to use `create`

## 5.0.0

- Adding `previousValue`/`initialValue` to `Signal`
- Removing `SignalEquality`
- Deprecating `ValueSignal` in favor of `Signal`
- Deprecating `.forceUpdate` in favor of `.set(..., force: true)`
- Removing old deprecated methods
- Adding more inline code documentation
- ListSignal/SetSignal now extends IterableSignal
- Fixing ChangeStackSignal getters for history/redos to return an iterable list
- Fixing async signal isCompleted race condition
- Adding `createSignal`/`createComputed`/`createEffect` for Flutter
- Adding `SignalsAutoDisposeMixin` for Flutter
- Update to `signals_core` 5.0.0
- Update to `signals_flutter` 5.0.0

## 4.5.1

- Fixing Watch in hot reload with auto dispose signals
- Update to `signals_flutter` 4.5.1

## 4.5.0

- Updating documentation comments
- Fixing signals observer bug on effect
- Removing previousValue from value signal
- Add ability to remove an onDispose callback
- Update to `signals_core` 4.5.0
- Update to `signals_flutter` 4.5.0

## 4.4.0

- adding overrideWith
- fix autoDispose not passed in for some signals
- fix equality not being passed in for some signals
- fix for completed not being reset on async signal
- Update to `signals_core` 4.4.0
- Update to `signals_flutter` 4.4.0

## 4.3.0

- Add valueNotifierToSignal, valueListenableToSignal
- Update to `signals_flutter` **4.3.0**

## 4.2.3

- **FIX**: https://github.com/rodydavis/signals.dart/issues/171
- Update to `signals_core` **4.2.1**
- Update to `signals_flutter` to **4.2.3**

## 4.2.2

- Updating `signals_core` package to **4.2.0**
- Update to `signals_flutter` to **4.2.2**

## 4.2.1

- **FIX**: https://github.com/rodydavis/signals.dart/issues/155.

## 4.2.0

 - **FIX**: https://github.com/rodydavis/signals.dart/issues/156.
 - **FIX**: https://github.com/rodydavis/signals.dart/issues/162.
 - Add onDispose callback for effect
 - Fixing computed not updating on signal forced change

## 4.1.0

- Fix bug in auto dispose where signal dispose causes cycle
- Dispose does not reset to initial value and will read the last value with a warning

## 4.0.3

- Removing SignalsReadAfterDisposeError in favor of debug print warning

## 4.0.2

- Adding SignalsWriteAfterDisposeError/SignalsReadAfterDisposeError for better error handling

## 4.0.1

- Fix for listen causing multiple callbacks on non static methods

## 4.0.0

- StreamSignal now will rebuild with signals are read in the callback to create the stream
- Stream/Future signal both can take an optional list of dependencies to rebuild on
- FutureSignal now extends StreamSignal
- StreamSignal can now rebuild/refresh
- StreamSignal can now pause/resume
- Adding computedAsync/computedFrom for similar API to angular
- Adding `.set(..., force: true)` to Signal/Computed to force a rebuild
- Adding `.recompute()` for Computed to recall the callback
- Adding autoDispose for Signal/Computed
- Adding some helper signals not included in the default export
- Signals for WidgetsBinding and SchedulerBinding
- Signals for Theme/MediaQuery
- TickerSignal for Flutter animations

## 3.0.0

- adding readonlySignalContainer to be existing signalContainer API
- updating signalContainer to allow for mutable signals
- adding SignalEquality to allow override of ==
- adding `select` for signals to return a computed value
- fix memory leak on signal container
- adding ChangeStackSignal

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
