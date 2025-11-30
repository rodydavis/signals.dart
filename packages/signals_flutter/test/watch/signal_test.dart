import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:signals_flutter/signals_flutter.dart';

import '../utils/counter.dart';

void main() {
  
  group('.watch()', () {
    testWidgets('signal', (tester) async {
      int calls = 0;
      final widget = Counter(
        watch: false,
        createSource: (context) => signal(0),
        callback: () => calls++,
      );

      await tester.pumpWidget(widget);

      expect(calls, 1);
      expect(find.text('Count: 0'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(calls, 2);
      expect(find.text('Count: 1'), findsOneWidget);
    });
  });

  group('Watch', () {
    testWidgets('signal', (tester) async {
      int calls = 0;
      final widget = Counter(
        watch: true,
        createSource: (context) => signal(0),
        callback: () => calls++,
      );

      await tester.pumpWidget(widget);

      expect(calls, 1);
      expect(find.text('Count: 0'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(calls, 2);
      expect(find.text('Count: 1'), findsOneWidget);
    });

    group('Watch.builder', () {
      testWidgets('signal', (tester) async {
        int calls = 0;
        final widget = Counter(
          watch: true,
          builder: true,
          createSource: (context) => signal(0),
          callback: () => calls++,
        );

        await tester.pumpWidget(widget);

        expect(calls, 1);
        expect(find.text('Count: 0'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        expect(calls, 2);
        expect(find.text('Count: 1'), findsOneWidget);
      });
    });
  });
}
