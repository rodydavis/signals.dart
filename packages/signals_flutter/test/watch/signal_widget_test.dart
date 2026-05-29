// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

// Test stateless widget
class StatelessCounterWidget extends SignalWidget {
  final Signal<int> counter;
  final VoidCallback onBuild;

  const StatelessCounterWidget({
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

// Test stateful widget
class StatefulCounterWidget extends SignalStatefulWidget {
  final Signal<int> counter;
  final VoidCallback onBuild;

  const StatefulCounterWidget({
    super.key,
    required this.counter,
    required this.onBuild,
  });

  @override
  State<StatefulCounterWidget> createState() => _StatefulCounterWidgetState();
}

class _StatefulCounterWidgetState extends State<StatefulCounterWidget> {
  @override
  Widget build(BuildContext context) {
    widget.onBuild();
    return Text('Count: ${widget.counter.value}');
  }
}

// Test branching widget
class BranchingWidget extends SignalWidget {
  final Signal<bool> showB;
  final Signal<int> signalA;
  final Signal<int> signalB;
  final VoidCallback onBuild;

  const BranchingWidget({
    super.key,
    required this.showB,
    required this.signalA,
    required this.signalB,
    required this.onBuild,
  });

  @override
  Widget build(BuildContext context) {
    onBuild();
    if (showB.value) {
      return Text('Value: ${signalB.value}');
    } else {
      return Text('Value: ${signalA.value}');
    }
  }
}

class StatefulBranchingWidget extends SignalStatefulWidget {
  final Signal<bool> showB;
  final Signal<int> signalA;
  final Signal<int> signalB;
  final VoidCallback onBuild;

  const StatefulBranchingWidget({
    super.key,
    required this.showB,
    required this.signalA,
    required this.signalB,
    required this.onBuild,
  });

  @override
  State<StatefulBranchingWidget> createState() =>
      _StatefulBranchingWidgetState();
}

class _StatefulBranchingWidgetState extends State<StatefulBranchingWidget> {
  @override
  Widget build(BuildContext context) {
    widget.onBuild();
    if (widget.showB.value) {
      return Text('Value: ${widget.signalB.value}');
    } else {
      return Text('Value: ${widget.signalA.value}');
    }
  }
}

void main() {
  setUp(() {
    SignalsObserver.instance = null;
  });

  group('SignalWidget (Stateless)', () {
    testWidgets('automatically tracks and rebuilds on signal change',
        (tester) async {
      final counter = signal(10);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatelessCounterWidget(
              counter: counter,
              onBuild: () => buildCount++,
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Count: 10'), findsOneWidget);

      counter.value = 11;
      await tester.pumpAndSettle();

      expect(buildCount, 2);
      expect(find.text('Count: 11'), findsOneWidget);
    });
  });

  group('SignalStatefulWidget (Stateful)', () {
    testWidgets(
        'automatically tracks and rebuilds stateful widget build on signal change',
        (tester) async {
      final counter = signal(20);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulCounterWidget(
              counter: counter,
              onBuild: () => buildCount++,
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Count: 20'), findsOneWidget);

      counter.value = 21;
      await tester.pumpAndSettle();

      expect(buildCount, 2);
      expect(find.text('Count: 21'), findsOneWidget);
    });

    testWidgets(
        'dynamic branching in stateful widgets cleans up and updates dependencies dynamically',
        (tester) async {
      final showB = signal(false);
      final signalA = signal(1);
      final signalB = signal(100);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBranchingWidget(
              showB: showB,
              signalA: signalA,
              signalB: signalB,
              onBuild: () => buildCount++,
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Value: 1'), findsOneWidget);

      // Updating signalB should NOT rebuild, because we show A (showB is false)
      signalB.value = 101;
      await tester.pumpAndSettle();
      expect(buildCount, 1);

      // Updating signalA SHOULD rebuild
      signalA.value = 2;
      await tester.pumpAndSettle();
      expect(buildCount, 2);
      expect(find.text('Value: 2'), findsOneWidget);

      // Change showB to true, should rebuild and show signalB
      showB.value = true;
      await tester.pumpAndSettle();
      expect(buildCount, 3);
      expect(find.text('Value: 101'), findsOneWidget);

      // Now updating signalA should NOT rebuild
      signalA.value = 3;
      await tester.pumpAndSettle();
      expect(buildCount, 3);

      // Updating signalB SHOULD rebuild
      signalB.value = 102;
      await tester.pumpAndSettle();
      expect(buildCount, 4);
      expect(find.text('Value: 102'), findsOneWidget);
    });
  });

  group('Dynamic Branching', () {
    testWidgets('correctly cleans up and updates dependencies dynamically',
        (tester) async {
      final showB = signal(false);
      final signalA = signal(1);
      final signalB = signal(100);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BranchingWidget(
              showB: showB,
              signalA: signalA,
              signalB: signalB,
              onBuild: () => buildCount++,
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Value: 1'), findsOneWidget);

      // Updating signalB should NOT rebuild, because we show A (showB is false)
      signalB.value = 101;
      await tester.pumpAndSettle();
      expect(buildCount, 1); // No rebuild

      // Updating signalA SHOULD rebuild
      signalA.value = 2;
      await tester.pumpAndSettle();
      expect(buildCount, 2);
      expect(find.text('Value: 2'), findsOneWidget);

      // Change showB to true, should rebuild and show signalB
      showB.value = true;
      await tester.pumpAndSettle();
      expect(buildCount, 3);
      expect(find.text('Value: 101'), findsOneWidget);

      // Now updating signalA should NOT rebuild
      signalA.value = 3;
      await tester.pumpAndSettle();
      expect(buildCount, 3); // No rebuild

      // Updating signalB SHOULD rebuild
      signalB.value = 102;
      await tester.pumpAndSettle();
      expect(buildCount, 4);
      expect(find.text('Value: 102'), findsOneWidget);
    });
  });

  group('Hot Reload Compatibility', () {
    testWidgets('SignalWidget maintains perfect reactivity after hot reload',
        (tester) async {
      final counter = signal(50);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatelessCounterWidget(
              counter: counter,
              onBuild: () => buildCount++,
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Count: 50'), findsOneWidget);

      // Mutate signal before hot reload
      counter.value = 51;
      await tester.pumpAndSettle();
      expect(buildCount, 2);
      expect(find.text('Count: 51'), findsOneWidget);

      // Simulate a hot reload by reassembling the element directly
      tester.element(find.byType(StatelessCounterWidget)).reassemble();
      await tester.pumpAndSettle();

      // reassemble schedules a rebuild, so buildCount increments
      expect(buildCount, 3);
      expect(find.text('Count: 51'), findsOneWidget);

      // Mutate signal AFTER hot reload: it must rebuild and remain fully reactive!
      counter.value = 52;
      await tester.pumpAndSettle();
      expect(buildCount, 4);
      expect(find.text('Count: 52'), findsOneWidget);
    });

    testWidgets(
        'SignalStatefulWidget maintains perfect reactivity after hot reload',
        (tester) async {
      final counter = signal(60);
      int buildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulCounterWidget(
              counter: counter,
              onBuild: () => buildCount++,
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Count: 60'), findsOneWidget);

      // Mutate signal before hot reload
      counter.value = 61;
      await tester.pumpAndSettle();
      expect(buildCount, 2);
      expect(find.text('Count: 61'), findsOneWidget);

      // Simulate a hot reload by reassembling the element directly
      tester.element(find.byType(StatefulCounterWidget)).reassemble();
      await tester.pumpAndSettle();

      expect(buildCount, 3);
      expect(find.text('Count: 61'), findsOneWidget);

      // Mutate signal AFTER hot reload: it must rebuild and remain fully reactive!
      counter.value = 62;
      await tester.pumpAndSettle();
      expect(buildCount, 4);
      expect(find.text('Count: 62'), findsOneWidget);
    });
  });
}
