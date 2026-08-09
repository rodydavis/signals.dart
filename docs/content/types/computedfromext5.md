---
title: "Type: ComputedFromExt5"
description: "API reference and details for ComputedFromExt5 from signals.dart."
---

# ComputedFromExt5

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt5

```dart
extension ComputedFromExt5 on (ReadonlySignal<A>, ReadonlySignal<B>, ReadonlySignal<C>, ReadonlySignal<D>, ReadonlySignal<E>)
```

Extension on a 5-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt5

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A, B, C, D, E) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from these signals. |

## References

The **ComputedFromExt5** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

