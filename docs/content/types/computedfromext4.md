---
title: "Type: ComputedFromExt4"
description: "API reference and details for ComputedFromExt4 from signals.dart."
---

# ComputedFromExt4

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt4

```dart
extension ComputedFromExt4 on (ReadonlySignal<A>, ReadonlySignal<B>, ReadonlySignal<C>, ReadonlySignal<D>)
```

Extension on a 4-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt4

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A, B, C, D) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from these signals. |

## References

The **ComputedFromExt4** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

