import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../utils/mixin_counter.dart';

class FullMixinWidget extends StatefulWidget {
  final GlobalKey<FullMixinWidgetState> stateKey;
  const FullMixinWidget({required this.stateKey}) : super(key: stateKey);

  @override
  State<FullMixinWidget> createState() => FullMixinWidgetState();
}

class FullMixinWidgetState extends State<FullMixinWidget> with SignalsMixin {
  late final sSignal = createSignal(1);
  late final sFuture = createFutureSignal(() => Future.value(2));
  late final sStream = createStreamSignal(() => Stream.value(3));
  late final sAsync = createAsyncSignal(AsyncState.data(4));
  late final sComputedFrom =
      createComputedFrom<int, int>([sSignal], (args) => Future.value(5));
  late final sComputedAsync = createComputedAsync(() => Future.value(6));
  late final sList = createListSignal([7]);
  late final sSet = createSetSignal({8});
  late final sQueue = createQueueSignal(Queue.from([9]));
  late final sMap = createMapSignal({10: 10});
  late final sComputed = createComputed(() => sSignal.value * 10);

  final externalSignal = signal(100);
  int effectRunCount = 0;
  int listenRunCount = 0;

  @override
  void initState() {
    super.initState();
    createEffect(() {
      sSignal.value;
      effectRunCount++;
    });

    listenSignal(sSignal, () {
      sSignal.value;
      listenRunCount++;
    });

    // Call again to cover listener cleanup line 336
    listenSignal(sSignal, () {
      sSignal.value;
      listenRunCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Test watchSignal and bindSignal
    final extVal = watchSignal(externalSignal);
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text('Signal: ${sSignal.value}'),
            Text('External: $extVal'),
          ],
        ),
      ),
    );
  }
}

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

    testWidgets('comprehensive mixin functionality', (tester) async {
      final key = GlobalKey<FullMixinWidgetState>();
      final widget = FullMixinWidget(stateKey: key);

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final state = key.currentState!;

      // Verify all local signals were created successfully
      expect(state.sSignal.value, 1);
      expect(state.sList, [7]);
      expect(state.sSet, {8});
      expect(state.sQueue.first, 9);
      expect(state.sMap[10], 10);
      expect(state.sComputed.value, 10);

      // Initialize all late final signals to cover their creation mixin methods
      expect(state.sFuture.value, isNotNull);
      expect(state.sStream.value, isNotNull);
      expect(state.sAsync.value, isNotNull);
      expect(state.sComputedFrom.value, isNotNull);
      expect(state.sComputedAsync.value, isNotNull);

      // Verify effects and listeners ran on init
      expect(state.effectRunCount, 1);
      expect(state.listenRunCount, 2);

      // Trigger changes
      state.sSignal.value = 2;
      await tester.pumpAndSettle();

      expect(state.effectRunCount, 2);
      expect(state.listenRunCount, 3);

      // Test unlistenSignal
      state.unlistenSignal(state.sSignal, () {}); // Non-matching dummy callback
      state.unlistenSignal(state.sSignal,
          state.sSignal.value.toString as void Function()); // Another

      // Test unwatch
      state.unbindSignal(state.externalSignal);
      state.unwatchSignal(state.externalSignal);

      // Register listener on sComputed to cover listener cleanup in disposeSignal
      state.listenSignal(state.sComputed, () {
        state.sComputed.value;
      });
      final computedId = state.sComputed.globalId;
      state.disposeSignal(computedId);
      expect(state.sComputed.disposed, isTrue);

      // Test disposeSignal explicitly (also cleans up listener since one is registered)
      final signalId = state.sSignal.globalId;
      state.disposeSignal(signalId);
      expect(state.sSignal.disposed, isTrue);

      // Unmount to trigger full mixin dispose
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();

      expect(state.sList.disposed, isTrue);
      expect(state.sSet.disposed, isTrue);
      expect(state.sQueue.disposed, isTrue);
      expect(state.sMap.disposed, isTrue);
    });
  });
}
