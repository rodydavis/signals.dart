## 6.2.0

- Adding SignalsAutoDisposeMixin
- Computed/Signal now use SignalsAutoDisposeMixin but ReadonlySignalMixin no longer has dispose methods
- Tests now check for SignalEffectException and not error
- Exposing SignalEffectException from preact_signals
- Bump preact_signals to 1.9.3
- Computed not also can throw SignalEffectException instead of generic error
- Bump signals_core to 6.2.0

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
- Upgrade SignalsProvider/ComputedProvider/ReadonlySignalProvider to default imports
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

## 5.5.1

- Fix for Watch.builder not rebuilding with InheritedWidget

## 5.5.0

- Fix for hot reload
- Removing deprecation warning for watch/unwatch

## 5.4.0

- Add SignalsMixin to replace .watch, createComputed/createSignal, SignalsAutoDisposeMixin and implementation for Watch
- Signals now render with fewer rebuilds
- Adding new deprecated warnings
- **Fix**: https://github.com/rodydavis/signals.dart/issues/292
- Update to `signals_core` 5.4.0

## 5.3.0

- Add Signal.lazy and lazySignal
- Add signal.isLazy and computed.isLazy
- Add await future to refresh/reload for FutureSignal
- Update to `signals_core` 5.3.0
- **FIX**: https://github.com/rodydavis/signals.dart/issues/279
- Fixing signal/computed not disposing in SignalsAutoDisposeMixin
- createSignal/createComputed now are autoDispose=true by default

## 5.2.3

- **FIX**: https://github.com/rodydavis/signals.dart/issues/283
- Changing toJson from T to dynamic
- Update to `signals_core` 5.2.3

## 5.2.2

- **FIX**: https://github.com/rodydavis/signals.dart/issues/265
- Update to `signals_core` 5.2.2
- **FIX**: https://github.com/rodydavis/signals.dart/issues/266

## 5.2.1

- **FIX**: https://github.com/rodydavis/signals.dart/issues/258
- **FIX**: https://github.com/rodydavis/signals.dart/issues/262
- Update to `signals_core` 5.2.0

## 5.2.0

- Update to `signals_core` 5.1.0
- Sync core implementation with [`@preactjs/signals`](https://github.com/preactjs/signals/commit/26cd3ab41313ebccbc38ed0b7af605a4e868b93b) package
- Allow mutations in computed
- Share peek implementation for signal/computed
- Inline various methods for performance

## 5.1.0

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

## 4.5.1

- Fixing Watch in hot reload with auto dispose signals

## 4.5.0

- Updating documentation comments
- Fixing signals observer bug on effect
- Removing previousValue from value signal
- Add ability to remove an onDispose callback
- Update to `signals_core` 4.5.0

## 4.4.0

- adding overrideWith
- fix autoDispose not passed in for some signals
- fix equality not being passed in for some signals
- fix for completed not being reset on async signal
- Update to `signals_core` 4.4.0

## 4.3.0

- Add valueNotifierToSignal, valueListenableToSignal

## 4.2.3

- **FIX**: https://github.com/rodydavis/signals.dart/issues/171
- Update to `signals_core` 4.2.1

## 4.2.2

- Update to `signals_core` 4.2.0

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

## 1.0.8

- Updating `signals_core` package **1.0.6**

## 1.0.7

- Fixing `listen` in extension with multiple signals

## 1.0.6

- Fixing `watch` in extension with multiple signals

## 1.0.5

- Updating `signals_core` package **1.0.3**

## 1.0.4

- Updating `signals_core` package **1.0.2**
- Adding `Watch.builder` for non positional argument usage and direct replacement for `Builder`

## 1.0.3

- Fixing memory leak for `watch`/`listen`

## 1.0.2

- Fixing memory leak for `watch`/`listen`

## 1.0.1

- `Watch` widget improvements (reducing extra first frame build)

## 1.0.0

- Moving core api from `signals` package to `signals_core` package
- Depending on `signals_core` package **1.0.1**
- Adding Flutter extensions for `signals_flutter` package
