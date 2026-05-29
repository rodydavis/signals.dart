import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_hooks/signals_hooks.dart';

// 1. Direct build method subclass
class NativeSignalHookWidget extends SignalHookWidget {
  const NativeSignalHookWidget({
    required this.counter,
    super.key,
  });

  final Signal<int> counter;

  @override
  Widget build(BuildContext context) {
    // 2. Direct hook use alongside implicit signal tracking:
    final focusNode = useFocusNode();
    assert(focusNode.toString().isNotEmpty);

    return Text(
      'Native: ${counter.value}',
      textDirection: TextDirection.ltr,
    );
  }
}

// 2. Dynamic branching test widget
class BranchingNativeSignalHookWidget extends SignalHookWidget {
  const BranchingNativeSignalHookWidget({
    required this.count1,
    required this.count2,
    required this.accessSecond,
    super.key,
  });

  final Signal<int> count1;
  final Signal<int> count2;
  final Signal<bool> accessSecond;

  @override
  Widget build(BuildContext context) {
    final val1 = count1.value;
    final val2 = accessSecond.value ? count2.value : 0;
    return Text(
      '$val1 - $val2',
      textDirection: TextDirection.ltr,
    );
  }
}

// 3. Backward compatibility widget (overriding buildWidget instead of build)
class LegacySignalHookWidget extends SignalHookWidget {
  const LegacySignalHookWidget({
    required this.counter,
    super.key,
  });

  final Signal<int> counter;

  @override
  Widget buildWidget(BuildContext context) {
    return Text(
      'Legacy: ${counter.value}',
      textDirection: TextDirection.ltr,
    );
  }
}

void main() {
  group('Native build Method in SignalHookWidget Tests', () {
    testWidgets(
        'implicitly tracks signal changes and supports hooks inside standard build method',
        (tester) async {
      final counter = signal(0);

      await tester.pumpWidget(
        NativeSignalHookWidget(counter: counter),
      );

      expect(find.text('Native: 0'), findsOneWidget);

      counter.value++;
      await tester.pumpAndSettle();

      expect(find.text('Native: 1'), findsOneWidget);
    });

    testWidgets(
        'SignalHookBuilder implicitly tracks signals inside standard builder callback',
        (tester) async {
      final counter = signal(10);

      await tester.pumpWidget(
        SignalHookBuilder(
          builder: (context) {
            final focusNode = useFocusNode();
            assert(focusNode.toString().isNotEmpty);
            return Text(
              'Builder: ${counter.value}',
              textDirection: TextDirection.ltr,
            );
          },
        ),
      );

      expect(find.text('Builder: 10'), findsOneWidget);

      counter.value = 20;
      await tester.pumpAndSettle();

      expect(find.text('Builder: 20'), findsOneWidget);
    });

    testWidgets(
        'unsubscribes from conditionally branched signals when no longer accessed',
        (tester) async {
      final count1 = signal(0);
      final count2 = signal(10);
      final accessSecond = signal(true);
      int buildCount = 0;

      await tester.pumpWidget(
        HookBuilder(
          builder: (context) {
            buildCount++;
            return BranchingNativeSignalHookWidget(
              count1: count1,
              count2: count2,
              accessSecond: accessSecond,
            );
          },
        ),
      );

      expect(find.text('0 - 10'), findsOneWidget);
      expect(buildCount, 1);

      // Rebuild with accessSecond set to false
      accessSecond.value = false;
      await tester.pumpAndSettle();

      expect(find.text('0 - 0'), findsOneWidget);

      // Mutating count2 should NOT trigger a rebuild/update now because it should be unsubscribed
      final currentBuildCount = buildCount;
      count2.value = 20;
      await tester.pumpAndSettle();

      expect(find.text('0 - 0'), findsOneWidget);
      expect(buildCount, currentBuildCount);
    });

    testWidgets(
        'backward compatibility: legacy widgets overriding buildWidget still work',
        (tester) async {
      final counter = signal(5);

      await tester.pumpWidget(
        LegacySignalHookWidget(counter: counter),
      );

      expect(find.text('Legacy: 5'), findsOneWidget);

      counter.value++;
      await tester.pumpAndSettle();

      expect(find.text('Legacy: 6'), findsOneWidget);
    });

    testWidgets(
        'SignalStatefulHookWidget implicitly tracks signals and supports hooks',
        (tester) async {
      final counter = signal(0);

      await tester.pumpWidget(
        MyStatefulHookWidget(counter: counter),
      );

      expect(find.text('StatefulHook: 0'), findsOneWidget);

      counter.value++;
      await tester.pumpAndSettle();

      expect(find.text('StatefulHook: 1'), findsOneWidget);
    });

    testWidgets(
        'useSignalProvider custom hook resolves signal from SignalProvider',
        (tester) async {
      final counter = signal(100);

      await tester.pumpWidget(
        SignalProvider<FlutterSignal<int>>(
          create: () => counter,
          child: const ProviderTestWidget(),
        ),
      );

      expect(find.text('ProviderValue: 100'), findsOneWidget);

      counter.value = 200;
      await tester.pumpAndSettle();

      expect(find.text('ProviderValue: 200'), findsOneWidget);
    });
  });
}

class MyStatefulHookWidget extends SignalStatefulHookWidget {
  const MyStatefulHookWidget({required this.counter, super.key});
  final Signal<int> counter;

  @override
  State<MyStatefulHookWidget> createState() => _MyStatefulHookWidgetState();
}

class _MyStatefulHookWidgetState extends State<MyStatefulHookWidget> {
  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    assert(focusNode.toString().isNotEmpty);
    return Text(
      'StatefulHook: ${widget.counter.value}',
      textDirection: TextDirection.ltr,
    );
  }
}

class ProviderTestWidget extends SignalHookWidget {
  const ProviderTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useSignalProvider<FlutterSignal<int>>()!;
    return Text(
      'ProviderValue: ${counter.value}',
      textDirection: TextDirection.ltr,
    );
  }
}
