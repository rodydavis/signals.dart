---
title: "Type: useLazySignal"
description: "API reference and details for useLazySignal from signals.dart."
---

# useLazySignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useLazySignal

```dart
Signal<T> useLazySignal({SignalOptions<T>? options, List<Object?> keys = const <Object>[]})
```

Creates a new [Signal](/types/signal) that starts uninitialized and subscribes to it.

A lazy signal is a signal that doesn't have an initial value on creation. Reading its <code>.value</code>
before setting it will throw a [LazySignalInitializationError](/types/lazysignalinitializationerror).

<Info>
  Ideal for binding late-initialized state, such as data fetched in a lifecycle effect
  or passed asynchronously from platform channels.
</Info>

### Parameters
- **keys**: A list of objects to watch. If any key changes, the signal is re-created.
- **options**: Optional configuration options for standard signals (e.g. name, autoDispose).

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class LateSetupWidget extends HookWidget {
  const LateSetupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Starts uninitialized safely
    final dataSignal = useLazySignal<String>();

    useEffect(() {
      Future.delayed(const Duration(seconds: 1), () {
        dataSignal.value = 'Initialized Data';
      });
      return null;
    }, []);

    return Text(dataSignal.value.isEmpty ? 'Uninitialized' : dataSignal.value);
  }
}
````

## References

The **useLazySignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useLazySignal](/packages/signals_hooks/hooks/use-lazy-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

