import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  setUp(() {
    SignalsObserver.instance = null;
  });

  group('.watch(context) Extension API', () {
    testWidgets('StatelessWidget watch rebuilds on change', (tester) async {
      final count = signal(0);
      int buildCount = 0;

      final widget = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              buildCount++;
              // ignore: deprecated_member_use_from_same_package
              final val = count.watch(context);
              return Text('Count: $val');
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(buildCount, 1);
      expect(find.text('Count: 0'), findsOneWidget);

      // Mutate signal
      count.value = 10;
      await tester.pumpAndSettle();

      expect(buildCount, 2);
      expect(find.text('Count: 10'), findsOneWidget);
    });

    testWidgets('De-duplicates multiple reads of the same signal on same context', (tester) async {
      final count = signal(5);
      int buildCount = 0;

      final widget = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              buildCount++;
              // ignore: deprecated_member_use_from_same_package
              final val1 = count.watch(context);
              // ignore: deprecated_member_use_from_same_package
              final val2 = count.watch(context);
              return Text('Sum: ${val1 + val2}');
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(buildCount, 1);
      expect(find.text('Sum: 10'), findsOneWidget);

      // Mutate
      count.value = 10;
      await tester.pumpAndSettle();

      // Should rebuild exactly once
      expect(buildCount, 2);
      expect(find.text('Sum: 20'), findsOneWidget);
    });

    testWidgets('Multiple different signals watched on the same BuildContext', (tester) async {
      final sigA = signal('Hello');
      final sigB = signal('World');
      int buildCount = 0;

      final widget = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              buildCount++;
              // ignore: deprecated_member_use_from_same_package
              final valA = sigA.watch(context);
              // ignore: deprecated_member_use_from_same_package
              final valB = sigB.watch(context);
              return Text('$valA $valB');
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(buildCount, 1);
      expect(find.text('Hello World'), findsOneWidget);

      // Mutate A
      sigA.value = 'Hi';
      await tester.pumpAndSettle();
      expect(buildCount, 2);
      expect(find.text('Hi World'), findsOneWidget);

      // Mutate B
      sigB.value = 'Flutter';
      await tester.pumpAndSettle();
      expect(buildCount, 3);
      expect(find.text('Hi Flutter'), findsOneWidget);

      // Mutate both synchronously - should coalesce into a single rebuild
      sigA.value = 'Hey';
      sigB.value = 'Signals';
      await tester.pumpAndSettle();
      expect(buildCount, 4);
      expect(find.text('Hey Signals'), findsOneWidget);
    });

    testWidgets('Dynamic branching is persistent for .watch(context)', (tester) async {
      // NOTE: Unlike SignalWidget which dynamically prunes subscriptions per-frame,
      // .watch(context) is a persistent subscription on the Element lifecycle.
      // A signal ever watched remains watched until the element is unmounted.
      final showA = signal(true);
      final sigA = signal('A');
      final sigB = signal('B');
      int buildCount = 0;

      final widget = MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              buildCount++;
              // ignore: deprecated_member_use_from_same_package
              final check = showA.watch(context);
              if (check) {
                // ignore: deprecated_member_use_from_same_package
                return Text('Value: ${sigA.watch(context)}');
              } else {
                // ignore: deprecated_member_use_from_same_package
                return Text('Value: ${sigB.watch(context)}');
              }
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(buildCount, 1);
      expect(find.text('Value: A'), findsOneWidget);

      // Mutate B while showA is true: since sigB hasn't been watched yet on this context,
      // no rebuild is triggered.
      sigB.value = 'NewB';
      await tester.pumpAndSettle();
      expect(buildCount, 1);

      // Switch branch to false, causing both showA and sigB to be watched.
      showA.value = false;
      await tester.pumpAndSettle();
      expect(buildCount, 2);
      expect(find.text('Value: NewB'), findsOneWidget);

      // Mutating sigA (which was watched in the first frame) will still trigger a rebuild
      // because standard .watch(context) subscriptions are persistent on the Element.
      sigA.value = 'NewA';
      await tester.pumpAndSettle();
      expect(buildCount, 3);
    });

    testWidgets('unwatch(context) programmatically terminates subscription', (tester) async {
      final count = signal(0);
      int buildCount = 0;
      bool doWatch = true;
      final builderKey = GlobalKey();

      final widget = MaterialApp(
        home: Scaffold(
          body: Builder(
            key: builderKey,
            builder: (context) {
              buildCount++;
              if (doWatch) {
                // ignore: deprecated_member_use_from_same_package
                return Text('Value: ${count.watch(context)}');
              } else {
                return const Text('Unwatched');
              }
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(buildCount, 1);
      expect(find.text('Value: 0'), findsOneWidget);

      // Update signal
      count.value = 1;
      await tester.pumpAndSettle();
      expect(buildCount, 2);
      expect(find.text('Value: 1'), findsOneWidget);

      // Unwatch manually using the correct targeted build element via GlobalKey
      final element = builderKey.currentContext!;
      doWatch = false;
      // ignore: deprecated_member_use_from_same_package
      count.unwatch(element);

      // Update signal again - should NOT trigger rebuild since subscription is removed
      count.value = 2;
      await tester.pumpAndSettle();
      expect(buildCount, 2); // Build count remains 2!
    });

    testWidgets('unmounting widget cleans up Expando entries properly', (tester) async {
      final sig = signal('Data');
      bool showChild = true;
      int childBuilds = 0;

      final widget = StatefulBuilder(
        builder: (context, setState) {
          return MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  if (showChild)
                    Builder(
                      key: const ValueKey('child'),
                      builder: (context) {
                        childBuilds++;
                        // ignore: deprecated_member_use_from_same_package
                        return Text('Child: ${sig.watch(context)}');
                      },
                    ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showChild = !showChild;
                      });
                    },
                    child: const Text('Toggle'),
                  ),
                ],
              ),
            ),
          );
        },
      );

      await tester.pumpWidget(widget);
      expect(childBuilds, 1);
      expect(find.text('Child: Data'), findsOneWidget);

      // Mutate signal to check it responds
      sig.value = 'Updated';
      await tester.pumpAndSettle();
      expect(childBuilds, 2);
      expect(find.text('Child: Updated'), findsOneWidget);

      // Unmount the child
      await tester.tap(find.text('Toggle'));
      await tester.pumpAndSettle();

      expect(find.text('Child: Updated'), findsNothing);

      // Mutate signal again - should not crash or trigger any callback calls
      sig.value = 'Final';
      await tester.pumpAndSettle();
      expect(childBuilds, 2); // Child did not build again
    });
  });
}
