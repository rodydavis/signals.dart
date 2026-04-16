# Signal Extensions and Type Helpers

This directory contains a comprehensive suite of Dart extensions that bridge the gap between standard Dart types and the Signals reactivity system.

## Purpose

The extensions module aims to make working with signals as natural as working with standard Dart objects. It provides two main types of extensions:
1. **Creation/Conversion**: Quickly turning any object or function into a `Signal` or `Computed`.
2. **Proxy/Delegation**: Allowing developers to call methods and operators of the underlying value directly on the signal itself.

## Extension Patterns

### The `$` Shortcut
Most standard Dart types (and `Object` itself) have a `$` extension that converts the value into a signal.
- `10.$` -> `Signal<int>`
- `'hello'.$` -> `Signal<String>`
- `[1, 2, 3].$` -> `Signal<List<int>>`
- `(() => 1 + 2).$` -> `Computed<int>`

### ReadonlySignal Proxying
Extensions on `ReadonlySignal<T>` delegate common methods to the underlying value. This allows you to treat a signal almost like the type it contains:
- `stringSignal.length` instead of `stringSignal.value.length`
- `intSignal + 5` instead of `intSignal.value + 5`
- `listSignal[0]` instead of `listSignal.value[0]`

### Writable Signal Mutations
For collection types (`List`, `Map`, `Set`), extensions provide mutation methods that automatically trigger reactivity by calling `set(value, force: true)`.
- `listSignal.add(item)`
- `mapSignal[key] = value`
- `setSignal.clear()`

## File Overviews

- **[signal.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/extensions/signal.dart)**: Core utilities like `select` (for sub-state tracking), `toStream()`, and `hooks` (React-style getter/setter records).
- **Primitive Extensions**: `bool.dart`, `int.dart`, `double.dart`, `num.dart`, `string.dart`, `enum.dart`: Familiar operators (+, -, *, &, |) and methods (abs, round, trim, split).
- **Collection Extensions**: `iterable.dart`, `list.dart`, `map.dart`, `set.dart`: Iteration (forEach, map, fold) and mutation helpers.
- **Async Extensions**: `future.dart`, `stream.dart`, `async.dart`: Converting futures/streams to signals (`toFutureSignal`, `toSyncSignal`) and selecting data from async states (`selectData`).
- **Function/Object**: `function.dart` (convert closures to `Computed`), `object.dart` (generic `$` for any non-null object).

## Key Relationships

- **Core Module**: All extensions depend on `ReadonlySignal`, `Signal`, and `Computed` from `lib/src/core`.
- **Async Module**: Async extensions bridge into `lib/src/async` structures like `AsyncState` and `FutureSignal`.
