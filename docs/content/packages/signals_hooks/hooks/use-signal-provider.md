---
title: useSignalProvider
description: A custom hook to retrieve a generic signal from a SignalProvider ancestor higher up in the widget tree.
---

A custom hook to retrieve a generic signal from a [SignalProvider](/types/signalprovider) ancestor higher up in the widget tree.

Under the hood, this uses the BuildContext to look up the provider and registers
a reactive dependency.

Supports standard core signals from <code>package:signals_core/signals_core.dart</code> as well
as Flutter-native signals.

### Example Usage
```dart
class CounterDisplayWidget extends HookWidget {
  const CounterDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useSignalProvider<Signal<int>>();
    if (counter == null) return const Text('Not found');
    return Text('Value: ${counter.value}');
  }
}
```
