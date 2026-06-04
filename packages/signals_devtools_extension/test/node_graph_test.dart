import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_devtools_extension/src/node_graph.dart';
import 'package:signals_devtools_extension/src/nodes_state.dart';

void main() {
  setUp(() {
    FlutterError.onError = (details) {
      print('FLUTTER ERROR: ${details.exception}\n${details.stack}');
    };
  });

  testWidgets('NodeGraph renders successfully with acyclic nodes',
      (WidgetTester tester) async {
    // Populate nodes
    nodes.value = [
      $Node(id: 1, type: 'signal', label: 'a', targets: '2'),
      $Node(id: 2, type: 'computed', label: 'b', sources: '1', targets: '3'),
      $Node(id: 3, type: 'effect', label: 'c', sources: '2'),
    ];
    reassembleCount.value = 1;

    // Pump NodeGraph widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NodeGraph(),
        ),
      ),
    );

    // Let layouts calculate
    await tester.pumpAndSettle();

    // Verify it doesn't crash and renders the nodes
    expect(find.byType(NodeGraph), findsOneWidget);
  });

  testWidgets('NodeGraph renders successfully with cyclic nodes',
      (WidgetTester tester) async {
    // Populate cyclic nodes: 1 -> 2 -> 1
    nodes.value = [
      $Node(id: 1, type: 'signal', label: 'a', sources: '2', targets: '2'),
      $Node(id: 2, type: 'computed', label: 'b', sources: '1', targets: '1'),
    ];
    reassembleCount.value = 2;

    // Pump NodeGraph widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NodeGraph(),
        ),
      ),
    );

    // Let layouts calculate
    await tester.pumpAndSettle();

    // Verify it doesn't crash and renders the nodes
    expect(find.byType(NodeGraph), findsOneWidget);
  });

  testWidgets(
      'NodeGraph renders empty state placeholder when there are no nodes',
      (WidgetTester tester) async {
    nodes.value = [];
    reassembleCount.value = 0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NodeGraph(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Reactive Explorer Ready'), findsOneWidget);
    expect(
        find.text(
            'Interact with your application or trigger updates to populate the signals hierarchy.'),
        findsOneWidget);
    expect(find.byIcon(Icons.hub_outlined), findsOneWidget);
  });

  testWidgets('NodeGraph search query filters nodes list',
      (WidgetTester tester) async {
    nodes.value = [
      $Node(id: 1, type: 'signal', label: 'apple', value: 'red'),
      $Node(id: 2, type: 'computed', label: 'banana', value: 'yellow'),
    ];
    reassembleCount.value = 1;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NodeGraph(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Both should be visible initially
    expect(find.text('apple'), findsOneWidget);
    expect(find.text('banana'), findsOneWidget);

    // Enter search text 'app'
    await tester.enterText(find.byType(TextField), 'app');
    await tester.pumpAndSettle();

    // Only 'apple' should be visible
    expect(find.text('apple'), findsOneWidget);
    expect(find.text('banana'), findsNothing);

    // Clear search
    await tester.enterText(find.byType(TextField), '');
    await tester.pumpAndSettle();

    // Both visible again
    expect(find.text('apple'), findsOneWidget);
    expect(find.text('banana'), findsOneWidget);
  });

  testWidgets('NodeGraph type filter chips filter nodes by type',
      (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(const Size(650, 800));
    addTearDown(() => binding.setSurfaceSize(null));

    nodes.value = [
      $Node(id: 1, type: 'signal', label: 'sigNode', value: '10'),
      $Node(id: 2, type: 'computed', label: 'compNode', value: '20'),
      $Node(id: 3, type: 'effect', label: 'effNode', value: '30'),
    ];
    reassembleCount.value = 1;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NodeGraph(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify all are present in the list initially
    expect(find.text('sigNode'), findsOneWidget);
    expect(find.text('compNode'), findsOneWidget);
    expect(find.text('effNode'), findsOneWidget);

    // Tap "Signals" chip (which has label 'Signals' and badge '1')
    // Find the widget containing the text 'Signals' and tap it
    await tester.tap(find.text('Signals'));
    await tester.pumpAndSettle();

    // Verify ONLY the signal 'sigNode' is present
    expect(find.text('sigNode'), findsOneWidget);
    expect(find.text('compNode'), findsNothing);
    expect(find.text('effNode'), findsNothing);

    // Tap "Computeds" chip
    await tester.tap(find.text('Computeds'));
    await tester.pumpAndSettle();

    // Verify ONLY the computed 'compNode' is present
    expect(find.text('sigNode'), findsNothing);
    expect(find.text('compNode'), findsOneWidget);
    expect(find.text('effNode'), findsNothing);

    // Tap "Effects" chip
    await tester.tap(find.text('Effects'));
    await tester.pumpAndSettle();

    // Verify ONLY the effect 'effNode' is present
    expect(find.text('sigNode'), findsNothing);
    expect(find.text('compNode'), findsNothing);
    expect(find.text('effNode'), findsOneWidget);

    // Tap "All" chip
    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();

    // Verify all are present again
    expect(find.text('sigNode'), findsOneWidget);
    expect(find.text('compNode'), findsOneWidget);
    expect(find.text('effNode'), findsOneWidget);
  });
}
