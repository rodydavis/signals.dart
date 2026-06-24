---
title: "Type: useMutationSignal"
description: "API reference and details for useMutationSignal from signals.dart."
---

# useMutationSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useMutationSignal

```dart
MutationSignal<A, T> useMutationSignal(Future<T> Function(A arg) mutation, {List<Object?> keys = const <Object>[], SignalOptions<MutationState<T>>? options})
```

Creates a new [MutationSignal](/types/mutationsignal) and subscribes to it.

A [MutationSignal](/types/mutationsignal) models an imperative, on-demand asynchronous side effect
(a mutation). Unlike
[useFutureSignal](/types/usefuturesignal), it does not run on creation; it starts in a
[MutationIdle](/types/mutationidle) state and only transitions when you call <code>mutate</code>/<code>mutateAsync</code>.

<Success>
Perfect for button-triggered writes (submitting a form, calling a
<code>POST</code>/<code>PUT</code>/<code>DELETE</code>). The host widget rebuilds as the mutation moves
through idle → pending → success/error.
</Success>

### Parameters
- **mutation**: The mutation function. Receives a single typed argument <code>A</code>
  (use a record for multiple values) and returns the result <code>T</code>.
- **keys**: A list of objects to watch. If any key changes, the mutation
  signal is re-created (resetting it back to [MutationIdle](/types/mutationidle)).
- **options**: Optional [SignalOptions](/types/signaloptions) to configure the signal.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class SaveButton extends HookWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    final save = useMutationSignal<Todo, void>((todo) => api.add(todo));

    return save.value.map(
      idle: () => ElevatedButton(
        onPressed: () => save.mutate(Todo('New')),
        child: const Text('Save'),
      ),
      pending: () => const CircularProgressIndicator(),
      data: (_) => const Text('Saved!'),
      error: (err, _) => Column(
        children: [
          Text('Error: $err', style: const TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: () => save.mutate(Todo('New')),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
````

## References

The **useMutationSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useMutationSignal](/packages/signals_hooks/hooks/use-mutation-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

