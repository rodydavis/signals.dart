---
title: "Type: SignalMutationFunctionUtils"
description: "API reference and details for SignalMutationFunctionUtils from signals.dart."
---

# SignalMutationFunctionUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: SignalMutationFunctionUtils

```dart
extension SignalMutationFunctionUtils on Future<T> Function(A)
```

Extension on a mutation function <code>Future<T> Function(A)</code> to convert it into
a [MutationSignal](/types/mutationsignal).

### Members of SignalMutationFunctionUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toMutationSignal** | <code>method</code> | <code>dart MutationSignal<A, T> toMutationSignal({SignalOptions<MutationState<T>>? options})</code> | Convert this mutation function into a [MutationSignal](/types/mutationsignal). |

## References

The **SignalMutationFunctionUtils** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>

