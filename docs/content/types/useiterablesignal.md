---
title: "Type: useIterableSignal"
description: "API reference and details for useIterableSignal from signals.dart."
---

# useIterableSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useIterableSignal

```dart
IterableSignal<T> useIterableSignal(Iterable<T> value, {List<Object?> keys = const <Object>[], IterableSignalOptions<T>? options})
```

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

## References

The **useIterableSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useIterableSignal](/packages/signals_hooks/hooks/use-iterable-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

