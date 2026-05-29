# `SignalCustomPaint` (GPU Acceleration)

For ultra-high-frequency animations or rendering (e.g. video timelines, sensor graphs, physics simulations), standard widget rebuilding can be too slow. `SignalCustomPaint` and `SignalPainterWidget` write directly to the GPU via `markNeedsPaint()` calls inside custom proxy render boxes:

---

## 1. Creation

```dart
final progress = signal(0.0);

Widget build(BuildContext context) {
  return SignalCustomPaint(
    painter: ProgressPainter(progress),
    child: Container(),
  );
}

class ProgressPainter extends CustomPainter {
  final ReadonlySignal<double> progress;
  ProgressPainter(this.progress) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Renders canvas paint operations directly!
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
```

---

## 2. Efficiency
- Completely bypasses standard Flutter layout, constraint resolving, and element rebuilding phases.
- Delivers fluid, stutter-free 120 FPS render pipelines.
