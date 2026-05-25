import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

class TestHeavyWidget extends StatelessWidget {
  final VoidCallback onBuild;
  const TestHeavyWidget({super.key, required this.onBuild});

  @override
  Widget build(BuildContext context) {
    onBuild();
    return const Text('Heavy Content');
  }
}

void main() {
  setUp(() {
    SignalsObserver.instance = null;
  });

  group('SignalAnimatedBuilder', () {
    testWidgets('surgically rebuilds when read signals update', (tester) async {
      final counter = signal(100);
      int builderCalls = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SignalAnimatedBuilder(
              builder: (context, child) {
                builderCalls++;
                return Text('Count: ${counter.value}');
              },
            ),
          ),
        ),
      );

      expect(builderCalls, 1);
      expect(find.text('Count: 100'), findsOneWidget);

      counter.value = 101;
      await tester.pumpAndSettle();

      expect(builderCalls, 2);
      expect(find.text('Count: 101'), findsOneWidget);
    });

    testWidgets('caches and does not rebuild the static child subtree', (tester) async {
      final counter = signal(0);
      int builderCalls = 0;
      int heavyWidgetBuilds = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SignalAnimatedBuilder(
              child: TestHeavyWidget(onBuild: () => heavyWidgetBuilds++),
              builder: (context, child) {
                builderCalls++;
                return Column(
                  children: [
                    Text('Counter: ${counter.value}'),
                    child!,
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(builderCalls, 1);
      expect(heavyWidgetBuilds, 1);
      expect(find.text('Counter: 0'), findsOneWidget);
      expect(find.text('Heavy Content'), findsOneWidget);

      // Mutate signal
      counter.value = 1;
      await tester.pumpAndSettle();

      // Builder should rebuild, but the heavy static child MUST NOT!
      expect(builderCalls, 2);
      expect(heavyWidgetBuilds, 1); // Remains 1! Caching works perfectly!
      expect(find.text('Counter: 1'), findsOneWidget);
      expect(find.text('Heavy Content'), findsOneWidget);
    });

    testWidgets('respects explicit dependencies list', (tester) async {
      final depSignal = signal(0);
      int builderCalls = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SignalAnimatedBuilder(
              dependencies: [depSignal],
              builder: (context, child) {
                builderCalls++;
                return const Text('Static UI');
              },
            ),
          ),
        ),
      );

      expect(builderCalls, 1);

      // Mutating dependency triggers rebuild even if not read in builder closure
      depSignal.value = 1;
      await tester.pumpAndSettle();

      expect(builderCalls, 2);
    });
  });
}
