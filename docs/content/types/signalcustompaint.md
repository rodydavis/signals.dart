---
title: "Type: SignalCustomPaint"
description: "API reference and details for SignalCustomPaint from signals.dart."
---

# SignalCustomPaint

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: SignalCustomPaint

A high-performance canvas painting widget that subscribes to signals and renders
directly on the GPU, completely bypassing the widget build and layout phases.

Use <code>SignalCustomPaint</code> in performance-critical rendering scenarios like real-time charts,
complex visual animations, particle systems, or game loops.

### Members of SignalCustomPaint

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **painter** | <code>field</code> | <code>dart SignalCustomPainter painter</code> | The painter to draw on the canvas. |
| **SignalCustomPaint** | <code>constructor</code> | <code>dart SignalCustomPaint({super.key, required this.painter, super.child})</code> | Creates a new [SignalCustomPaint](/types/signalcustompaint). |
| **createRenderObject** | <code>method</code> | <code>dart RenderSignalCustomPaint createRenderObject(BuildContext context)</code> |  |
| **updateRenderObject** | <code>method</code> | <code>dart void updateRenderObject(BuildContext context, RenderSignalCustomPaint renderObject)</code> |  |

## References

The **SignalCustomPaint** type is referenced and used in the following pages:

* [RenderSignalCustomPaint](/packages/signals_flutter/render/render-signal-custom-paint) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/render)</span>
* [SignalCustomPainter](/packages/signals_flutter/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalCustomPaint](/packages/signals_flutter/widgets/signal-custom-paint) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [RenderSignalCustomPaint](/packages/signals/render/render-signal-custom-paint) <span style="opacity: 0.6; font-size: 0.85em;">(signals/render)</span>
* [SignalCustomPainter](/packages/signals/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [signals](/packages/signals)
* [SignalCustomPaint](/packages/signals/widgets/signal-custom-paint) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

