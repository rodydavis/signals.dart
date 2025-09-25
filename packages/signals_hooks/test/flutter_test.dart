import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_hooks/signals_hooks.dart';

void main() {
  group('Flutter Signals Tests', () {
    group('useValueNotifierToSignal', () {
      testWidgets('get value', (tester) async {
        final notifier = ValueNotifier(42);
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final state = useValueNotifierToSignal(notifier);
            return Text('$state', textDirection: TextDirection.ltr);
          }),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('set value from notifier', (tester) async {
        final notifier = ValueNotifier(42);
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final state = useValueNotifierToSignal(notifier);
            return Text('$state', textDirection: TextDirection.ltr);
          }),
        );

        notifier.value++;
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });

      testWidgets('set value from signal', (tester) async {
        final notifier = ValueNotifier(42);
        Signal<int>? state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state ??= useValueNotifierToSignal(notifier);
            return Text('$state', textDirection: TextDirection.ltr);
          }),
        );

        state!.value++;
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
        expect(notifier.value, 43);
      });
    });

    group('useValueListenableToSignal', () {
      testWidgets('get value', (tester) async {
        final notifier = ValueNotifier(42);
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final state = useValueListenableToSignal(notifier);
            return Text('$state', textDirection: TextDirection.ltr);
          }),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('set value from notifier', (tester) async {
        final notifier = ValueNotifier(42);
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final state = useValueListenableToSignal(notifier);
            return Text('$state', textDirection: TextDirection.ltr);
          }),
        );

        notifier.value++;
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });
    });
  });
}
