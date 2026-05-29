---
title: "Type: ComputedFromExt6"
description: "API reference and details for ComputedFromExt6 from signals.dart."
---

# ComputedFromExt6

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt6

```dart
extension ComputedFromExt6 on (ReadonlySignal<A>, ReadonlySignal<B>, ReadonlySignal<C>, ReadonlySignal<D>, ReadonlySignal<E>, ReadonlySignal<F>)
```

Extension on a 6-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt6

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A, B, C, D, E, F) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from these signals. |

## References

The **ComputedFromExt6** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

