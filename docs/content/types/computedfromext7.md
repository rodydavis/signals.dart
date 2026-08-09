---
title: "Type: ComputedFromExt7"
description: "API reference and details for ComputedFromExt7 from signals.dart."
---

# ComputedFromExt7

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt7

```dart
extension ComputedFromExt7 on (ReadonlySignal<A>, ReadonlySignal<B>, ReadonlySignal<C>, ReadonlySignal<D>, ReadonlySignal<E>, ReadonlySignal<F>, ReadonlySignal<G>)
```

Extension on a 7-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt7

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A, B, C, D, E, F, G) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from these signals. |

## References

The **ComputedFromExt7** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

