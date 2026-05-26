---
title: useLazySignal
description: Creates a new Signal that starts uninitialized and subscribes to it.
---

Creates a new [Signal](/packages/signals/core/signal) that starts uninitialized and subscribes to it.

A lazy signal is a signal that doesn't have an initial value on creation. Reading its <code>.value</code>
before setting it will throw a **LazySignalInitializationError**.

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
