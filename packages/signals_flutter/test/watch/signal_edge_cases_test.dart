import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

// 1. Widget reading no signals
class ZeroSignalWidget extends SignalWidget {
  final VoidCallback onBuild;
  const ZeroSignalWidget({super.key, required this.onBuild});

  @override
  Widget build(BuildContext context) {
    onBuild();
    return const Text('Zero Signals');
  }
}

// 2. Widget that throws an exception during build
class ThrowingSignalWidget extends SignalWidget {
  final Signal<int> counter;
  const ThrowingSignalWidget({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    if (counter.value == 1) {
      throw Exception('Build Crash Test');
    }
    return Text('Count: ${counter.value}');
  }
}

// 3. Widget reading a stable set of signals
class StableSignalWidget extends SignalWidget {
  final Signal<int> countA;
  final Signal<int> countB;
  final VoidCallback onBuild;

  const StableSignalWidget({
    super.key,
    required this.countA,
    required this.countB,
    required this.onBuild,
  });

  @override
  Widget build(BuildContext context) {
    onBuild();
    return Text('A: ${countA.value}, B: ${countB.value}');
  }
}

// 4. Widget to test multiple rapid updates
class RapidWidget extends SignalWidget {
  final Signal<int> counter;
  final VoidCallback onBuild;
  const RapidWidget({
    super.key,
    required this.counter,
    required this.onBuild,
  });

  @override
  Widget build(BuildContext context) {
    onBuild();
    return Text('Count: ${counter.value}');
  }
}

void main() {
  setUp(() {
    SignalsObserver.instance = null;
  });

  group('SignalWidget Edge Cases', () {
    testWidgets('Zero signals read does not subscribe or crash',
        (tester) async {
      int buildCount = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZeroSignalWidget(onBuild: () => buildCount++),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Zero Signals'), findsOneWidget);
    });

    testWidgets('Re-binding identical signals does not redundant-subscribe',
        (tester) async {
      final countA = signal(10);
      final countB = signal(20);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StableSignalWidget(
              countA: countA,
              countB: countB,
              onBuild: () => buildCount++,
            ),
          ),
        ),
      );

      expect(buildCount, 1);

      // Mutate A
      countA.value = 11;
      await tester.pumpAndSettle();
      expect(buildCount, 2);

      // Mutate B
      countB.value = 21;
      await tester.pumpAndSettle();
      expect(buildCount, 3);
    });

    testWidgets(
        'Exception safety: build error does not contaminate next widget build',
        (tester) async {
      final counter = signal(0);

      // 1. Initial successful build
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ThrowingSignalWidget(counter: counter),
          ),
        ),
      );

      expect(find.text('Count: 0'), findsOneWidget);

      // 2. Trigger Exception in build
      counter.value = 1;
      await tester.pump();
      expect(tester.takeException(), isNotNull);

      // 3. Verify global onSignalRead is restored and not nullified/corrupted
      final cleanCounter = signal(100);
      int normalBuilds = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Watch((context) {
              normalBuilds++;
              return Text('Clean: ${cleanCounter.value}');
            }),
          ),
        ),
      );

      expect(normalBuilds, 1);
      expect(find.text('Clean: 100'), findsOneWidget);

      // Verify cleanCounter updates still rebuild properly
      cleanCounter.value = 101;
      await tester.pumpAndSettle();
      expect(normalBuilds, 2);
      expect(find.text('Clean: 101'), findsOneWidget);
    });

    testWidgets(
        'Multiple rapid updates in one frame only triggers a single rebuild',
        (tester) async {
      final counter = signal(0);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RapidWidget(
              counter: counter,
              onBuild: () => buildCount++,
            ),
          ),
        ),
      );

      expect(buildCount, 1);

      // Rapidly update signal multiple times synchronously
      counter.value = 1;
      counter.value = 2;
      counter.value = 3;

      await tester.pumpAndSettle();

      // Should only build once more for the new frame
      expect(buildCount, 2);
      expect(find.text('Count: 3'), findsOneWidget);
    });
  });
}
