import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('AsyncSignal', () {
    test('data', () async {
      final s = asyncSignal(AsyncState<int>.data(0));
      expect(s.peek().isLoading, false);
      expect(s.peek().hasError, false);
      expect(s.peek().hasValue, true);
      expect(s.peek().requireValue, 0);
      expect(s.requireValue, 0);
    });

    test('isCompleted', () async {
      final s = asyncSignal(AsyncState<int>.data(0));
      expect(s.isCompleted, false);
      s.setValue(1);
      expect(s.isCompleted, true);
    });

    test('error', () async {
      final s = asyncSignal(AsyncState<int>.error('error'));
      expect(s.peek().isLoading, false);
      expect(s.peek().hasError, true);
      expect(s.peek().hasValue, false);
      expect(s.peek().error, 'error');
    });

    test('loading', () async {
      final s = asyncSignal(AsyncState<int>.loading());
      expect(s.peek().isLoading, true);
      expect(s.peek().hasError, false);
      expect(s.peek().hasValue, false);
    });

    test('state', () async {
      final s = asyncSignal(AsyncState<int>.loading());
      expect(s().isLoading, true);
      s.setValue(0);
      expect(s().isLoading, false);
      expect(s().hasError, false);
      expect(s().hasValue, true);
      expect(s().requireValue, 0);
      expect(s.requireValue, 0);
      s.setError('error');
      expect(s().isLoading, false);
      expect(s().hasError, true);
      expect(s().hasValue, false);
      expect(s().error, 'error');
      s.setLoading();
      expect(s().isLoading, true);
      expect(s().hasError, false);
      expect(s().hasValue, false);
    });

    group('reload', () {
      test('data', () async {
        final s = asyncSignal(AsyncState<int>.data(0));
        s.reload();
        expect(s.value is AsyncLoading, true);
        expect(s.value is AsyncData, true);
        expect(s.value is AsyncDataReloading, true);
        expect(s.value.isLoading, true);
        expect(s.value.isReloading, true);
        expect(s.value.isRefreshing, false);
      });

      test('error', () async {
        final s = asyncSignal(AsyncState<int>.error('error'));
        s.reload();
        expect(s.value is AsyncLoading, true);
        expect(s.value is AsyncError, true);
        expect(s.value is AsyncErrorReloading, true);
        expect(s.value.isLoading, true);
        expect(s.value.isReloading, true);
        expect(s.value.isRefreshing, false);
      });

      test('loading', () async {
        final s = asyncSignal(AsyncState<int>.loading());
        s.reload();
        expect(s.value is AsyncLoading, true);
        expect(s.value is! AsyncDataReloading, true);
        expect(s.value is! AsyncDataRefreshing, true);
        expect(s.value is! AsyncErrorReloading, true);
        expect(s.value is! AsyncErrorRefreshing, true);
        expect(s.value.isLoading, true);
        expect(s.value.isReloading, false);
        expect(s.value.isRefreshing, false);
      });
    });

    group('refresh', () {
      test('data', () async {
        final s = asyncSignal(AsyncState<int>.data(0));
        s.refresh();
        expect(s.value is AsyncLoading, true);
        expect(s.value is AsyncData, true);
        expect(s.value is AsyncDataRefreshing, true);
        expect(s.value.isLoading, true);
        expect(s.value.isRefreshing, true);
        expect(s.value.isReloading, false);
      });

      test('error', () async {
        final s = asyncSignal(AsyncState<int>.error('error'));
        s.refresh();
        expect(s.value is AsyncLoading, true);
        expect(s.value is AsyncError, true);
        expect(s.value is AsyncErrorRefreshing, true);
        expect(s.value.isLoading, true);
        expect(s.value.isRefreshing, true);
        expect(s.value.isReloading, false);
      });

      test('loading', () async {
        final s = asyncSignal(AsyncState<int>.loading());
        s.refresh();
        expect(s.value is AsyncLoading, true);
        expect(s.value is! AsyncDataReloading, true);
        expect(s.value is! AsyncDataRefreshing, true);
        expect(s.value is! AsyncErrorReloading, true);
        expect(s.value is! AsyncErrorRefreshing, true);
        expect(s.value.isLoading, true);
        expect(s.value.isReloading, false);
        expect(s.value.isRefreshing, false);
      });
    });
  });
}
