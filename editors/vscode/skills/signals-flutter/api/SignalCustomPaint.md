# class `SignalCustomPaint`

A high-performance canvas painting widget that subscribes to signals and renders
directly on the GPU, completely bypassing the widget build and layout phases.

Use <code>SignalCustomPaint</code> in performance-critical rendering scenarios like real-time charts,
complex visual animations, particle systems, or game loops.

---

## Members of `SignalCustomPaint`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **painter** | `field` | `SignalCustomPainter painter` | The painter to draw on the canvas. |
| **SignalCustomPaint** | `constructor` | `SignalCustomPaint({super.key, required this.painter, super.child})` | Creates a new [SignalCustomPaint](/types/signalcustompaint). |
| **createRenderObject** | `method` | `RenderSignalCustomPaint createRenderObject(BuildContext context)` |  |
| **updateRenderObject** | `method` | `void updateRenderObject(BuildContext context, RenderSignalCustomPaint renderObject)` |  |
