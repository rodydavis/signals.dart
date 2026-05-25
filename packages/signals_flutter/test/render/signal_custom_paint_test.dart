import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

class TestPainter extends SignalCustomPainter {
  final Signal<double> strokeWidth;
  int paintCount = 0;

  TestPainter({required this.strokeWidth}) : super(signals: [strokeWidth]);

  @override
  void paint(Canvas canvas, Size size) {
    paintCount++;
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth.value;
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant TestPainter oldDelegate) {
    return strokeWidth != oldDelegate.strokeWidth;
  }
}

void main() {
  setUp(() {
    SignalsObserver.instance = null;
  });

  group('SignalCustomPaint', () {
    testWidgets('repaints on signal change bypassing parent rebuilds', (tester) async {
      final strokeWidth = signal(2.0);
      final painter = TestPainter(strokeWidth: strokeWidth);
      int parentBuilds = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                parentBuilds++;
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: SignalCustomPaint(
                    painter: painter,
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(parentBuilds, 1);
      expect(painter.paintCount, 1);

      // Update signal
      strokeWidth.value = 5.0;
      await tester.pumpAndSettle();

      // Parent build MUST still be 1 (skipping widget rebuild completely)
      expect(parentBuilds, 1);
      // Paint count MUST increment to 2 (successfully repainting on signal change!)
      expect(painter.paintCount, 2);
    });
  });

  group('SignalPainterWidget', () {
    testWidgets('renders leaf object and repaints directly on signal change', (tester) async {
      final progress = signal(0.1);
      int paintCount = 0;
      double paintedValue = 0.0;
      int parentBuilds = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                parentBuilds++;
                return SizedBox(
                  width: 200,
                  height: 200,
                  child: SignalPainterWidget(
                    progress: progress,
                    painter: (canvas, size, value) {
                      paintCount++;
                      paintedValue = value;
                      final paint = Paint()..color = Colors.blue;
                      canvas.drawRect(
                        Offset.zero & Size(size.width * value, size.height),
                        paint,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(parentBuilds, 1);
      expect(paintCount, 1);
      expect(paintedValue, 0.1);

      // Update progress signal
      progress.value = 0.8;
      await tester.pumpAndSettle();

      // Verify widget rebuild was entirely skipped
      expect(parentBuilds, 1);
      // Verify paint was re-triggered
      expect(paintCount, 2);
      expect(paintedValue, 0.8);
    });
  });
}
