---
title: "Type: SignalCustomPainter"
description: "API reference and details for SignalCustomPainter from signals.dart."
---

# SignalCustomPainter

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: SignalCustomPainter

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

### Members of SignalCustomPainter

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **signals** | <code>field</code> | <code>dart List<core.ReadonlySignal<dynamic>> signals</code> | The list of signals to observe for changes. |
| **SignalCustomPainter** | <code>constructor</code> | <code>dart SignalCustomPainter({required this.signals})</code> | Creates a new [SignalCustomPainter](/types/signalcustompainter). |
| **paint** | <code>method</code> | <code>dart void paint(Canvas canvas, Size size)</code> | Paint on the canvas. |
| **shouldRepaint** | <code>method</code> | <code>dart bool shouldRepaint(covariant SignalCustomPainter oldDelegate)</code> | Return true if the painter should be updated when the widget configuration changes. |

## References

The **SignalCustomPainter** type is referenced and used in the following pages:

* [RenderSignalCustomPaint](/packages/signals_flutter/render/render-signal-custom-paint) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/render)</span>
* [SignalCustomPainter](/packages/signals_flutter/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalCustomPaint](/packages/signals_flutter/widgets/signal-custom-paint) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [RenderSignalCustomPaint](/packages/signals/render/render-signal-custom-paint) <span style="opacity: 0.6; font-size: 0.85em;">(signals/render)</span>
* [SignalCustomPainter](/packages/signals/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [signals](/packages/signals)
* [SignalCustomPaint](/packages/signals/widgets/signal-custom-paint) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

