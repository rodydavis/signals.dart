---
title: "Type: ComputedFromExt8"
description: "API reference and details for ComputedFromExt8 from signals.dart."
---

# ComputedFromExt8

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt8

```dart
extension ComputedFromExt8 on (ReadonlySignal<A>, ReadonlySignal<B>, ReadonlySignal<C>, ReadonlySignal<D>, ReadonlySignal<E>, ReadonlySignal<F>, ReadonlySignal<G>, ReadonlySignal<H>)
```

Extension on a 8-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt8

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A, B, C, D, E, F, G, H) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from these signals. |

## References

The **ComputedFromExt8** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

