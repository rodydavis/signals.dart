import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('AsyncSignalState extension', () {
    test('selectData with AsyncData scenario', () {
      final s = signal<AsyncState<int>>(AsyncState.data(10));
      final computedData = s.selectData((data) => 'val: $data');

      expect(computedData.value, isA<AsyncData<String>>());
      expect(computedData.value.value, 'val: 10');
      expect(computedData.value.isLoading, false);
      expect(computedData.value.hasError, false);
    });

    test('selectData with AsyncLoading scenario', () {
      final s = signal<AsyncState<int>>(AsyncState.loading());
      final computedData = s.selectData((data) => 'val: $data');

      expect(computedData.value, isA<AsyncLoading<String>>());
      expect(computedData.value.isLoading, true);
      expect(computedData.value.hasError, false);
    });

    test('selectData with AsyncError scenario', () {
      final exception = Exception('error');
      final s = signal<AsyncState<int>>(AsyncState.error(exception));
      final computedData = s.selectData((data) => 'val: $data');

      expect(computedData.value, isA<AsyncError<String>>());
      expect(computedData.value.isLoading, false);
      expect(computedData.value.hasError, true);
      expect((computedData.value as AsyncError).error, exception);
    });

    test('selectData reactively updates when signal value changes', () {
      final s = signal<AsyncState<int>>(AsyncState.data(10));
      final computedData = s.selectData((data) => data * 2);

      expect(computedData.value.value, 20);

      s.value = AsyncState.data(25);
      expect(computedData.value.value, 50);

      s.value = AsyncState.loading();
      expect(computedData.value, isA<AsyncLoading<int>>());
    });
  });
}
