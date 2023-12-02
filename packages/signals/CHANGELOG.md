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
