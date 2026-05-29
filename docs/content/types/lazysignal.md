---
title: "Type: lazySignal"
description: "API reference and details for lazySignal from signals.dart."
---

# lazySignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Function: lazySignal

```dart
FlutterSignal<T> lazySignal({core.SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```

Creates a lazy, mutable [FlutterSignal](/types/fluttersignal) of type **T** whose value can be assigned later.

<Warning>
  Reading a lazy signal's value before it has been initialized will throw a runtime error.
</Warning>

### Example

```dart
final database = lazySignal<DatabaseConnection>();

// Initialize later (e.g. in initState or async initialization):
database.value = await connectToDatabase();

// Now it is safe to read:
print('Connected to: ${database.value.host}');
```

## Function: lazySignal

```dart
Signal<T> lazySignal({SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})
```

Lazy signal that can be created with type T that
the value will be assigned later.

```dart
final db = lazySignal<DatabaseConnection>();
...
db.value = DatabaseConnect(...);
```

## References

The **lazySignal** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Lazy Signal](/packages/signals/extensions/lazy-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>

