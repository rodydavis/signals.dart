// ignore_for_file: unnecessary_type_check

import 'dart:async';
import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

class _Signal<T> extends Signal<T> with StreamSignalMixin<T> {
  _Signal(super.internalValue);
}

void main() {
  SignalsObserver.instance = null;

  group('StreamSignalMixin', () {
    test('check if extends type', () {
      final s = _Signal(0);

      expect(s.value, 0);
      expect(s is Signal, true);
      expect(s is Stream, true);
      s.dispose();
    });

    test('values', () async {
      final s = _Signal(0);

      final matcher = expectLater(
        s,
        emitsInOrder([0, 1, 2]),
      );

      s.value = 1;
      s.value = 2;

      await matcher;
      s.dispose();
    });

    test('any', () async {
      final s = _Signal(1);
      expect(await s.any((x) => x == 1), true);
      s.dispose();
    });

    test('asBroadcastStream', () async {
      final s = _Signal(1);
      final broadcast = s.asBroadcastStream();
      expect(broadcast.isBroadcast, true);
      s.dispose();
    });

    test('cast', () async {
      final s = _Signal(1);
      final casted = s.cast<num>();
      expect(casted, isA<Stream<num>>());
      s.dispose();
    });

    test('contains', () async {
      final s = _Signal(1);
      expect(await s.contains(1), true);
      s.dispose();
    });

    test('elementAt', () async {
      final s = _Signal(1);
      expect(await s.elementAt(0), 1);
      s.dispose();
    });

    test('every', () async {
      final s = _Signal(1);
      Future.microtask(() => s.dispose());
      expect(await s.every((x) => x > 0), true);
    });

    test('distinct', () async {
      final s = _Signal(1);
      final distinctStream = s.distinct();
      expect(distinctStream, isA<Stream<int>>());
      s.dispose();
    });

    test('skip, skipWhile, takeWhile, where', () async {
      final s = _Signal(1);
      expect(s.skip(1), isA<Stream<int>>());
      expect(s.skipWhile((x) => x < 2), isA<Stream<int>>());
      expect(s.takeWhile((x) => x < 5), isA<Stream<int>>());
      expect(s.where((x) => x > 0), isA<Stream<int>>());
      s.dispose();
    });

    test('asyncMap', () async {
      final s = _Signal(10);
      final asyncMapped = s.asyncMap((x) => Future.value(x * 2));
      expect(await asyncMapped.first, 20);
      s.dispose();
    });

    test('asyncExpand', () async {
      final s = _Signal(10);
      final asyncExpanded = s.asyncExpand((x) => Stream.fromIterable([x, x + 1]));
      expect(await asyncExpanded.take(2).toList(), [10, 11]);
      s.dispose();
    });

    test('expand', () async {
      final s = _Signal(10);
      final expanded = s.expand((x) => [x, x + 5]);
      expect(await expanded.take(2).toList(), [10, 15]);
      s.dispose();
    });

    test('first', () async {
      final s = _Signal(10);
      expect(await s.first, 10);
      s.dispose();
    });

    test('firstWhere', () async {
      final s = _Signal(10);
      final firstWhereVal = await s.firstWhere((x) => x == 10);
      expect(firstWhereVal, 10);
      s.dispose();
    });

    test('fold', () async {
      final s = _Signal(10);
      Future.microtask(() => s.dispose());
      final folded = await s.fold<int>(0, (prev, element) => prev + element);
      expect(folded, 10);
    });

    test('forEach', () async {
      final s = _Signal(10);
      var sum = 0;
      Future.microtask(() => s.dispose());
      await s.forEach((x) => sum += x);
      expect(sum, 10);
    });

    test('join', () async {
      final s = _Signal(10);
      Future.microtask(() => s.dispose());
      final joinVal = await s.join(',');
      expect(joinVal, '10');
    });

    test('last', () async {
      final s = _Signal(10);
      Future.microtask(() => s.dispose());
      final lastVal = await s.last;
      expect(lastVal, 10);
    });

    test('lastWhere', () async {
      final s = _Signal(10);
      Future.microtask(() => s.dispose());
      final lastWhereVal = await s.lastWhere((x) => x == 10);
      expect(lastWhereVal, 10);
    });

    test('length', () async {
      final s = _Signal(10);
      Future.microtask(() => s.dispose());
      final lengthVal = await s.length;
      expect(lengthVal, 1);
    });

    test('reduce', () async {
      final s = _Signal(10);
      Future.microtask(() => s.dispose());
      final reduced = await s.reduce((val, elem) => val + elem);
      expect(reduced, 10);
    });

    test('single', () async {
      final s = _Signal(10);
      Future.microtask(() => s.dispose());
      final singleVal = await s.single;
      expect(singleVal, 10);
    });

    test('singleWhere', () async {
      final s = _Signal(10);
      Future.microtask(() => s.dispose());
      final singleWhereVal = await s.singleWhere((x) => x == 10);
      expect(singleWhereVal, 10);
    });

    test('toList & toSet', () async {
      final s = _Signal(10);
      Future.microtask(() => s.dispose());
      expect(await s.toList(), [10]);
      
      final s2 = _Signal(10);
      Future.microtask(() => s2.dispose());
      expect(await s2.toSet(), {10});
    });

    test('timeout & transform', () async {
      final s = _Signal(10);
      final timeoutStream = s.timeout(const Duration(seconds: 1));
      expect(timeoutStream, isA<Stream<int>>());

      final transformStream = s.transform(StreamTransformer<int, int>.fromHandlers());
      expect(transformStream, isA<Stream<int>>());
      s.dispose();
    });

    test('handleError & drain', () async {
      final s = _Signal(1);
      final errorStream = s.handleError((err) {});
      expect(errorStream, isA<Stream<int>>());

      Future.microtask(() => s.dispose());
      final drained = s.drain<int>(42);
      expect(await drained, 42);
    });

    test('isEmpty', () async {
      final s = _Signal(1);
      Future.microtask(() => s.dispose());
      expect(await s.isEmpty, false);
    });

    test('map', () async {
      final s = _Signal(1);
      final mapped = s.map((x) => x * 2);
      expect(await mapped.first, 2);
      s.dispose();
    });

    test('take', () async {
      final s = _Signal(1);
      final taken = s.take(1);
      expect(await taken.first, 1);
      s.dispose();
    });

    test('pipe', () async {
      final s = _Signal(1);
      final controller = StreamController<int>();
      controller.stream.listen((_) {});
      Future.microtask(() => s.dispose());
      await s.pipe(controller);
      expect(controller.isClosed, true);
    });
  });
}
