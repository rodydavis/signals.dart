import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  setUp(() {
    SignalsObserver.instance = null;
  });

  group('SignalBuilder', () {
    testWidgets('surgically rebuilds builder block on signal change',
        (tester) async {
      final counter = signal(50);
      int parentBuilds = 0;
      int builderBuilds = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                parentBuilds++;
                return Column(
                  children: [
                    Text('Parent: $parentBuilds'),
                    SignalBuilder(
                      builder: (context) {
                        builderBuilds++;
                        return Text('Counter: ${counter.value}');
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(parentBuilds, 1);
      expect(builderBuilds, 1);
      expect(find.text('Counter: 50'), findsOneWidget);

      // Trigger signal update
      counter.value = 51;
      await tester.pumpAndSettle();

      // Parent should NOT rebuild, only the builder should!
      expect(parentBuilds, 1);
      expect(builderBuilds, 2);
      expect(find.text('Counter: 51'), findsOneWidget);
    });

    testWidgets(
        'handles high-frequency updates from multiple signals synchronously with exactly one rebuild',
        (tester) async {
      final signalA = signal(0);
      final signalB = signal(0);
      final signalC = signal(0);
      int builderBuilds = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SignalBuilder(
              builder: (context) {
                builderBuilds++;
                return Text(
                    'A: ${signalA.value}, B: ${signalB.value}, C: ${signalC.value}');
              },
            ),
          ),
        ),
      );

      expect(builderBuilds, 1);
      expect(find.text('A: 0, B: 0, C: 0'), findsOneWidget);

      // Mutate multiple signals rapidly/synchronously in a single frame
      signalA.value = 1;
      signalB.value = 2;
      signalC.value = 3;

      await tester.pumpAndSettle();

      // The builder should have coalesced all rapid updates into exactly 1 rebuild!
      expect(builderBuilds, 2);
      expect(find.text('A: 1, B: 2, C: 3'), findsOneWidget);
    });
  });
}
