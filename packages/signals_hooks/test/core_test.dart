import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_hooks/signals_hooks.dart';

void main() {
  group('Core Signals Tests', () {
    group('Signal', () {
      testWidgets('get value', (tester) async {
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final state = useSignal(42);
            return Text('$state', textDirection: TextDirection.ltr);
          },),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('set value', (tester) async {
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final state = useSignal(42);
            return GestureDetector(
              onTap: () => state.value++,
              child: Text('$state', textDirection: TextDirection.ltr),
            );
          },),
        );

        // Click text and wait
        await tester.tap(find.text('42'));
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });
    });

    group('Computed', () {
      testWidgets('get value', (tester) async {
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final state = useSignal(42);
            final computedState = useComputed(() => state.value * 2);
            return Text('$computedState', textDirection: TextDirection.ltr);
          },),
        );

        expect(find.text('84'), findsOneWidget);
      });

      testWidgets('set value', (tester) async {
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final state = useSignal(42);
            final computedState = useComputed(() => state.value * 2);
            return GestureDetector(
              onTap: () => state.value++,
              child: Text('$computedState', textDirection: TextDirection.ltr),
            );
          },),
        );

        // Click text and wait
        await tester.tap(find.text('84'));
        await tester.pumpAndSettle();

        expect(find.text('86'), findsOneWidget);
      });
    });

    group('SignalEffect', () {
      testWidgets('on mounted', (tester) async {
        int count = 0;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            useSignalEffect(() => count++);
            return Container();
          },),
        );

        expect(count, 1);
      });

      testWidgets('on value changed', (tester) async {
        int count = 0;
        final state = signal(42);
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            useSignalEffect(() => count = state.value);
            return Container();
          },),
        );

        expect(count, 42);

        state.value++;
        await tester.pumpAndSettle();

        expect(count, 43);
      });

      testWidgets('on dispose', (tester) async {
        int count = 0;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            useSignalEffect(
              () => count++,
              onDispose: () => count = -1,
            );
            return Container();
          },),
        );

        expect(count, 1);

        await tester.pumpWidget(Container());

        expect(count, -1);
      });
    });

    group('ExistingSignal', () {
      testWidgets('get value', (tester) async {
        final state = signal(42);
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final signal = useExistingSignal(state);
            return Text('$signal', textDirection: TextDirection.ltr);
          },),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('set value', (tester) async {
        final state = signal(42);
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final signal = useExistingSignal(state);
            return GestureDetector(
              onTap: () => signal.value++,
              child: Text('$signal', textDirection: TextDirection.ltr),
            );
          },),
        );

        // Click text and wait
        await tester.tap(find.text('42'));
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });
    });

    group('SignalValue', () {
      testWidgets('get value', (tester) async {
        final state = signal(42);
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final value = useSignalValue(state);
            return Text('$value', textDirection: TextDirection.ltr);
          },),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('set value', (tester) async {
        final state = signal(42);
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            final value = useSignalValue(state);
            return GestureDetector(
              onTap: () => state.value++,
              child: Text('$value', textDirection: TextDirection.ltr),
            );
          },),
        );

        // Click text and wait
        await tester.tap(find.text('42'));
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });
    });
  });
}
