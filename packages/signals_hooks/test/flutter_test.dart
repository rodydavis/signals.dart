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
          HookBuilder(
            builder: (context) {
              final state = useValueNotifierToSignal(notifier);
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('set value from notifier', (tester) async {
        final notifier = ValueNotifier(42);
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              final state = useValueNotifierToSignal(notifier);
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
        );

        notifier.value++;
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });

      testWidgets('set value from signal', (tester) async {
        final notifier = ValueNotifier(42);
        Signal<int>? state;
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              state ??= useValueNotifierToSignal(notifier);
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
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
          HookBuilder(
            builder: (context) {
              final state = useValueListenableToSignal(notifier);
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('set value from notifier', (tester) async {
        final notifier = ValueNotifier(42);
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              final state = useValueListenableToSignal(notifier);
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
        );

        notifier.value++;
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });
    });

    group('SignalHookWidget & SignalHookBuilder', () {
      testWidgets('implicitly tracks signal and supports hooks', (tester) async {
        final count = signal(0);
        late FocusNode focusNode;

        await tester.pumpWidget(
          SignalHookBuilder(
            builder: (context) {
              focusNode = useFocusNode();
              return Text('${count.value}', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(find.text('0'), findsOneWidget);
        expect(focusNode, isNotNull);

        count.value++;
        await tester.pumpAndSettle();

        expect(find.text('1'), findsOneWidget);
      });

      testWidgets('supports watch(context) explicitly on SignalHookWidget', (tester) async {
        final count = signal(42);

        await tester.pumpWidget(
          SignalHookBuilder(
            builder: (context) {
              final val = count.watch(context);
              return Text('$val', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(find.text('42'), findsOneWidget);

        count.value++;
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });
    });
  });
}
