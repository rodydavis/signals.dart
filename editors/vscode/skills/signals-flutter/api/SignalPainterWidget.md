# class `SignalPainterWidget`

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

---

## Members of `SignalPainterWidget`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **progress** | `field` | `core.ReadonlySignal<double> progress` | The progress signal whose value will be passed to **painter**. |
| **painter** | `field` | `void Function(Canvas canvas, Size size, double value) painter` | The custom painting callback function. |
| **SignalPainterWidget** | `constructor` | `SignalPainterWidget({super.key, required this.progress, required this.painter})` | Creates a new [SignalPainterWidget](/types/signalpainterwidget). |
| **createRenderObject** | `method` | `RenderSignalBox createRenderObject(BuildContext context)` |  |
| **updateRenderObject** | `method` | `void updateRenderObject(BuildContext context, RenderSignalBox renderObject)` |  |
