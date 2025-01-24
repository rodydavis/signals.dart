---
title: ValueListenableSignalMixin
description: Mixin for a Readonly Signal that implements ValueListenable
sidebar:
  order: 2
  badge:
    text: New
    variant: tip
---

ValueListenableSignalMixin is a mixin for a Readonly Signal that implements [ValueListenable](https://api.flutter.dev/flutter/foundation/ValueListenable-class.html).

This allows you to use the signal as a ValueListenable in Flutter widgets.

```dart
class MySignal extends Signal<int> with ValueListenableSignalMixin<int> {
  MySignal(super.internalValue);
}

void main() {
  final signal = MySignal(0);
  assert(signal is ReadonlySignal<int>);
  assert(signal is ValueListenable<int>);
  final listener = () => print(signal.value);
  signal.addListener(listener);
  signal.value = 1;
  signal.removeListener(listener);
  signal.value = 2;
}
```

When `addListener` is called it will subscribe to the signal and call the listener when the signal changes.

:::caution
By default the listener callback will subscribe to dependencies called inside the listener because it is an effect.

To prevent this you can use `untracked` to read the signal without subscribing to it.

```dart
final signal = MySignal(0);
final dep = signal(0);
final listener = () {
    untracked(() {
        print(signal.value);
        print(dep.value);
    });
};
signal.addListener(listener);
```
:::

When `removeListener` is called with the same method it will unsubscribe from the signal.

When the signal is disposed it will remove all listeners.

## ValueListenableBuilder

In Flutter you can use the `ValueListenableBuilder` widget to listen to a ValueListenable.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final counter = signal(0);

class MyWidget extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: counter,
      builder: (context, value, child) {
        return Text('Count: $value');
      },
    );
  }
}
```
