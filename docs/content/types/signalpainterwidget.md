---
title: "Type: SignalPainterWidget"
description: "API reference and details for SignalPainterWidget from signals.dart."
---

# SignalPainterWidget

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: SignalPainterWidget

A high-performance, leaf render-object widget driven by a double progress signal.

<code>SignalPainterWidget</code> bypasses the entire widget build and layout phases, subscribing
directly to a **progress** signal and rendering on the canvas. When **progress** updates,
only the GPU paint phase is run.

### Example
```dart
final progress = signal(0.0);

@override
Widget build(BuildContext context) {
  return SignalPainterWidget(
    progress: progress,
    painter: (canvas, size, value) {
      final paint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        value * 50.0,
        paint,
      );
    },
  );
}
```

### Members of SignalPainterWidget

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **progress** | <code>field</code> | <code>dart core.ReadonlySignal<double> progress</code> | The progress signal whose value will be passed to **painter**. |
| **painter** | <code>field</code> | <code>dart void Function(Canvas canvas, Size size, double value) painter</code> | The custom painting callback function. |
| **SignalPainterWidget** | <code>constructor</code> | <code>dart SignalPainterWidget({super.key, required this.progress, required this.painter})</code> | Creates a new [SignalPainterWidget](/types/signalpainterwidget). |
| **createRenderObject** | <code>method</code> | <code>dart RenderSignalBox createRenderObject(BuildContext context)</code> |  |
| **updateRenderObject** | <code>method</code> | <code>dart void updateRenderObject(BuildContext context, RenderSignalBox renderObject)</code> |  |

## References

The **SignalPainterWidget** type is referenced and used in the following pages:

* [RenderSignalBox](/packages/signals_flutter/render/render-signal-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/render)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalPainterWidget](/packages/signals_flutter/widgets/signal-painter-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [RenderSignalBox](/packages/signals/render/render-signal-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals/render)</span>
* [signals](/packages/signals)
* [SignalPainterWidget](/packages/signals/widgets/signal-painter-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

