import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  group('SignalEffect', () {
    testWidgets('triggers callback on mount and signal changes',
        (tester) async {
      final count = signal(0);
      int callbackCalls = 0;
      int? lastValue;

      final widget = MaterialApp(
        home: Scaffold(
          body: SignalEffect(
            callback: (context) {
              callbackCalls++;
              lastValue = count.value;
            },
            child: const Text('Child Widget'),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Initial execution on mount
      expect(callbackCalls, 1);
      expect(lastValue, 0);
      expect(find.text('Child Widget'), findsOneWidget);

      // Mutate signal
      count.value = 10;
      await tester.pump();

      // Should run callback again
      expect(callbackCalls, 2);
      expect(lastValue, 10);

      // Mutate signal again
      count.value = 20;
      await tester.pump();

      expect(callbackCalls, 3);
      expect(lastValue, 20);
    });

    testWidgets('disposes effect when widget is removed from tree',
        (tester) async {
      final count = signal(0);
      int callbackCalls = 0;

      final widget = MaterialApp(
        home: Scaffold(
          body: SignalEffect(
            callback: (context) {
              callbackCalls++;
              count.value; // Track
            },
            child: const Text('Child Widget'),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(callbackCalls, 1);

      // Mutate to verify it is active
      count.value = 1;
      await tester.pump();
      expect(callbackCalls, 2);

      // Unmount the SignalEffect widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Text('No SignalEffect'),
          ),
        ),
      );

      // Mutate again, should NOT trigger callback because it is disposed
      count.value = 2;
      await tester.pump();
      expect(callbackCalls, 2); // Still 2
    });

    testWidgets(
        'handles didUpdateWidget by disposing old effect and starting new one',
        (tester) async {
      final count = signal(0);
      int callbackCallsA = 0;
      int callbackCallsB = 0;

      final currentCallback = signal<void Function(BuildContext)>((ctx) {
        callbackCallsA++;
        count.value;
      });

      final widget = MaterialApp(
        home: Scaffold(
          body: SignalBuilder(
            builder: (context) => SignalEffect(
              callback: currentCallback.value,
              child: const Text('Helper Child'),
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Initial execution of callback A on mount
      expect(callbackCallsA, 1);
      expect(callbackCallsB, 0);

      // Mutate signal, should trigger callback A
      count.value = 5;
      await tester.pump();
      expect(callbackCallsA, 2);
      expect(callbackCallsB, 0);

      // Swap to callback B
      currentCallback.value = (ctx) {
        callbackCallsB++;
        count.value;
      };
      await tester.pump();

      // Initial execution of new callback B on mount/update
      expect(callbackCallsA, 2); // A stopped
      expect(callbackCallsB, 1); // B started

      // Mutate signal again, should trigger callback B but NOT callback A
      count.value = 10;
      await tester.pump();
      expect(callbackCallsA, 2); // Stays at 2
      expect(callbackCallsB, 2); // Increments to 2
    });

    testWidgets('SignalListener type alias behaves exactly as SignalEffect',
        (tester) async {
      final count = signal(0);
      int callbackCalls = 0;

      final widget = MaterialApp(
        home: Scaffold(
          body: SignalListener(
            callback: (context) {
              callbackCalls++;
              count.value;
            },
            child: const Text('Listener Child'),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(callbackCalls, 1);

      count.value = 100;
      await tester.pump();
      expect(callbackCalls, 2);
    });

    testWidgets('SignalEffect supports optional cleanup return',
        (tester) async {
      final count = signal(0);
      int callbackCalls = 0;
      int cleanupCalls = 0;

      final widget = MaterialApp(
        home: Scaffold(
          body: SignalEffect(
            callback: (context) {
              callbackCalls++;
              count.value; // Track dependency
              return () {
                cleanupCalls++;
              };
            },
            child: const Text('Cleanup Child'),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(callbackCalls, 1);
      expect(cleanupCalls, 0);

      // Mutate to trigger re-run and run previous cleanup
      count.value = 10;
      await tester.pump();
      expect(callbackCalls, 2);
      expect(cleanupCalls, 1);

      // Unmount the widget to trigger final cleanup
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Text('Unmounted'),
          ),
        ),
      );
      expect(cleanupCalls, 2);
    });
  });
}
