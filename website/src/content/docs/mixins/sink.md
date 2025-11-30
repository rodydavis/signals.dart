---
title: SinkSignalMixin
description: Mixin for a Signal that implements Sink
sidebar:
  order: 5
---

SinkSignalMixin is a mixin for a Signal that implements [Sink](https://api.flutter.dev/flutter/dart-core/Sink-class.html).

```dart
class MySignal extends Signal<int> with SinkSignalMixin<int> {
  MySignal(super.internalValue);
}

void main() {
  final signal = MySignal(0);
  signal.add(1);
  print(signal.value); // 1
  signal.close();
  print(signal.disposed); // true
}
```

This allows you to use the signal as a Sink anywhere you would use a Sink in Dart.

## .add()

When `add` is called it will set the value of the signal.

## .close()

When `close` is called it will dispose the signal and remove all listeners.
