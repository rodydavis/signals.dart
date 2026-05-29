---
title: useIterableSignal
description: Creates a new IterableSignal and subscribes to it.
---

Creates a new [IterableSignal](/types/iterablesignal) and subscribes to it.

An [IterableSignal](/types/iterablesignal) provides a reactive wrapper around a Dart **Iterable**, notifying subscribers
and rebuilding **HookWidget**s when the iterable structure is mutated or replaced.

### Parameters
- **value**: The initial iterable elements.
- **options**: The options for the signal.
- **keys**: A list of objects to watch. If any key changes, the iterable signal is re-created.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class IterableDisplay extends HookWidget {
  const IterableDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final sequence = useIterableSignal(Iterable<int>.generate(5));
    return ListView(
      children: sequence.map((num) => ListTile(title: Text('Item $num'))).toList(),
    );
  }
}
````
