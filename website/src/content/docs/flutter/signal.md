---
title: FlutterSignal
description: Pass signals around the widget tree
sidebar:
  order: 1
---

Since Signals 6.0.0, you can use the `signals_flutter` import to create signals that extend [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html).

```dart
import 'package:signals/signals_flutter.dart';

final count = signal(0);

assert(count is Signal<int>);
assert(count is FlutterSignal<int>);
assert(count is FlutterReadonlySignal<int>);
assert(count is ValueNotifier<int>);
```

## Custom Signal

To create a custom signal that extends ValueNotifier, use the [`ValueNotifierSignalMixin`](/mixins/value-notifier) mixin.

```dart
import 'package:signals/signals_flutter.dart';

class MySignal extends Signal<int> with ValueNotifierSignalMixin<int> {
  MySignal(int value) : super(value);
}
```

Or extend FlutterSignal directly.

```dart
import 'package:signals/signals_flutter.dart';

class MySignal extends FlutterSignal<int> {
  MySignal(int value) : super(value);
}
```

## Flutter Signal Options

You can pass options to `signal` to customize its behavior.

```dart
import 'package:signals/signals_flutter.dart';

final count = signal(
  0,
  options: FlutterSignalOptions(
    name: 'Counter',
    runCallbackOnListen: true,
    autoDispose: true,
    equalityCheck: SignalEquality.custom((a, b) => a == b),
    watched: (val) => print('watched: $val'),
    unwatched: (val) => print('unwatched: $val'),
  ),
);
```

### Properties

- `name`: Debug label for the signal.
- `autoDispose`: Automatically dispose the signal when it has no listeners.
- `equalityCheck`: Custom equality check function.
- `watched`: Callback when the signal is watched.
- `unwatched`: Callback when the signal is unwatched.
- `runCallbackOnListen`: Trigger the listener immediately when it is added.

