---
title: "Type: ComputedFromExt9"
description: "API reference and details for ComputedFromExt9 from signals.dart."
---

# ComputedFromExt9

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ComputedFromExt9

```dart
extension ComputedFromExt9 on (ReadonlySignal<A>, ReadonlySignal<B>, ReadonlySignal<C>, ReadonlySignal<D>, ReadonlySignal<E>, ReadonlySignal<F>, ReadonlySignal<G>, ReadonlySignal<H>, ReadonlySignal<I>)
```

Extension on a 9-tuple of [ReadonlySignal](/types/readonlysignal)s to create an asynchronous computed signal.

### Members of ComputedFromExt9

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computedFrom** | <code>method</code> | <code>dart FutureSignal<T> computedFrom(FutureOr<T> Function(A, B, C, D, E, F, G, H, I) fn, {AsyncSignalOptions<T>? options})</code> | Create an asynchronous computed signal from these signals. |

## References

The **ComputedFromExt9** type is referenced and used in the following pages:

* No other guides or pages explicitly reference this type.

