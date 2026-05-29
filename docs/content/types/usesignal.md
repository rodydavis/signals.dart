---
title: "Type: useSignal"
description: "API reference and details for useSignal from signals.dart."
---

# useSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useSignal

```dart
FlutterSignal<T> useSignal(T value, {List<Object?> keys = const <Object>[], SignalOptions<T>? options})
```

Creates a new [Signal](/types/signal) that persists across widget rebuilds and subscribes to it.

The signal is instantiated once using **useMemoized** and automatically disposed of or cleaned up
if necessary (signals created in this manner are managed by the Hook lifetime). The widget
will automatically rebuild whenever this signal's value changes.

<Warning>
  If you want the signal to survive widget disposal (e.g. shared state), do not use <a href="/types/usesignal">useSignal</a>.
  Instead, define your signal globally or in a controller, and subscribe to it using <a href="/types/useexistingsignal">useExistingSignal</a>
  or <a href="/types/usesignalvalue">useSignalValue</a>.
</Warning>

### Parameters
- **value**: The initial value of the signal.
- **keys**: A list of objects to watch for changes. If any key in this list changes, the signal is
  re-created with the current **value** as its initial value.
- **debugLabel**: An optional debug label to identify the signal in developer tools.

### Returns
A local [FlutterSignal](/types/fluttersignal) instance representing the reactive state.

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

## References

The **useSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useConnect](/packages/signals_hooks/hooks/use-connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignal](/packages/signals_hooks/hooks/use-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useComputed](/packages/signals_hooks/hooks/use-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useAsyncComputed](/packages/signals_hooks/hooks/use-async-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignalEffect](/packages/signals_hooks/hooks/use-signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [SignalStatefulHookWidget](/packages/signals_hooks/widgets/signal-stateful-hook-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>
* [SignalHookWidget](/packages/signals_hooks/widgets/signal-hook-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>

