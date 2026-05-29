---
title: "Type: readonly"
description: "API reference and details for readonly from signals.dart."
---

# readonly

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Function: readonly

```dart
ReadonlySignal<T> readonly(T value, [ReadonlySignalOptions<T>? options])
```

Creates a new read-only signal initialized with **value**.

This function returns a [ReadonlySignal](/types/readonlysignal) containing **value**. Under the hood, a mutable [Signal](/types/signal)
is created, but it is returned under the [ReadonlySignal](/types/readonlysignal) interface to prevent modification by clients.

This is particularly useful when you need to expose a constant reactive value, or bridge some external,
immutable value source into the signals reactivity system.

Parameters:
- **value**: The initial value held by the read-only signal.
- **options**: Optional configuration options (e.g., custom debug name or lifecycle callbacks like <code>watched</code>/<code>unwatched</code>).

Returns:
- A [ReadonlySignal](/types/readonlysignal) containing the initial value.

### Example Usage

````dart
import 'package:preact_signals/preact_signals.dart';

final configUrl = readonly('https://api.example.com');

void main() {
  effect(() {
    print("Connecting to: ${configUrl.value}");
  });
}
````

<Warning>
If you are trying to derive a value from other signals, do not use [readonly]. Use [computed] instead
to ensure the derived signal automatically re-evaluates when its source signals change.
</Warning>

## Function: readonly

```dart
ReadonlySignal<T> readonly(T value, {ReadonlySignalOptions<T>? options, @Deprecated('Use options: ReadonlySignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ReadonlySignalOptions(name: ...) instead') String? debugLabel})
```

Creates a new read-only signal initialized with **value**.

This function returns a [ReadonlySignal](/types/readonlysignal) containing **value**. Under the hood, a mutable [Signal](/types/signal)
is created, but it is returned under the [ReadonlySignal](/types/readonlysignal) interface to prevent modification by clients.

This is particularly useful when you need to expose a constant reactive value, or bridge some external,
immutable value source into the signals reactivity system.

Parameters:
- **value**: The initial value held by the read-only signal.
- **options**: Optional configuration options (e.g., custom debug name or lifecycle callbacks).

Returns:
- A [ReadonlySignal](/types/readonlysignal) containing the initial value.

### Example Usage

```dart
import 'package:signals_core/signals_core.dart';

final configUrl = readonly('https://api.example.com');

void main() {
  effect(() {
    print("Connecting to: ${configUrl.value}");
  });
}
```

<Warning>
  If you are trying to derive a value from other signals, do not use <a href="/types/readonly">readonly</a>. Use <a href="/types/computed">computed</a> instead
  to ensure the derived signal automatically re-evaluates when its source signals change.
</Warning>

## Function: readonly

```dart
FlutterReadonlySignal<T> readonly(T value, {core.SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```

Create a new plain readonly signal

## References

The **readonly** type is referenced and used in the following pages:

* [ReadonlySignal](/packages/signals_flutter/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Flutter Readonly Signal](/packages/signals_flutter/signals/flutter-readonly-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [signals_flutter](/packages/signals_flutter)
* [ReadonlySignal](/packages/signals_core/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [signals_core](/packages/signals_core)
* [ReadonlySignal](/packages/signals/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Flutter Readonly Signal](/packages/signals/signals/flutter-readonly-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [signals](/packages/signals)
* [ReadonlySignal](/packages/preact_signals/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [preact_signals](/packages/preact_signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

