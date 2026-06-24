---
title: "Type: mutationSignalContainer"
description: "API reference and details for mutationSignalContainer from signals.dart."
---

# mutationSignalContainer

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Function: mutationSignalContainer

```dart
SignalContainer<MutationState<T>, Arg, MutationSignal<A, T>> mutationSignalContainer(MutationSignal<A, T> Function(Arg) create, {bool cache = false, void Function(Arg key, MutationSignal<A, T> signal)? onEvict})
```

Create a signal container for MutationSignals based on args.

<code>A</code> is the mutation argument type, <code>T</code> the mutation result type, and <code>Arg</code>
the container key used to cache/look up each mutation.

```dart
final container = mutationSignalContainer<Todo, void, int>((listId) {
  return mutationSignal<Todo, void>((todo) => api.add(listId, todo));
}, cache: true);

container(1).mutate(myTodo); // per-list mutation, cached by listId
```

## References

The **mutationSignalContainer** type is referenced and used in the following pages:

* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>

