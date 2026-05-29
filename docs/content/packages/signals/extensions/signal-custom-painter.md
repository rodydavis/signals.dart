---
title: SignalCustomPainter
description: A premium custom painter that automatically repaints when any observed signal changes,.
---

A premium custom painter that automatically repaints when any observed signal changes,
bypassing Flutter's widget build and layout phases completely.

<code>SignalCustomPainter</code> registers subscriptions to the provided list of **signals**. When any
of these signals fire, a GPU repaint is scheduled directly via <code>markNeedsPaint()</code>, bypassing
the widget-tree build cycle and layout passes for unmatched graphics performance.

### Interactive Star Field Canvas Example
```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final cursorOffset = signal(const Offset(0, 0));

class StarField extends StatelessWidget {
  const StarField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        cursorOffset.value = details.localPosition;
      },
      child: Container(
        color: const Color(0xFF0B0D19),
        child: SignalCustomPaint(
          painter: StarPainter(cursorOffset),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class StarPainter extends SignalCustomPainter {
  StarPainter(this.offsetSignal) : super(signals: [offsetSignal]);

  final ReadonlySignal<Offset> offsetSignal;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw 100 stars deterministically distributed across the canvas size
    for (int i = 0; i < 100; i++) {
      final double x = ((i * 197) % 1000) / 1000 * size.width;
      final double y = ((i * 541) % 1000) / 1000 * size.height;
      final double starSize = ((i * 7) % 4) + 1.5;

      final starPos = Offset(x, y);
      final distance = (starPos - offsetSignal.value).distance;

      if (distance < 120.0) {
        // Spotlight/Twinkle effect: make stars near the cursor brighter & larger!
        final factor = 1.0 - (distance / 120.0);
        paint.color = Colors.amber.withOpacity(0.3 + 0.7 * factor);
        final glowSize = starSize + (factor * 4.0);
        canvas.drawCircle(starPos, glowSize, paint);

        // Draw premium constellation lines connecting nearby stars to the cursor
        final linePaint = Paint()
          ..color = Colors.amber.withOpacity(0.25 * factor)
          ..strokeWidth = 1.0;
        canvas.drawLine(offsetSignal.value, starPos, linePaint);
      } else {
        // Normal distant star
        paint.color = Colors.white.withOpacity(0.4);
        canvas.drawCircle(starPos, starSize, paint);
      }
    }

    // Draw the interactive controller glow source
    final cursorPaint = Paint()
      ..color = Colors.amber.withOpacity(0.8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0);
    canvas.drawCircle(offsetSignal.value, 6.0, cursorPaint);
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalcustompainter"></a><a name="signalcustompainter"></a><code>SignalCustomPainter({required this.signals})</code>

Creates a new [SignalCustomPainter](/types/signalcustompainter).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="signals"></a><code>List<core.ReadonlySignal<dynamic>> signals</code>

The list of signals to observe for changes.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="paint"></a><code>void paint(Canvas canvas, Size size)</code>

Paint on the canvas.

##### <a name="shouldrepaint"></a><code>bool shouldRepaint(covariant SignalCustomPainter oldDelegate)</code>

Return true if the painter should be updated when the widget configuration changes.

</details>
