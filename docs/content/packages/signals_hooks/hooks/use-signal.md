---
title: useSignal
description: Creates a new Signal that persists across widget rebuilds and subscribes to it.
---

Creates a new [Signal](/packages/signals/core/signal) that persists across widget rebuilds and subscribes to it.

The signal is instantiated once using **useMemoized** and automatically disposed of or cleaned up
if necessary (signals created in this manner are managed by the Hook lifetime). The widget
will automatically rebuild whenever this signal's value changes.

<Warning>
  If you want the signal to survive widget disposal (e.g. shared state), do not use [useSignal](/packages/signals_hooks/hooks/use-signal).
  Instead, define your signal globally or in a controller, and subscribe to it using [useExistingSignal](/packages/signals_hooks/hooks/use-existing-signal)
  or [useSignalValue](/packages/signals_hooks/hooks/use-signal-value).
</Warning>

### Parameters
- **value**: The initial value of the signal.
- **keys**: A list of objects to watch for changes. If any key in this list changes, the signal is
  re-created with the current **value** as its initial value.
- **debugLabel**: An optional debug label to identify the signal in developer tools.

### Returns
A local [FlutterSignal](/packages/signals/flutter/signal) instance representing the reactive state.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class CounterHookWidget extends HookWidget {
  const CounterHookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a local signal managed by this HookWidget's lifecycle
    final count = useSignal(0, keys: const [], options: SignalOptions(name: 'localCounter'));

    return Scaffold(
      body: Center(
        child: Text(
          'Count: ${count.value}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
````
