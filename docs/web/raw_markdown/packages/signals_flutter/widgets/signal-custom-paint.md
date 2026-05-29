---
title: SignalCustomPaint
description: A high-performance canvas painting widget that subscribes to signals and renders.
---

A high-performance canvas painting widget that subscribes to signals and renders
directly on the GPU, completely bypassing the widget build and layout phases.

Use <code>SignalCustomPaint</code> in performance-critical rendering scenarios like real-time charts,
complex visual animations, particle systems, or game loops.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalcustompaint"></a><a name="signalcustompaint"></a>`SignalCustomPaint({super.key, required this.painter, super.child})`

Creates a new [SignalCustomPaint](/types/signalcustompaint).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="painter"></a>`SignalCustomPainter painter`

The painter to draw on the canvas.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createrenderobject"></a>`RenderSignalCustomPaint createRenderObject(BuildContext context)`

##### <a name="updaterenderobject"></a>`void updateRenderObject(BuildContext context, RenderSignalCustomPaint renderObject)`

</details>
