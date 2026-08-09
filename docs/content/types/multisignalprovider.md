---
title: "Type: MultiSignalProvider"
description: "API reference and details for MultiSignalProvider from signals.dart."
---

# MultiSignalProvider

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: MultiSignalProvider

A dependency-injection / state propagation widget that allows passing
multiple reactive signals down the Flutter widget tree.

This avoids the deeply nested trees that result from nesting multiple
single [SignalProvider](/types/signalprovider) widgets.

### Members of MultiSignalProvider

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MultiSignalProvider** | <code>constructor</code> | <code>dart MultiSignalProvider({super.key, required this.providers, required this.child})</code> | Exposes multiple [SignalProvider](/types/signalprovider) widgets inside a flat list. |
| **providers** | <code>field</code> | <code>dart List<SignalProvider> providers</code> | The list of single [SignalProvider](/types/signalprovider) widgets to nest. |
| **child** | <code>field</code> | <code>dart Widget child</code> | The widget subtree that will have access to the provided signals. |
| **build** | <code>method</code> | <code>dart Widget build(BuildContext context)</code> |  |

## References

The **MultiSignalProvider** type is referenced and used in the following pages:

* [signals_flutter](/packages/signals_flutter)
* [MultiSignalProvider](/packages/signals_flutter/widgets/multi-signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalProvider](/packages/signals_flutter/widgets/signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [signals](/packages/signals)
* [MultiSignalProvider](/packages/signals/widgets/multi-signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalProvider](/packages/signals/widgets/signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

