---
title: Linked Signal
description: A signal that resets when its source changes.
---

A `linkedSignal` is a signal that is writable but also updates based on an upstream source. It is useful for implementing patterns like "reset on change" where a value should be editable by the user but reset to a default when a dependency changes.

## Usage

```dart
import 'package:signals_core/signals_core.dart';

final source = signal(0);

// Create a linked signal that resets to source * 2 when source changes
final s = linkedSignal(
  () => source.value, 
  (source, previous) => source * 2
);

print(s.value); // 0 (source is 0)

source.value = 1;
print(s.value); // 2 (source changed, so it reset)

s.value = 10; // Manual override
print(s.value); // 10

source.value = 2;
print(s.value); // 4 (source changed again, so it reset, overwriting manual value)
```

## API

### `linkedSignal`

Creates a new `LinkedSignal`.

```dart
LinkedSignal<S, T> linkedSignal<S, T>(
  S Function() source,
  T Function(S source, T? previous) computation, {
  LinkedSignalOptions<S, T>? options,
})
```

- `source`: A function that returns the source value. This is tracked as a dependency. When the value returned by this function changes, the linked signal resets.
- `computation`: A function that computes the new value of the linked signal when the source changes. It receives the new source value and the previous value of the linked signal.
- `options`: Optional configuration for the linked signal.

### `LinkedSignalOptions`

```dart
class LinkedSignalOptions<S, T> extends SignalOptions<T> {
  final T? initialValue;
  
  const LinkedSignalOptions({
    this.initialValue,
    super.name,
    super.equalityCheck,
    super.watched,
    super.unwatched,
  });
}
```

- `initialValue`: The initial value of the backing store.
- `name`: Debug name for the signal.
- `equalityCheck`: Custom equality check for the signal value.
- `watched`: Callback when the signal is first subscribed to.
- `unwatched`: Callback when the signal is no longer subscribed to.

## How it works

A `linkedSignal` maintains two states:
1.  **Source State**: The value derived from the `source` and `computation`.
2.  **Manual State**: The value set via `.value = ...` or `.set(...)`.

It uses a "check-on-read" strategy (lazy evaluation) to determine which value to return:
- When read, it checks if the `source` has changed since the last computation.
- If the source **has changed**, it runs the `computation` to derive a new value, updates its internal state, and returns it. This effectively "resets" the signal, discarding any manual overrides.
- If the source **has not changed**, it returns the current stored value (which might be a manual override or the result of the last computation).

This ensures "Source Precedence": changes to the source always override manual changes.

## Advanced Usage

### Previous Value

The `computation` function receives the previous value of the linked signal. This can be useful for accumulating values or implementing complex reset logic.

```dart
final source = signal(0);
final s = linkedSignal<int, int>(
  () => source.value,
  (src, prev) => src + (prev ?? 0),
);
```

### Equality Check

You can provide a custom equality check to prevent downstream updates if the reset value is semantically equivalent to the previous value.

```dart
final s = linkedSignal(
  () => source.value,
  (src, prev) => src * 2,
  options: LinkedSignalOptions(
    equalityCheck: SignalEquality.custom((a, b) => a == b),
  ),
);
```
