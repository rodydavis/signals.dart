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
