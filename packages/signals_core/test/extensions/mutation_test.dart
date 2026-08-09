import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('toMutationSignal extension', () {
    test('converts a mutation function into a MutationSignal', () async {
      Future<int> double(int arg) async => arg * 2;
      final m = double.toMutationSignal();
      expect(m, isA<MutationSignal<int, int>>());
      expect(m.peek(), isA<MutationIdle<int>>());

      final result = await m.mutateAsync(21);
      expect(result, 42);
      expect(m.peek().requireValue, 42);
    });

    test('passes options through', () {
      Future<int> noop(int arg) async => arg;
      final m = noop.toMutationSignal(
        options: SignalOptions<MutationState<int>>(name: 'saver'),
      );
      expect(m.name, 'saver');
    });
  });

  group('MutationSignalState selectData extension', () {
    test('maps success data, preserving the success state', () {
      final s = signal<MutationState<int>>(MutationState.data(10));
      final selected = s.selectData((data) => 'val: $data');

      expect(selected.value, isA<MutationSuccess<String>>());
      expect(selected.value.requireValue, 'val: 10');
      expect(selected.value.hasValue, true);
    });

    test('preserves idle', () {
      final s = signal<MutationState<int>>(MutationState.idle());
      final selected = s.selectData((data) => 'val: $data');
      expect(selected.value, isA<MutationIdle<String>>());
      expect(selected.value.isIdle, true);
    });

    test('preserves pending', () {
      final s = signal<MutationState<int>>(MutationState.pending());
      final selected = s.selectData((data) => 'val: $data');
      expect(selected.value, isA<MutationPending<String>>());
      expect(selected.value.isPending, true);
    });

    test('preserves error', () {
      final err = Exception('boom');
      final s = signal<MutationState<int>>(MutationState.error(err));
      final selected = s.selectData((data) => 'val: $data');
      expect(selected.value, isA<MutationError<String>>());
      expect(selected.value.error, err);
    });

    test('reactively updates when the signal value changes', () {
      final s = signal<MutationState<int>>(MutationState.data(10));
      final selected = s.selectData((data) => data * 2);
      expect(selected.value.requireValue, 20);

      s.value = MutationState.data(50);
      expect(selected.value.requireValue, 100);
    });
  });
}
