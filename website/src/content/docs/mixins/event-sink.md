---
title: EventSinkSignalMixin
description: Mixin for a Signal that implements EventSink
sidebar:
  order: 5
  badge:
    text: New
    variant: tip
---

EventSinkSignalMixin is a mixin for a Signal that implements [EventSink](https://api.flutter.dev/flutter/dart-async/EventSink-class.html).

:::note
This mixin only works with signals that have a value type of `AsyncState<T>`.
:::

```dart
class MySignal extends Signal<AsyncState<int>> with EventSinkSignalMixin<AsyncState<int>> {
  MySignal(int value) : super(AsyncState.data(value));
}

void main() {
  final signal = MySignal(0);
  signal.add(1);
  print(signal.value.hasValue); // true
  print(signal.value.value); // 1
  signal.addError('error');
  print(signal.value.hasError); // true
  print(signal.value.error); // error
  signal.close();
  print(signal.disposed); // true
}
```

This allows you to use the signal as a EventSink anywhere you would use a EventSink in Dart.

## .add()

When `add` is called it will set the value of the signal.

## .addError()

When `addError` is called it will set the error of the signal.

## .close()

When `close` is called it will dispose the signal and remove all listeners.
