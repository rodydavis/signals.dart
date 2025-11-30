import 'dart:async';

import 'package:preact_signals/preact_signals.dart';
import 'package:test/test.dart';

void main() {
  group('Zone Migration', () {
    test('effect should track dependencies across async gaps', () async {
      final s = signal(0);
      int callCount = 0;

      effect(() async {
        callCount++;
        // Access signal before await
        s.value;

        await Future.delayed(Duration.zero);

        // Access signal after await - this should still be tracked with Zones
        s.value;
      });

      expect(callCount, 1);

      // Update signal
      s.value = 1;

      // Wait for effect to re-run
      await Future.delayed(Duration.zero);

      expect(callCount, 2);
    });

    test('untracked should persist across async gaps', () async {
      final s = signal(0);
      int callCount = 0;

      effect(() async {
        untracked(() async {
          // This should be untracked
          s.value;
          await Future.delayed(Duration.zero);
          // This should still be untracked
          s.value;
        });
        callCount++;
      });

      expect(callCount, 1);
      s.value = 1;
      await Future.delayed(Duration.zero);

      // If untracked works correctly, s.value access inside untracked should NOT create a dependency.
      // So callCount should remain 1.
      expect(callCount, 1);
    });

    test('nested async effects should work correctly', () async {
      final outer = signal(0);
      final inner = signal(0);
      int outerCount = 0;
      int innerCount = 0;

      effect(() async {
        outerCount++;
        outer.value;
        await Future.delayed(Duration.zero);

        effect(() async {
          innerCount++;
          inner.value;
          await Future.delayed(Duration.zero);
          inner.value;
        });

        outer.value;
      });

      await Future.delayed(Duration.zero);
      expect(outerCount, 1);
      expect(innerCount, 1);

      // Trigger outer
      outer.value++;
      await Future.delayed(Duration.zero);
      expect(outerCount, 2);
      // Inner is re-created, so it runs again
      expect(innerCount, 2);

      // Trigger inner only
      inner.value++;
      await Future.delayed(Duration.zero);
      // Outer should not run
      expect(outerCount, 2);
      // Inner should run (it was created in the second run of outer)
      // Since async effects don't support return-value cleanup, the old inner effect is NOT disposed.
      // So both the old and new inner effects run.
      // Run 1: created effect 1.
      // Run 2: created effect 2. Effect 1 still alive.
      // Trigger: Effect 1 runs (count -> 3), Effect 2 runs (count -> 4).
      expect(innerCount, 4);
    });

    test(
        'cleanup should NOT be called when async effect re-runs (not supported)',
        () async {
      final s = signal(0);
      int cleanupCount = 0;

      effect(() async {
        s.value;
        await Future.delayed(Duration.zero);
        return () {
          cleanupCount++;
        };
      });

      await Future.delayed(Duration.zero);
      expect(cleanupCount, 0);

      s.value++;
      await Future.delayed(Duration.zero);
      // Async effects return a Future, which is not a Function, so cleanup is ignored.
      expect(cleanupCount, 0);
    });

    test('signals should work inside custom zones', () async {
      final s = signal(0);
      int callCount = 0;

      runZoned(() {
        effect(() async {
          callCount++;
          s.value;
          await Future.delayed(Duration.zero);
          s.value;
        });
      }, zoneValues: {#custom: 'value'});

      expect(callCount, 1);

      s.value++;
      await Future.delayed(Duration.zero);
      expect(callCount, 2);
    });

    test('peek should not track dependencies inside async effect', () async {
      final s = signal(0);
      int callCount = 0;

      effect(() async {
        callCount++;
        await Future.delayed(Duration.zero);
        s.peek();
      });

      expect(callCount, 1);

      s.value++;
      await Future.delayed(Duration.zero);
      expect(callCount, 1);
    });

    test('batch should work with async effects', () async {
      final s = signal(0);
      int callCount = 0;

      effect(() async {
        callCount++;
        s.value;
        await Future.delayed(Duration.zero);
      });

      expect(callCount, 1);

      batch(() {
        s.value++;
        s.value++;
        s.value++;
      });

      await Future.delayed(Duration.zero);
      expect(callCount, 2);
    });

    test('effect should track NEW dependencies accessed after await', () async {
      final s1 = signal(0);
      final s2 = signal(0);
      int callCount = 0;

      effect(() async {
        callCount++;
        s1.value;
        await Future.delayed(Duration.zero);
        s2.value;
      });

      expect(callCount, 1);

      // Update s1 (accessed before await)
      s1.value++;
      await Future.delayed(Duration.zero);
      expect(callCount, 2);

      // Update s2 (accessed after await)
      s2.value++;
      await Future.delayed(Duration.zero);
      expect(callCount, 3);
    });

    test('effect should track dependencies across multiple async gaps',
        () async {
      final s = signal(0);
      int callCount = 0;

      effect(() async {
        callCount++;
        await Future.delayed(Duration.zero);
        await Future.delayed(Duration.zero);
        s.value;
      });

      expect(callCount, 1);

      // Wait for effect to reach the dependency access
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);

      s.value++;
      await Future.delayed(Duration.zero);
      await Future.delayed(Duration.zero);
      expect(callCount, 2);
    });

    test('untracked should work after await', () async {
      final s = signal(0);
      int callCount = 0;

      effect(() async {
        callCount++;
        await Future.delayed(Duration.zero);
        untracked(() {
          s.value;
        });
      });

      expect(callCount, 1);

      s.value++;
      await Future.delayed(Duration.zero);
      expect(callCount, 1);
    });

    test('peek should work after await', () async {
      final s = signal(0);
      int callCount = 0;

      effect(() async {
        callCount++;
        await Future.delayed(Duration.zero);
        s.peek();
      });

      expect(callCount, 1);

      s.value++;
      await Future.delayed(Duration.zero);
      expect(callCount, 1);
    });
    test('effect should track dependency accessed after long delay', () async {
      final a = signal(0);
      final b = signal(0);
      int callCount = 0;

      effect(() async {
        callCount++;
        a.value;
        await Future.delayed(const Duration(milliseconds: 100));
        b.value;
      });

      expect(callCount, 1);

      // Wait for effect to complete first run
      await Future.delayed(const Duration(milliseconds: 150));

      // Update b (accessed after delay)
      b.value++;

      // Wait for effect to re-run
      await Future.delayed(const Duration(milliseconds: 150));

      expect(callCount, 2);
    });
  });
}
