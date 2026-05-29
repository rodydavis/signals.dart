---
title: SignalPainterWidget
description: A high-performance, leaf render-object widget driven by a double progress signal.
---

A high-performance, leaf render-object widget driven by a double progress signal.

<code>SignalPainterWidget</code> bypasses the entire widget build and layout phases, subscribing
directly to a **progress** signal and rendering on the canvas. When **progress** updates,
only the GPU paint phase is run.

### Example
```dart
final progress = signal(0.0);

@override
Widget build(BuildContext context) {
  return SignalPainterWidget(
    progress: progress,
    painter: (canvas, size, value) {
      final paint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        value * 50.0,
        paint,
      );
    },
  );
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalpainterwidget"></a><a name="signalpainterwidget"></a>`SignalPainterWidget({super.key, required this.progress, required this.painter})`

Creates a new [SignalPainterWidget](/types/signalpainterwidget).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="progress"></a>`core.ReadonlySignal<double> progress`

The progress signal whose value will be passed to **painter**.

##### <a name="painter"></a>`void Function(Canvas canvas, Size size, double value) painter`

The custom painting callback function.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createrenderobject"></a>`RenderSignalBox createRenderObject(BuildContext context)`

##### <a name="updaterenderobject"></a>`void updateRenderObject(BuildContext context, RenderSignalBox renderObject)`

</details>
