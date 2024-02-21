import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('AsyncState', () {
    test('AsyncData', () {
      final s = AsyncState<int>.data(0);
      expect(s.isLoading, false);
      expect(s.hasError, false);
      expect(s.hasValue, true);
      expect(s.requireValue, 0);
      expect(s.value, 0);
      expect(s.error, null);
      expect(s.stackTrace, null);
      expect(s.isRefreshing, false);
      expect(s.isReloading, false);
    });

    test('AsyncError', () {
      final s = AsyncState<int>.error('error');
      expect(s.isLoading, false);
      expect(s.hasError, true);
      expect(s.hasValue, false);
      expect(s.value, null);
      expect(s.error, 'error');
      expect(s.stackTrace != null, true);
      expect(s.isRefreshing, false);
      expect(s.isReloading, false);
    });

    test('AsyncLoading', () {
      final s = AsyncState<int>.loading();
      expect(s.isLoading, true);
      expect(s.hasError, false);
      expect(s.hasValue, false);
      expect(s.value, null);
      expect(s.error, null);
      expect(s.stackTrace, null);
      expect(s.isRefreshing, false);
      expect(s.isReloading, false);
    });

    group('map', () {
      test('data', () {
        final s = AsyncState<int>.data(0);
        int value = -1;
        s.map(
          data: (data) => value = data,
          error: (error, stackTrace) {},
          loading: () {},
        );
        expect(value, 0);
      });

      test('error', () {
        final s = AsyncState<int>.error('error');
        final value = s.map<String>(
          data: (data) => '$data',
          error: (error) => '$error',
          loading: () => '',
        );
        final value2 = s.map<String>(
          data: (data) => '$data',
          error: (error, _) => '$error',
          loading: () => '',
        );
        final value3 = s.map<String>(
          data: (data) => '$data',
          error: () => 'err',
          loading: () => '',
        );
        expect(value, 'error');
        expect(value2, 'error');
        expect(value3, 'err');
      });

      test('loading', () {
        final s = AsyncState<int>.loading();
        bool value = false;
        s.map(
          data: (data) {},
          error: (error, stackTrace) {},
          loading: () => value = true,
        );
        expect(value, true);
      });
    });

    group('maybeMap', () {
      test('data', () {
        final s = AsyncState<int>.data(0);
        int value = -1;
        s.maybeMap(
          data: (data) => value = data,
          orElse: () {},
        );
        expect(value, 0);
      });

      test('orElse', () {
        final s = AsyncState<int>.data(0);
        int value = -1;
        s.maybeMap(
          error: (error, stackTrace) {},
          orElse: () => value = 1,
        );
        expect(value, 1);
      });

      test('hashCode', () {
        final s = AsyncState<int>.data(0);
        final value = s.hashCode;
        expect(value != 0, true);
      });

      test('equality', () {
        final s = AsyncState<int>.data(0);
        final value = s == AsyncState<int>.data(0);
        expect(value, true);
      });

      test('error', () {
        final s = AsyncState<int>.error('error');
        final value = s.maybeMap<String>(
          data: (data) => '$data',
          error: (error) => '$error',
          orElse: () => '',
        );
        final value2 = s.maybeMap<String>(
          data: (data) => '$data',
          error: (error, _) => '$error',
          orElse: () => '',
        );
        final value3 = s.maybeMap<String>(
          data: (data) => '$data',
          error: () => 'err',
          orElse: () => '',
        );
        expect(value, 'error');
        expect(value2, 'error');
        expect(value3, 'err');
      });

      test('loading', () {
        final s = AsyncState<int>.loading();
        bool value = false;
        s.maybeMap(
          loading: () => value = true,
          orElse: () {},
        );
        expect(value, true);
      });
    });
  });
}
