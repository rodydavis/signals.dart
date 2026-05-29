---
title: RenderSignalBox
description: The low-level RenderBox used by SignalPainterWidget to directly subscribe to a progress signal and paint.
---

The low-level **RenderBox** used by [SignalPainterWidget](/types/signalpainterwidget) to directly subscribe to a progress signal and paint.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="rendersignalbox"></a><a name="rendersignalbox"></a>`RenderSignalBox({required core.ReadonlySignal<double> progress, required void Function(Canvas canvas, Size size, double value) painter})`

Creates a new [RenderSignalBox](/types/rendersignalbox) drawing using **_painter** and driven by **_progress** signal.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="progress"></a>`progress(core.ReadonlySignal<double> val)`

Sets a new progress signal and resubscribes to updates.

##### <a name="painter"></a>`painter(void Function(Canvas canvas, Size size, double value) val)`

Sets a new custom painter delegate.

##### <a name="performlayout"></a>`void performLayout()`

##### <a name="paint"></a>`void paint(PaintingContext context, Offset offset)`

##### <a name="detach"></a>`void detach()`

</details>
