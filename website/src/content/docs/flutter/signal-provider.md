---
title: SignalProvider
description: Pass signals around the widget tree
sidebar:
  order: 0
---

SignalProvider is an [InheritedNotifier](https://api.flutter.dev/flutter/widgets/InheritedNotifier-class.html) widget that allows you to pass signals around the widget tree.

```dart
import 'package:signals/signals_flutter.dart';
import 'package:flutter/material.dart';

class Counter extends FlutterSignal<int> {
  Counter([super.value = 0]);

  void increment() => value++;
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalProvider<Counter>(
      create: () => Counter(0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Builder(builder: (context) {
                final counter = SignalProvider.of<Counter>(context);
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          final counter = SignalProvider.of<Counter>(context, listen: false)!;
          return FloatingActionButton(
            onPressed: counter.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
```

:::note
The signal in the `create` method needs to extend `FlutterReadonlySignal` which can be from a signal or computed created with the flutter import or by extending `FlutterReadonlySignal`, `FlutterSignal` or `FlutterComputed`.
:::
