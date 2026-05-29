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

      testWidgets('supports signal options', (tester) async {
        final notifier = ValueNotifier(42);
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              final state = useValueNotifierToSignal(
                notifier,
                keys: const [],
                options:
                    SignalOptions(name: 'notifierSignal', autoDispose: true),
              );
              return Text(
                '${state.globalId} - ${state.name}',
                textDirection: TextDirection.ltr,
              );
            },
          ),
        );
        expect(find.textContaining('notifierSignal'), findsOneWidget);
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

      testWidgets('supports signal options', (tester) async {
        final notifier = ValueNotifier(42);
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              final state = useValueListenableToSignal(
                notifier,
                keys: const [],
                options:
                    SignalOptions(name: 'listenableSignal', autoDispose: true),
              );
              return Text(
                '${state.globalId} - ${state.name}',
                textDirection: TextDirection.ltr,
              );
            },
          ),
        );
        expect(find.textContaining('listenableSignal'), findsOneWidget);
      });
    });

    group('SignalHookWidget & SignalHookBuilder', () {
      testWidgets('implicitly tracks signal and supports hooks',
          (tester) async {
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

      testWidgets('supports watch(context) explicitly on SignalHookWidget',
          (tester) async {
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

      testWidgets(
          'removes subscription when a signal is no longer accessed on rebuild',
          (tester) async {
        final count1 = signal(0);
        final count2 = signal(10);
        final accessSecond = signal(true);
        int buildCount = 0;

        await tester.pumpWidget(
          SignalHookBuilder(
            builder: (context) {
              buildCount++;
              final val1 = count1.value;
              final val2 = accessSecond.value ? count2.value : 0;
              return Text('$val1 - $val2', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(find.text('0 - 10'), findsOneWidget);
        expect(buildCount, 1);

        // Rebuild and stop accessing count2
        accessSecond.value = false;
        await tester.pumpAndSettle();
        expect(find.text('0 - 0'), findsOneWidget);
        expect(buildCount, 2);

        // Mutating count2 should NOT trigger a rebuild now because it should be unsubscribed
        count2.value = 20;
        await tester.pumpAndSettle();
        expect(find.text('0 - 0'), findsOneWidget);
        expect(buildCount, 2); // Still 2!
      });
    });

    group('SignalHook didUpdateHook', () {
      testWidgets('unsubscribes from old target and subscribes to new target',
          (tester) async {
        final targetA = signal(1);
        final targetB = signal(2);
        final currentTarget = signal(targetA);
        int buildCount = 0;

        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              buildCount++;
              final s = useExistingSignal(currentTarget.watch(context));
              return Text('${s.value}', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(find.text('1'), findsOneWidget);
        expect(buildCount, 1);

        // Mutate targetA to check subscription is active
        targetA.value = 10;
        await tester.pumpAndSettle();
        expect(find.text('10'), findsOneWidget);
        expect(buildCount, 2);

        // Swap target to targetB
        currentTarget.value = targetB;
        await tester.pumpAndSettle();
        expect(find.text('2'), findsOneWidget);
        expect(buildCount, 3);

        // Mutating targetA now should NOT rebuild because it was unsubscribed
        targetA.value = 100;
        await tester.pumpAndSettle();
        expect(find.text('2'), findsOneWidget);
        expect(buildCount, 3); // Still 3!

        // Mutating targetB should rebuild
        targetB.value = 20;
        await tester.pumpAndSettle();
        expect(find.text('20'), findsOneWidget);
        expect(buildCount, 4);
      });

      testWidgets('exercises debugValue and debugLabel', (tester) async {
        final s = signal(10, options: SignalOptions(name: 'my-sig'));
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              useExistingSignal(s);
              return Container();
            },
          ),
        );
        final element = tester.element(find.byType(HookBuilder));
        final diagnostics = element.toStringDeep();
        expect(diagnostics, contains('FlutterSignal<dynamic>'));
        expect(diagnostics, contains('10'));
      });
    });
  });
}
