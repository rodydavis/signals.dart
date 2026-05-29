---
title: "Type: ComputedFromExt3"
description: "API reference and details for ComputedFromExt3 from signals.dart."
---

# ComputedFromExt3

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt3

```dart
extension ComputedFromExt3 on (ReadonlySignal<A>, ReadonlySignal<B>, ReadonlySignal<C>)
```

Extension on a 3-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt3

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A, B, C) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from these signals. |

## References

The **ComputedFromExt3** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

