---
title: StreamSignalMixin
description: Mixin for a Signal that adds reactive methods for Stream
sidebar:
  order: 4
  badge:
    text: New
    variant: tip
---

StreamSignalMixin is a mixin for a Signal that adds reactive methods for [Stream](https://api.flutter.dev/flutter/dart-async/Stream-class.html).

```dart
class MySignal extends Signal<int> with StreamSignalMixin<int> {
  MySignal(int value) : super(value);
}

void main() {
  final signal = MySignal(1);
  
  assert(signal is Signal<int>);
  assert(signal is Stream<int>);

  signal.listen((value) {
    print(value);
  });

  signal.value = 2;
}
```

This allows you to use the `Stream` API with a Signal and use it anywhere a `Stream` is expected.

## StreamBuilder

You can use `StreamBuilder` to build a widget that automatically updates when the signal emits a new value.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class Counter extends Signal<int> with StreamSignalMixin<int> {
  Counter(int value) : super(value);
}

void main() {
  final counter = Counter(0);

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('StreamSignalMixin Example'),
        ),
        body: Center(
          child: StreamBuilder<int>(
            stream: counter,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You have pushed the button this many times:'),
                  Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    ),
  );
}
```
