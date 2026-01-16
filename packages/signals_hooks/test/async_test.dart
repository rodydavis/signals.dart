import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_hooks/signals_hooks.dart';

void main() {
  group('Async Signals Tests', () {
    group('useFutureSignal', () {
      testWidgets('compelete with value', (tester) async {
        FutureSignal<int>? state;
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              state ??= useFutureSignal(
                () => Future.delayed(const Duration(seconds: 1), () => 1),
                options: StreamSignalOptions(lazy: false),
              );
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(state!.value.isLoading, true);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(state!.value.hasValue, true);
        expect(state!.value.value, 1);
      });
    });

    group('useStreamSignal', () {
      testWidgets('emit value', (tester) async {
        StreamSignal<int>? state;
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              state ??= useStreamSignal(
                () => Stream.periodic(const Duration(seconds: 1), (i) => i)
                    .take(1),
                options: StreamSignalOptions(lazy: false),
              );
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(state!.value.isLoading, true);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(state!.value.hasValue, true);
        expect(state!.value.value, 0);
      });
    });

    group('useAsyncSignal', () {
      testWidgets('initial value', (tester) async {
        AsyncSignal<int>? state;
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              state ??= useAsyncSignal<int>(const AsyncLoading());
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(state!.value.isLoading, true);
      });

      testWidgets('set value', (tester) async {
        AsyncSignal<int>? state;
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              state ??= useAsyncSignal<int>(const AsyncLoading());
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
        );

        state!.value = const AsyncData(1);
        await tester.pumpAndSettle();

        expect(state!.value.hasValue, true);
        expect(state!.value.value, 1);
      });
    });

    group('useAsyncComputed', () {
      testWidgets('compelete with value', (tester) async {
        final count = signal(0);
        FutureSignal<int>? state;
        await tester.pumpWidget(
          HookBuilder(
            builder: (context) {
              state ??= useAsyncComputed(
                () => Future.delayed(
                  const Duration(seconds: 1),
                  () => count.value * 2,
                ),
                options: StreamSignalOptions(
                  dependencies: [count],
                  lazy: false,
                ),
              );
              return Text('$state', textDirection: TextDirection.ltr);
            },
          ),
        );

        expect(state!.value.isLoading, true);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(state!.value.hasValue, true);
        expect(state!.value.value, 0);

        count.value = 1;
        await tester.pumpAndSettle();
        expect(state!.value.isLoading, true);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(state!.value.hasValue, true);
        expect(state!.value.value, 2);
      });
    });
  });
}
