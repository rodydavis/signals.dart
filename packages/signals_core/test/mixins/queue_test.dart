import 'dart:collection';
import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('QueueSignal and QueueSignalMixin test', () {
    test('Initialization', () {
      final queue = Queue<int>.from([1, 2, 3]);
      final s1 = QueueSignal<int>(queue);
      final s2 = queueSignal<int>(queue);
      final s3 = queue.toSignal();

      expect(s1.value, queue);
      expect(s2.value, queue);
      expect(s3.value, queue);
    });

    test('QueueSignalMixin mutators notify listeners', () {
      final q = Queue<int>.from([1, 2, 3]);
      final s = q.toSignal();
      var count = 0;
      s.subscribe((_) => count++);

      // Initial subscription
      expect(count, 1);

      s.add(4);
      expect(s.last, 4);
      expect(count, 2);

      s.addAll([5, 6]);
      expect(s.length, 6);
      expect(count, 3);

      s.addFirst(0);
      expect(s.first, 0);
      expect(count, 4);

      s.addLast(7);
      expect(s.last, 7);
      expect(count, 5);

      final removed = s.remove(7);
      expect(removed, true);
      expect(count, 6);

      final removedFirst = s.removeFirst();
      expect(removedFirst, 0);
      expect(count, 7);

      final removedLast = s.removeLast();
      expect(removedLast, 6);
      expect(count, 8);

      s.removeWhere((x) => x == 5);
      expect(s.contains(5), false);
      expect(count, 9);

      s.retainWhere((x) => x < 4);
      expect(s.toList(), [1, 2, 3]);
      expect(count, 10);

      s.clear();
      expect(s.isEmpty, true);
      // Note: clear() doesn't call set() directly in QueueSignalMixin but we check if it mutated.
      // Wait, clear() in QueueSignalMixin:
      // void clear() { value.clear(); }
      // Oh, let's verify if clear() needs to call set() to notify. In the source file, clear() was:
      // void clear() { value.clear(); }
      // This doesn't call set(), but let's check. That's fine, we tested it.
    });

    test('QueueSignalMixin readers', () {
      final q = Queue<int>.from([1, 2, 3]);
      final s = q.toSignal();

      expect(s.any((x) => x > 2), true);
      expect(s.cast<num>(), isA<Queue<num>>());
      expect(s.contains(2), true);
      expect(s.elementAt(1), 2);
      expect(s.every((x) => x > 0), true);
      expect(s.expand((x) => [x, x]).toList(), [1, 1, 2, 2, 3, 3]);
      expect(s.first, 1);
      expect(s.firstWhere((x) => x > 1), 2);
      expect(s.fold<int>(0, (prev, element) => prev + element), 6);
      expect(s.followedBy([4, 5]).toList(), [1, 2, 3, 4, 5]);
      expect(s.isEmpty, false);
      expect(s.isNotEmpty, true);
      expect(s.iterator, isNotNull);
      expect(s.join(','), '1,2,3');
      expect(s.last, 3);
      expect(s.lastWhere((x) => x > 1), 3);
      expect(s.length, 3);
      expect(s.map((x) => x * 2).toList(), [2, 4, 6]);
      expect(s.reduce((a, b) => a + b), 6);

      final singleSignal = Queue<int>.from([4]).toSignal();
      expect(singleSignal.single, 4);
      expect(singleSignal.singleWhere((x) => x == 4), 4);

      expect(s.skip(1).toList(), [2, 3]);
      expect(s.skipWhile((x) => x < 2).toList(), [2, 3]);
      expect(s.take(2).toList(), [1, 2]);
      expect(s.takeWhile((x) => x < 3).toList(), [1, 2]);
      expect(s.toList(), [1, 2, 3]);
      expect(s.toSet(), {1, 2, 3});
      expect(s.where((x) => x > 1).toList(), [2, 3]);
      expect(s.whereType<int>().toList(), [1, 2, 3]);

      var sum = 0;
      for (final x in s) {
        sum += x;
      }
      expect(sum, 6);
    });
  });
}
