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

##### <a name="signalcustompaint"></a><a name="signalcustompaint"></a><code>SignalCustomPaint({super.key, required this.painter, super.child})</code>

Creates a new [SignalCustomPaint](/types/signalcustompaint).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="painter"></a><code>SignalCustomPainter painter</code>

The painter to draw on the canvas.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createrenderobject"></a><code>RenderSignalCustomPaint createRenderObject(BuildContext context)</code>

##### <a name="updaterenderobject"></a><code>void updateRenderObject(BuildContext context, RenderSignalCustomPaint renderObject)</code>

</details>
