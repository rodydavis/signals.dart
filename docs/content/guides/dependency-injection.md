---
title: Dependency Injection
description: How is Signals can be used with any DI solution or none at all
sidebar:
  order: 3
---

Signals is a new **core primitive reactivity library** and not a framework which means it can be used with any dependency injection solution or none at all.

This library aims to adapt to any application architecture and you decide how you want to manage your signals.

This guide will show you how to use Signals with popular DI solutions.

## Provider

[Provider](https://pub.dev/packages/provider) is a simple way to provide objects to your widgets.

```dart
import 'package:signals/signals_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    Provider(
      create: (_) => signal(0),
      dispose: (_, instance) => instance.dispose(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = context.read<Signal<int>>();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Signals with Provider'),
        ),
        body: Center(
          child: Watch((context) => Text('Value: $signal')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

> Note: `Consumer` can also be used instead of Watch.

## GetIt

[GetIt](https://pub.dev/packages/get_it) is a simple service locator that can be used in any Dart or Flutter project.

```dart
import 'package:signals/signals_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

void main() {
  GetIt.I.registerSingleton<Signal<int>>(signal(0));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = GetIt.I.get<Signal<int>>();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Signals with GetIt'),
        ),
        body: Center(
          child: Watch((context) => Text('Value: $signal')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

## Riverpod

[Riverpod](https://pub.dev/packages/riverpod) is a data-binding and reactive caching framework for Flutter and Dart.

```dart
import 'package:signals/signals_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';

part 'main.g.dart';

@riverpod
Signal<int> counter() => signal(0);

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.read(counterProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Signals with Riverpod'),
        ),
        body: Center(
          child: Watch((context) => Text('Value: $counter')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

## InheritedWidget

InheritedWidget is a simple built in way to provide objects to your widgets. This comes at the cost of storing a single signal per type.

> Note: This is a new feature added in version 5.0.0 and is still experimental.

```dart
import 'package:signals/signals_flutter.dart';
import 'package:signals/signals_flutter_extended.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: SignalProvider.value(
        value: 0,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = SignalProvider.of<int>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Signals with InheritedWidget'),
        ),
        body: Center(
          child: Watch((context) => Text('Value: $counter')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

If you want to define multiple signals with the same type, then you will need to create custom classes for the container.

```dart
class Counter extends Signal<int> {
  Counter(int value) : super(value);
}
...
home: SignalProvider<Counter>(
  instance: Counter(0),
  child: MyApp(),
),
...
final counter = SignalProvider.of<Counter>(context);
counter.value++;
```

## Lite Ref

[Lite Ref](https://pub.dev/packages/lite_ref) is a simple way to provide disposable objects to your widgets.

```dart
final counterRef = Ref.scoped(
  (_) => signal(0),
  dispose: (instance) => instance.dispose(),
);

void main() {
  runApp(LiteRefScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = counterRef.of(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Signals with Zones'),
        ),
        body: Center(
          child: Watch((context) => Text('Value: $counter')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

You can use any class that implements `Disposable` and it will be disposed when the widget is removed from the widget tree. You also don't need to provide a `dispose` function for the ScopedRef.

```dart
class Counter implements Disposable {
  final value = signal(0);
  final doubled = computed(() => value.value * 2);

  @override
  void dispose() {
    value.dispose();
    doubled.dispose();
  }
}

final counterRef = Ref.scoped((_) => Counter());
```

## Zones

Zones are another built in way to provide objects to your application via Dart [Zones](https://dart.dev/articles/archive/zones).

[Scoped Deps](https://pub.dev/packages/scoped_deps) is a package that easily integrates Zones with Dart.

```dart
import 'package:signals/signals_flutter.dart';
import 'package:scoped_deps/scoped_deps.dart';
import 'package:flutter/material.dart';

final counter = create(() => signal(0));

void main() {
  runScoped(() => MyApp(), values: {counter});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = read(counter);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Signals with Zones'),
        ),
        body: Center(
          child: Watch((context) => Text('Value: $counter')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

## Global Signals

Global signals are a simple way to provide objects to your widgets.

This requires you to manage the lifecycle of the signal and dispose it when no longer needed.

> Note: This is not recommended for large applications and useful for select use cases like logging, analytics, auth, etc.

```dart
import 'package:signals/signals_flutter.dart';
import 'package:flutter/material.dart';

final counter = signal(0);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Signals with Global Signal'),
        ),
        body: Center(
          child: Watch((context) => Text('Value: $counter')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```
