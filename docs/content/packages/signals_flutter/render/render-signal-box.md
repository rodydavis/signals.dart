---
title: RenderSignalBox
description: The low-level RenderBox used by SignalPainterWidget to directly subscribe to a progress signal and paint.
---

The low-level **RenderBox** used by [SignalPainterWidget](/types/signalpainterwidget) to directly subscribe to a progress signal and paint.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="rendersignalbox"></a><a name="rendersignalbox"></a><code>RenderSignalBox({required core.ReadonlySignal<double> progress, required void Function(Canvas canvas, Size size, double value) painter})</code>

Creates a new [RenderSignalBox](/types/rendersignalbox) drawing using **_painter** and driven by **_progress** signal.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="progress"></a><code>progress(core.ReadonlySignal<double> val)</code>

Sets a new progress signal and resubscribes to updates.

##### <a name="painter"></a><code>painter(void Function(Canvas canvas, Size size, double value) val)</code>

Sets a new custom painter delegate.

##### <a name="performlayout"></a><code>void performLayout()</code>

##### <a name="paint"></a><code>void paint(PaintingContext context, Offset offset)</code>

##### <a name="detach"></a><code>void detach()</code>

</details>
