---
title: "Type: ComputedFromExt10"
description: "API reference and details for ComputedFromExt10 from signals.dart."
---

# ComputedFromExt10

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt10

```dart
extension ComputedFromExt10 on (ReadonlySignal<A>, ReadonlySignal<B>, ReadonlySignal<C>, ReadonlySignal<D>, ReadonlySignal<E>, ReadonlySignal<F>, ReadonlySignal<G>, ReadonlySignal<H>, ReadonlySignal<I>, ReadonlySignal<J>)
```

Extension on a 10-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt10

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A, B, C, D, E, F, G, H, I, J) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from these signals. |

## References

The **ComputedFromExt10** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

