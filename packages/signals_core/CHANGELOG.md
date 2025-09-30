## 6.2.0

- Adding SignalsAutoDisposeMixin
- Computed/Signal now use SignalsAutoDisposeMixin but ReadonlySignalMixin no longer has dispose methods
- Tests now check for SignalEffectException and not error
- Exposing SignalEffectException from preact_signals
- Bump preact_signals to 1.9.3
- Computed not also can throw SignalEffectException instead of generic error

## 6.1.0

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

- Switching to **preact_signals** package for core implementation
- Removing old deprecated methods
- Add new mixins: EventSinkSignalMixin, SinkSignalMixin, StreamSignalMixin, SetSignalMixin, ListSignalMixin, MapSignalMixin, QueueSignalMixin, ChangeStackSignalMixin, IterableSignalMixin
- Update AsyncSignal to implement EventSink
- Removing previous/initial value from Signal and Computed in favor of TrackedSignal, TrackedSignalMixin and trackedSignal()
- Update SignalsObserver to include value for signal created (instead of peek())
- Updated examples
- Remove callback to signal
- Remove toSignal extension method (causing unintended casts) in favor of .$ for Object/Object?

## 5.5.0

- Fix for hot reload
- Removing deprecation warning for watch/unwatch

## 5.4.0

- Adding SignalsMixin to replace SignalsAutoDisposeMixin, bindSignal, bindComputed, etc.
- Signals now render with fewer rebuilds
- Adding new deprecated warnings
- **Fix**: https://github.com/rodydavis/signals.dart/issues/292

## 5.3.0

- Add Signal.lazy and lazySignal
- Add signal.isLazy and computed.isLazy
- Add await future to refresh/reload for FutureSignal

## 5.2.3

- **FIX**: https://github.com/rodydavis/signals.dart/issues/283
- Changing toJson from T to dynamic

## 5.2.2

- **FIX**: https://github.com/rodydavis/signals.dart/issues/265

## 5.2.0

- **FIX**: https://github.com/rodydavis/signals.dart/issues/258
- **FIX**: https://github.com/rodydavis/signals.dart/issues/262

## 5.1.0

- Sync core implementation with [`@preactjs/signals`](https://github.com/preactjs/signals/commit/26cd3ab41313ebccbc38ed0b7af605a4e868b93b) package
- Allow mutations in computed
- Share peek implementation for signal/computed
- Inline various methods for performance

## 5.0.1

- Switching `SignalsObserver` to use `log` instead of `print`
- Only setting `SignalsObserver` to use `DevToolsSignalsObserver` in `kDebugMode`

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

## 4.5.0

- Updating documentation comments
- Fixing signals observer bug on effect
- Removing previousValue from value signal
- Add ability to remove an onDispose callback

## 4.4.0

- adding overrideWith
- fix autoDispose not passed in for some signals
- fix equality not being passed in for some signals
- fix for completed not being reset on async signal

## 4.2.1

- **FIX**: https://github.com/rodydavis/signals.dart/issues/171

## 4.2.0

- **FIX**: https://github.com/rodydavis/signals.dart/issues/156
- **FIX**: https://github.com/rodydavis/signals.dart/issues/162
- Add onDispose callback for effect
- Fixing computed not updating on signal forced change

## 4.1.0

- Fix bug in auto dispose where signal dispose causes cycle
- Dispose does not reset to initial value and will read the last value with a warning

## 4.0.3

- Removing SignalsReadAfterDisposeError in favor of debug print warning

## 4.0.1

- Adding SignalsWriteAfterDisposeError/SignalsReadAfterDisposeError for better error handling

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

## 3.0.0

- adding readonlySignalContainer to be existing signalContainer API
- updating signalContainer to allow for mutable signals
- adding SignalEquality to allow override of ==
- adding `select` for signals to return a computed value
- fix memory leak on signal container
- adding ChangeStackSignal

## 1.0.6

- Adding `onDone` for passed stream in `StreamSignal`

## 1.0.5

- Adding `SignalContainer` `remove` and adding Signal generic

## 1.0.4

- Adding `SignalContainer`/`signalContainer` to create signals with args

## 1.0.3

- Adding `dispose` for `FutureSignal`, `StreamSignal` and  `AsyncSignal`

## 1.0.2

- Adding `dispose` methods for `signal`, `computed` and `effect`
- Adding `initialValue` getter for `signal` and `computed`

## 1.0.1

- Exposing `reloadSignalsDevTools` for hot reload support

## 1.0.0

- Moving core api from `signals` package to `signals_core` package
