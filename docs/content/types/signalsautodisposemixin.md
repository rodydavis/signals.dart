---
title: "Type: SignalsAutoDisposeMixin"
description: "API reference and details for SignalsAutoDisposeMixin from signals.dart."
---

# SignalsAutoDisposeMixin

<Info>
  <strong>Kind:</strong> <code>mixin</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Mixin: SignalsAutoDisposeMixin

Mixin to enable autodispose on a signal

### Members of SignalsAutoDisposeMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | <code>field</code> | <code>dart bool autoDispose</code> | Throws and error if read after dispose and can be |
| **disposed** | <code>method</code> | <code>dart bool disposed</code> | Check if the effect is disposed |
| **onDispose** | <code>method</code> | <code>dart void Function() onDispose(void Function() cleanup)</code> | Add a cleanup function to be called when the signal is disposed |
| **disposed** | <code>method</code> | <code>dart disposed(bool value)</code> | Force a signal to be disposed |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> | Dispose the signal |

## References

The **SignalsAutoDisposeMixin** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>

