---
title: "Type: ComputedFromExt1"
description: "API reference and details for ComputedFromExt1 from signals.dart."
---

# ComputedFromExt1

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt1

```dart
extension ComputedFromExt1 on (ReadonlySignal<A>)
```

Extension on a 1-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt1

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from this signal. |

## References

The **ComputedFromExt1** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

