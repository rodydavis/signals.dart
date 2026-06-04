import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_devtools_extension/src/nodes_state.dart';
import 'package:signals_devtools_extension/src/widget/updates_view.dart';

void main() {
  setUp(() {
    updates.value = [];
    isPaused.value = false;
    FlutterError.onError = (details) {
      print('FLUTTER ERROR: ${details.exception}\n${details.stack}');
    };
  });

  testWidgets('Simple text test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Hello World'),
        ),
      ),
    );
    expect(find.text('Hello World'), findsOneWidget);
  });

  testWidgets('UpdatesView renders empty placeholder when there are no updates',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UpdatesView(),
        ),
      ),
    );

    final dynamic exception = tester.takeException();
    if (exception != null) {
      print('CAPTURED EXCEPTION: $exception');
      if (exception is Error) {
        print('STACK TRACE: ${exception.stackTrace}');
      }
    }

    // Let the widget render
    await tester.pump();

    // Verify empty state placeholders
    expect(find.text('No updates recorded yet'), findsOneWidget);
    expect(find.text('Interact with your signals to see live changes.'),
        findsOneWidget);
    expect(find.byIcon(Icons.analytics_outlined), findsOneWidget);
  });

  testWidgets('UpdatesView renders recorded updates and correct stats',
      (WidgetTester tester) async {
    final now = DateTime.now();

    // Add dummy updates:
    // 1. A signal update: id 10, value change "A" -> "B"
    // 2. An effect called update: id 20
    updates.value = [
      SignalUpdate(
        type: 'update',
        signalType: 'signal',
        signalName: 'user_count',
        signalId: 10,
        prevValue: '10',
        newValue: '11',
        timestamp: now,
      ),
      SignalUpdate(
        type: 'effect',
        signalType: 'effect',
        signalName: 'logger_effect',
        signalId: 20,
        timestamp: now.add(const Duration(milliseconds: 100)),
      ),
    ];

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UpdatesView(),
        ),
      ),
    );

    await tester.pump();

    // Verify stats badges
    expect(find.text('Updates: '), findsOneWidget);
    expect(find.text('Signals: '), findsOneWidget);
    expect(find.text('2'),
        findsNWidgets(2)); // both updates and unique signals counts are 2

    // Verify card contents
    expect(find.text('user_count (id: 10)'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.text('11'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);

    expect(find.text('logger_effect (id: 20)'), findsOneWidget);
    expect(find.text('Effect'), findsOneWidget);
  });

  testWidgets('UpdatesView groups duplicate consecutive updates correctly',
      (WidgetTester tester) async {
    final now = DateTime.now();

    // Add multiple duplicate updates consecutively
    updates.value = [
      SignalUpdate(
        type: 'update',
        signalType: 'signal',
        signalName: 'counter',
        signalId: 1,
        prevValue: '0',
        newValue: '1',
        timestamp: now,
      ),
      SignalUpdate(
        type: 'update',
        signalType: 'signal',
        signalName: 'counter',
        signalId: 1,
        prevValue: '0',
        newValue: '1',
        timestamp: now.add(const Duration(milliseconds: 50)),
      ),
      SignalUpdate(
        type: 'update',
        signalType: 'signal',
        signalName: 'counter',
        signalId: 1,
        prevValue: '0',
        newValue: '1',
        timestamp: now.add(const Duration(milliseconds: 100)),
      ),
    ];

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UpdatesView(),
        ),
      ),
    );

    await tester.pump();

    // Due to grouping of consecutive identical updates, we should only see 1 card
    // and a "x3" grouping badge.
    expect(find.text('counter (id: 1)'), findsOneWidget);
    expect(find.text('x3'), findsOneWidget);
  });
}
