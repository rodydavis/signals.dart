# class `RenderSignalCustomPaint`

The **RenderObject** for [SignalCustomPaint](/types/signalcustompaint) that delegates drawing to [SignalCustomPainter](/types/signalcustompainter).

---

## Members of `RenderSignalCustomPaint`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **RenderSignalCustomPaint** | `constructor` | `RenderSignalCustomPaint({required SignalCustomPainter painter})` | Creates a new [RenderSignalCustomPaint](/types/rendersignalcustompaint). |
| **painter** | `method` | `SignalCustomPainter painter` | Gets the custom painter delegate. |
| **painter** | `method` | `painter(SignalCustomPainter val)` | Sets a new custom painter delegate and triggers a repaint if necessary. |
| **paint** | `method` | `void paint(PaintingContext context, Offset offset)` |  |
