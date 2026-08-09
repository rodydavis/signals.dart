# class `RenderSignalBox`

The low-level **RenderBox** used by [SignalPainterWidget](/types/signalpainterwidget) to directly subscribe to a progress signal and paint.

---

## Members of `RenderSignalBox`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **RenderSignalBox** | `constructor` | `RenderSignalBox({required core.ReadonlySignal<double> progress, required void Function(Canvas canvas, Size size, double value) painter})` | Creates a new [RenderSignalBox](/types/rendersignalbox) drawing using **_painter** and driven by **_progress** signal. |
| **progress** | `method` | `progress(core.ReadonlySignal<double> val)` | Sets a new progress signal and resubscribes to updates. |
| **painter** | `method` | `painter(void Function(Canvas canvas, Size size, double value) val)` | Sets a new custom painter delegate. |
| **performLayout** | `method` | `void performLayout()` |  |
| **paint** | `method` | `void paint(PaintingContext context, Offset offset)` |  |
| **detach** | `method` | `void detach()` |  |
