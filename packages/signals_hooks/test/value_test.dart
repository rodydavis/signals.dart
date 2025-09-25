import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_hooks/signals_hooks.dart';

void main() {
  group('Value Signals Tests', () {
    group('useListSignal', () {
      testWidgets('initial value', (tester) async {
        late ListSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useListSignal([1, 2, 3]);
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        expect(find.text('[1, 2, 3]'), findsOneWidget);
      });

      testWidgets('add value', (tester) async {
        late ListSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useListSignal([1, 2, 3]);
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        state.add(4);
        await tester.pumpAndSettle();

        expect(find.text('[1, 2, 3, 4]'), findsOneWidget);
      });
    });

    group('useSetSignal', () {
      testWidgets('initial value', (tester) async {
        late SetSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useSetSignal({1, 2, 3});
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        expect(find.text('{1, 2, 3}'), findsOneWidget);
      });

      testWidgets('add value', (tester) async {
        late SetSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useSetSignal({1, 2, 3});
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        state.add(4);
        await tester.pumpAndSettle();

        expect(find.text('{1, 2, 3, 4}'), findsOneWidget);
      });
    });

    group('useIterableSignal', () {
      testWidgets('initial value', (tester) async {
        late IterableSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useIterableSignal([1, 2, 3]);
            return Text(state.join(',').toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        expect(find.text('1,2,3'), findsOneWidget);
      });
    });

    group('useMapSignal', () {
      testWidgets('initial value', (tester) async {
        late MapSignal<String, int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useMapSignal({'a': 1, 'b': 2});
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        expect(find.text('{a: 1, b: 2}'), findsOneWidget);
      });

      testWidgets('add value', (tester) async {
        late MapSignal<String, int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useMapSignal({'a': 1, 'b': 2});
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        state['c'] = 3;
        await tester.pumpAndSettle();

        expect(find.text('{a: 1, b: 2, c: 3}'), findsOneWidget);
      });
    });

    group('useTrackedSignal', () {
      testWidgets('initial value', (tester) async {
        late TrackedSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useTrackedSignal(42);
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('set value', (tester) async {
        late TrackedSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useTrackedSignal(42);
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        state.value = 43;
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });
    });

    group('useQueueSignal', () {
      testWidgets('initial value', (tester) async {
        late QueueSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useQueueSignal(Queue.from([1, 2, 3]));
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        expect(find.text('{1, 2, 3}'), findsOneWidget);
      });

      testWidgets('add value', (tester) async {
        late QueueSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useQueueSignal(Queue.from([1, 2, 3]));
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        state.add(4);
        await tester.pumpAndSettle();

        expect(find.text('{1, 2, 3, 4}'), findsOneWidget);
      });
    });

    group('useChangeStackSignal', () {
      testWidgets('initial value', (tester) async {
        late ChangeStackSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useChangeStackSignal(42);
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('set value', (tester) async {
        late ChangeStackSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useChangeStackSignal(42);
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        state.value = 43;
        await tester.pumpAndSettle();

        expect(find.text('43'), findsOneWidget);
      });

      testWidgets('undo/redo', (tester) async {
        late ChangeStackSignal<int> state;
        await tester.pumpWidget(
          HookBuilder(builder: (context) {
            state = useChangeStackSignal(42);
            return Text(state.value.toString(),
                textDirection: TextDirection.ltr);
          }),
        );

        state.value = 43;
        await tester.pumpAndSettle();

        expect(state.value, 43);
        expect(find.text('43'), findsOneWidget);

        state.undo();
        await tester.pumpAndSettle();

        expect(state.value, 42);
        expect(find.text('42'), findsOneWidget);

        state.redo();
        await tester.pumpAndSettle();

        expect(state.value, 43);
        expect(find.text('43'), findsOneWidget);
      });
    });
  });
}
