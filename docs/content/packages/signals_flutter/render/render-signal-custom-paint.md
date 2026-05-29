---
title: RenderSignalCustomPaint
description: The RenderObject for SignalCustomPaint that delegates drawing to SignalCustomPainter.
---

The **RenderObject** for [SignalCustomPaint](/types/signalcustompaint) that delegates drawing to [SignalCustomPainter](/types/signalcustompainter).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="rendersignalcustompaint"></a><a name="rendersignalcustompaint"></a><code>RenderSignalCustomPaint({required SignalCustomPainter painter})</code>

Creates a new [RenderSignalCustomPaint](/types/rendersignalcustompaint).

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="painter"></a><code>SignalCustomPainter painter</code>

Gets the custom painter delegate.

##### <a name="painter"></a><code>painter(SignalCustomPainter val)</code>

Sets a new custom painter delegate and triggers a repaint if necessary.

##### <a name="paint"></a><code>void paint(PaintingContext context, Offset offset)</code>

</details>
