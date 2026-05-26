# `useConnect`

Creates a new `Connect` instance and automatically disposes of it when the widget unmounts. `Connect` connects one or more streams to feed a target signal.

## Signature

```dart
Connect<T, S> useConnect<T, S extends T>(
  Signal<T> signal, [
  Stream<S>? stream,
])
```

## Details & Best Practices

- **Automatic Disposal**: The connection manages stream subscriptions, and unregistering/unmounting the widget automatically cancels all connected stream listeners to prevent leaks.
- **Dynamic Stream Connection**: Connects a stream directly to a signal. The signal's value is automatically updated whenever the stream emits a new event.
- **Operators & Chaining**: You can chain multiple streams using the `.from()` method or using the `<<` operator.

## Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class StreamingCounterWidget extends HookWidget {
  const StreamingCounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useSignal(0);

    // Feed a periodic stream to the counter signal
    final periodicStream = useMemoized(
      () => Stream.periodic(const Duration(seconds: 1), (i) => i),
    );
    
    // Connects stream and disposes subscription on unmount
    useConnect(counter, periodicStream);

    return Text('Counter ticks: ${counter.value}');
  }
}
```
