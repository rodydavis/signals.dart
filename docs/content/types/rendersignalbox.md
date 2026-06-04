---
title: "Type: RenderSignalBox"
description: "API reference and details for RenderSignalBox from signals.dart."
---

# RenderSignalBox

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: RenderSignalBox

The low-level **RenderBox** used by [SignalPainterWidget](/types/signalpainterwidget) to directly subscribe to a progress signal and paint.

### Members of RenderSignalBox

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **RenderSignalBox** | <code>constructor</code> | <code>dart RenderSignalBox({required core.ReadonlySignal<double> progress, required void Function(Canvas canvas, Size size, double value) painter})</code> | Creates a new [RenderSignalBox](/types/rendersignalbox) drawing using **_painter** and driven by **_progress** signal. |
| **progress** | <code>method</code> | <code>dart progress(core.ReadonlySignal<double> val)</code> | Sets a new progress signal and resubscribes to updates. |
| **painter** | <code>method</code> | <code>dart painter(void Function(Canvas canvas, Size size, double value) val)</code> | Sets a new custom painter delegate. |
| **performLayout** | <code>method</code> | <code>dart void performLayout()</code> |  |
| **paint** | <code>method</code> | <code>dart void paint(PaintingContext context, Offset offset)</code> |  |
| **detach** | <code>method</code> | <code>dart void detach()</code> |  |

## References

The **RenderSignalBox** type is referenced and used in the following pages:

* [RenderSignalBox](/packages/signals_flutter/render/render-signal-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/render)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalPainterWidget](/packages/signals_flutter/widgets/signal-painter-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [RenderSignalBox](/packages/signals/render/render-signal-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals/render)</span>
* [signals](/packages/signals)
* [SignalPainterWidget](/packages/signals/widgets/signal-painter-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>

