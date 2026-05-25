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
    testWidgets('repaints on signal change bypassing parent rebuilds',
        (tester) async {
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
    testWidgets('renders leaf object and repaints directly on signal change',
        (tester) async {
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

  group('SignalCustomPaint Dynamic Updates and Detach', () {
    testWidgets('updates painter and disposes cleanly', (tester) async {
      final s1 = signal(2.0);
      final s2 = signal(4.0);
      final painter1 = TestPainter(strokeWidth: s1);
      final painter2 = TestPainter(strokeWidth: s2);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: SignalCustomPaint(
                painter: painter1,
              ),
            ),
          ),
        ),
      );

      expect(painter1.paintCount, 1);
      expect(painter2.paintCount, 0);

      // Swap painter
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: SignalCustomPaint(
                painter: painter2,
              ),
            ),
          ),
        ),
      );

      // Verify new painter painted and is updated
      expect(painter2.paintCount, 1);

      // Remove painter to trigger detach and verify clean disposal
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(),
          ),
        ),
      );
    });
  });

  group('SignalProxyWidget', () {
    testWidgets('subscribes and updates signals list', (tester) async {
      final s1 = signal(1.0);
      final s2 = signal(2.0);
      var triggerCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SignalProxyWidget(
              signals: [s1],
              child: Builder(
                builder: (context) {
                  triggerCount++;
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );

      expect(triggerCount, 1);

      // Update widget with new signal list
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SignalProxyWidget(
              signals: [s2],
              child: Builder(
                builder: (context) {
                  triggerCount++;
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );

      // Verify update completed cleanly
      expect(triggerCount, 2);

      // Detach proxy widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(),
          ),
        ),
      );
    });
  });

  group('SignalPainterWidget Dynamic Updates', () {
    testWidgets('updates progress/painter and detaches cleanly',
        (tester) async {
      final p1 = signal(0.2);
      final p2 = signal(0.4);
      var count1 = 0;
      var count2 = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: SignalPainterWidget(
                progress: p1,
                painter: (canvas, size, val) {
                  count1++;
                },
              ),
            ),
          ),
        ),
      );

      expect(count1, 1);

      // Update both progress signal and painter callback
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: SignalPainterWidget(
                progress: p2,
                painter: (canvas, size, val) {
                  count2++;
                },
              ),
            ),
          ),
        ),
      );

      expect(count2, 1);

      // Trigger paint on new progress signal
      p2.value = 0.6;
      await tester.pumpAndSettle();
      expect(count2, 2);

      // Detach painter widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(),
          ),
        ),
      );
    });
  });
}
