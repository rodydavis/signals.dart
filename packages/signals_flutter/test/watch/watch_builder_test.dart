import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  setUp(() {
    SignalsObserver.instance = null;
  });

  group('WatchBuilder (Deprecated)', () {
    testWidgets('automatically rebuilds when watched signals mutate',
        (tester) async {
      final counter = signal(0);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WatchBuilder(
              builder: (context, child) {
                buildCount++;
                // ignore: deprecated_member_use_from_same_package
                return Text('Count: ${counter.value}');
              },
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Count: 0'), findsOneWidget);

      counter.value = 1;
      await tester.pumpAndSettle();

      expect(buildCount, 2);
      expect(find.text('Count: 1'), findsOneWidget);
    });

    testWidgets('correctly respects passing down cached child', (tester) async {
      final counter = signal(10);
      int childBuilds = 0;
      int parentBuilds = 0;

      final cachedChild = Builder(
        builder: (context) {
          childBuilds++;
          return const Text('Static Child');
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WatchBuilder(
              child: cachedChild,
              builder: (context, child) {
                parentBuilds++;
                // ignore: deprecated_member_use_from_same_package
                return Column(
                  children: [
                    Text('Count: ${counter.value}'),
                    child!,
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(parentBuilds, 1);
      expect(childBuilds, 1);
      expect(find.text('Count: 10'), findsOneWidget);
      expect(find.text('Static Child'), findsOneWidget);

      counter.value = 11;
      await tester.pumpAndSettle();

      // Parent rebuilds, but child is cached and should NOT build again
      expect(parentBuilds, 2);
      expect(childBuilds, 1);
      expect(find.text('Count: 11'), findsOneWidget);
    });

    testWidgets('supports explicit dependencies list and debugLabel',
        (tester) async {
      final dependencySignal = signal(100);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WatchBuilder(
              debugLabel: 'custom_watch_builder',
              dependencies: [dependencySignal],
              builder: (context, child) {
                buildCount++;
                return Text('Value: ${dependencySignal.peek()}');
              },
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Value: 100'), findsOneWidget);

      // Trigger dependency update
      dependencySignal.value = 200;
      await tester.pumpAndSettle();

      expect(buildCount, 2);
      expect(find.text('Value: 200'), findsOneWidget);
    });
  });
}
