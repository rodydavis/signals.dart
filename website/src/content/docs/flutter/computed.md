---
title: FlutterComputed
description: Pass signals around the widget tree
sidebar:
  order: 1
  badge:
    text: New
    variant: tip
---

Since Signals 6.0.0, you can use the `signals_flutter` import to create signals that extend [ValueListenable](https://api.flutter.dev/flutter/foundation/ValueListenable-class.html).

```dart
import 'package:signals/signals_flutter.dart';

final count = computed(() => 0);

assert(count is Signal<int>);
assert(count is FlutterComputed<int>);
assert(count is FlutterReadonlySignal<int>);
assert(count is ValueListenable<int>);
```

## Custom Signal

To create a custom signal that extends ValueListenable, use the [`ValueListenableSignalMixin`](/mixins/value-listenable) mixin.

```dart
import 'package:signals/signals_flutter.dart';

class MySignal extends Computed<int> with ValueListenableSignalMixin<int> {
  MySignal(int Function() cb) : super(cb);
}
```

Or extend FlutterComputed directly.

```dart
import 'package:signals/signals_flutter.dart';

class MySignal extends FlutterComputed<int> {
  MySignal(int Function() cb) : super(cb);
}
```
