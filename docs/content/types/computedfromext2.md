---
title: "Type: ComputedFromExt2"
description: "API reference and details for ComputedFromExt2 from signals.dart."
---

# ComputedFromExt2

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt2

```dart
extension ComputedFromExt2 on (ReadonlySignal<A>, ReadonlySignal<B>)
```

Extension on a 2-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt2

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A, B) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from these signals. |

## References

The **ComputedFromExt2** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

