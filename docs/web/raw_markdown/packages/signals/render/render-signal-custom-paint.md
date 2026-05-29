---
title: RenderSignalCustomPaint
description: The RenderObject for SignalCustomPaint that delegates drawing to SignalCustomPainter.
---

The **RenderObject** for [SignalCustomPaint](/types/signalcustompaint) that delegates drawing to [SignalCustomPainter](/types/signalcustompainter).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="rendersignalcustompaint"></a><a name="rendersignalcustompaint"></a>`RenderSignalCustomPaint({required SignalCustomPainter painter})`

Creates a new [RenderSignalCustomPaint](/types/rendersignalcustompaint).

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="painter"></a>`SignalCustomPainter painter`

Gets the custom painter delegate.

##### <a name="painter"></a>`painter(SignalCustomPainter val)`

Sets a new custom painter delegate and triggers a repaint if necessary.

##### <a name="paint"></a>`void paint(PaintingContext context, Offset offset)`

</details>
