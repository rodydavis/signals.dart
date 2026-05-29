---
title: "Type: RenderSignalProxyBox"
description: "API reference and details for RenderSignalProxyBox from signals.dart."
---

# RenderSignalProxyBox

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: RenderSignalProxyBox

A low-level **RenderProxyBox** that subscribes to multiple reactive signals
and automatically schedules repaints without layout/rebuild when signals fire.

### Members of RenderSignalProxyBox

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **RenderSignalProxyBox** | <code>constructor</code> | <code>dart RenderSignalProxyBox({required List<core.ReadonlySignal<dynamic>> signals})</code> | Creates a new [RenderSignalProxyBox](/types/rendersignalproxybox) with the specified list of observed **signals**. |
| **signals** | <code>method</code> | <code>dart List<core.ReadonlySignal<dynamic>> signals</code> | Gets the current list of signals being observed. |
| **signals** | <code>method</code> | <code>dart signals(List<core.ReadonlySignal<dynamic>> val)</code> | Sets a new list of observed signals and resubscribes to them. |
| **detach** | <code>method</code> | <code>dart void detach()</code> |  |

## References

The **RenderSignalProxyBox** type is referenced and used in the following pages:

* [RenderSignalProxyBox](/packages/signals_flutter/render/render-signal-proxy-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/render)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalProxyWidget](/packages/signals_flutter/widgets/signal-proxy-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [RenderSignalProxyBox](/packages/signals/render/render-signal-proxy-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals/render)</span>
* [signals](/packages/signals)
* [SignalProxyWidget](/packages/signals/widgets/signal-proxy-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>

