import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:signals_flutter/signals_flutter.dart';

import '../utils/mixin_counter.dart';

void main() {
  SignalsObserver.instance = null;

  group('SignalsMixin', () {
    testWidgets(
        'createSignal/createComputed return FlutterSignal/FlutterComputed',
        (tester) async {
      final key = GlobalKey<MixinCounterState>();

      final widget = MixinCounter(
        key: key,
        createSource: (context, self) => self.createSignal(4),
        createReader: (context, self) =>
            self.createComputed(() => self.source.value * 2),
      );

      await tester.pumpWidget(widget);

      expect(key.currentState!.source, isInstanceOf<FlutterSignal<int>>());
      expect(key.currentState!.display, isInstanceOf<FlutterComputed<int>>());
    });

    testWidgets('disposes created signals when widget is unmounted',
        (tester) async {
      final key = GlobalKey<MixinCounterState>();

      final widget = MixinCounter(
        key: key,
        createSource: (context, self) => self.createSignal(4),
        createReader: (context, self) =>
            self.createComputed(() => self.source.value * 2),
      );

      await tester.pumpWidget(widget);

      expect(find.text('Count: 8'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('Count: 10'), findsOneWidget);

      final source = key.currentState!.source;
      final display = key.currentState!.display;

      // unmount widget
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();

      expect(source.disposed, isTrue);
      expect(display.disposed, isTrue);
    });
  });
}
