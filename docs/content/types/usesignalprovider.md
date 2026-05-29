---
title: "Type: useSignalProvider"
description: "API reference and details for useSignalProvider from signals.dart."
---

# useSignalProvider

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useSignalProvider

```dart
T? useSignalProvider()
```

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

## References

The **useSignalProvider** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useSignalProvider](/packages/signals_hooks/hooks/use-signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

