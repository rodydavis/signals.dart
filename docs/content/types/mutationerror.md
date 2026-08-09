---
title: "Type: MutationError"
description: "API reference and details for MutationError from signals.dart."
---

# MutationError

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: MutationError

The mutation failed with an error and stack trace.

### Members of MutationError

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MutationError** | <code>constructor</code> | <code>dart MutationError(this.error, this.stackTrace)</code> | The mutation failed with an error and stack trace. |
| **isIdle** | <code>method</code> | <code>dart bool isIdle</code> |  |
| **isPending** | <code>method</code> | <code>dart bool isPending</code> |  |
| **hasValue** | <code>method</code> | <code>dart bool hasValue</code> |  |
| **hasError** | <code>method</code> | <code>dart bool hasError</code> |  |
| **value** | <code>method</code> | <code>dart T? value</code> |  |
| **error** | <code>field</code> | <code>dart Object error</code> |  |
| **stackTrace** | <code>field</code> | <code>dart StackTrace stackTrace</code> | The stack trace captured when the mutation failed. Always non-null on a |
| **requireValue** | <code>method</code> | <code>dart T requireValue</code> |  |
| **==** | <code>method</code> | <code>dart bool ==(covariant MutationState<T> other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **MutationError** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [MutationSignal](/packages/signals_flutter/async/mutation) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [MutationSignal](/packages/signals_core/async/mutation) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [MutationSignal](/packages/signals/async/mutation) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>

