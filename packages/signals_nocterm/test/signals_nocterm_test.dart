import 'package:nocterm/nocterm.dart';
import 'package:signals_nocterm/signals_nocterm.dart';
import 'package:test/test.dart';

void main() {
  group('SignalsMixin', () {
    testNocterm('should rebuild when signal changes', (tester) async {
      final count = signal(0);

      await tester.pumpComponent(_TestCounter(count: count));

      expect(tester.terminalState, containsText('Count: 0'));

      count.value = 5;
      await tester.pump();

      expect(tester.terminalState, containsText('Count: 5'));
    });

    testNocterm('should rebuild when computed changes', (tester) async {
      await tester.pumpComponent(const _TestComputedCounter());

      expect(tester.terminalState, containsText('Count: 0, Doubled: 0'));

      // Simulate key press to increment
      await tester.sendKey(LogicalKey.space);

      expect(tester.terminalState, containsText('Count: 1, Doubled: 2'));
    });

    testNocterm('should dispose signals when component unmounts', (tester) async {
      final count = signal(0);
      var disposed = false;

      // Track when the signal is disposed
      count.onDispose(() => disposed = true);

      await tester.pumpComponent(_TestCounter(count: count));
      expect(disposed, isFalse);

      // Replace with a different component to unmount
      await tester.pumpComponent(const Text('Replaced'));

      // The externally created signal should NOT be disposed (it's not local)
      // Only locally created signals should be disposed
      expect(disposed, isFalse);
    });

    testNocterm('should dispose locally created signals on unmount', (tester) async {
      await tester.pumpComponent(const _TestLocalSignal());

      // Replace with a different component to unmount
      await tester.pumpComponent(const Text('Replaced'));
      await tester.pump();

      // Test passes if no errors occur during dispose
    });
  });

  group('Watch', () {
    testNocterm('should rebuild when signal changes', (tester) async {
      final count = signal(0);

      await tester.pumpComponent(_TestWatch(count: count));

      expect(tester.terminalState, containsText('Count: 0'));

      count.value = 10;
      await tester.pump();

      expect(tester.terminalState, containsText('Count: 10'));
    });

    testNocterm('Watch.builder should work the same as Watch', (tester) async {
      final count = signal(0);

      await tester.pumpComponent(_TestWatchBuilder2(count: count));

      expect(tester.terminalState, containsText('Count: 0'));

      count.value = 42;
      await tester.pump();

      expect(tester.terminalState, containsText('Count: 42'));
    });

    testNocterm('should support dependencies parameter', (tester) async {
      final dep = signal(0);
      final count = signal(0);

      await tester.pumpComponent(_TestWatchWithDeps(count: count, dep: dep));

      expect(tester.terminalState, containsText('Count: 0, Dep: 0'));

      dep.value = 5;
      await tester.pump();

      expect(tester.terminalState, containsText('Count: 0, Dep: 5'));
    });

    testNocterm('nested Watch components should work', (tester) async {
      final outer = signal(0);
      final inner = signal(100);

      await tester.pumpComponent(_TestNestedWatch(outer: outer, inner: inner));

      expect(tester.terminalState, containsText('Outer: 0'));
      expect(tester.terminalState, containsText('Inner: 100'));

      outer.value = 1;
      await tester.pump();

      expect(tester.terminalState, containsText('Outer: 1'));
      expect(tester.terminalState, containsText('Inner: 100'));

      inner.value = 200;
      await tester.pump();

      expect(tester.terminalState, containsText('Outer: 1'));
      expect(tester.terminalState, containsText('Inner: 200'));
    });
  });

  group('WatchBuilder', () {
    testNocterm('should rebuild when signal changes', (tester) async {
      final count = signal(0);

      await tester.pumpComponent(_TestWatchBuilderNew(count: count));

      expect(tester.terminalState, containsText('Value: 0'));

      count.value = 42;
      await tester.pump();

      expect(tester.terminalState, containsText('Value: 42'));
    });

    testNocterm('should pass child to builder', (tester) async {
      final count = signal(0);

      await tester.pumpComponent(_TestWatchBuilderWithChild(count: count));

      expect(tester.terminalState, containsText('Value: 0'));
      expect(tester.terminalState, containsText('Static Child'));

      count.value = 10;
      await tester.pump();

      expect(tester.terminalState, containsText('Value: 10'));
      expect(tester.terminalState, containsText('Static Child'));
    });
  });

  group('watchSignal', () {
    testNocterm('should rebuild when signal changes', (tester) async {
      final count = signal(0);

      await tester.pumpComponent(_TestWatchSignal(count: count));

      expect(tester.terminalState, containsText('Count: 0'));

      count.value = 7;
      await tester.pump();

      expect(tester.terminalState, containsText('Count: 7'));
    });

    testNocterm('watch/unwatch/watch cycle should work', (tester) async {
      final count = signal(0);

      await tester.pumpComponent(_TestWatchUnwatchWatch(count: count));

      expect(tester.terminalState, containsText('Count: 0'));

      // First change should trigger rebuild
      count.value = 1;
      await tester.pump();
      expect(tester.terminalState, containsText('Count: 1'));
    });
  });

  group('Edge Cases', () {
    testNocterm('rapid signal updates should not cause issues', (tester) async {
      final count = signal(0);

      await tester.pumpComponent(_TestWatch(count: count));

      // Rapid updates
      for (var i = 0; i < 100; i++) {
        count.value = i;
      }
      await tester.pump();

      expect(tester.terminalState, containsText('Count: 99'));
    });

    testNocterm('multiple signals should all trigger rebuilds', (tester) async {
      final a = signal(0);
      final b = signal(0);

      await tester.pumpComponent(_TestMultipleSignals(a: a, b: b));

      expect(tester.terminalState, containsText('A: 0, B: 0'));

      a.value = 1;
      await tester.pump();
      expect(tester.terminalState, containsText('A: 1, B: 0'));

      b.value = 2;
      await tester.pump();
      expect(tester.terminalState, containsText('A: 1, B: 2'));
    });

    testNocterm('effects should run when dependencies change', (tester) async {
      var effectRan = 0;

      await tester.pumpComponent(_TestEffect(
        onEffect: () => effectRan++,
      ));

      // Effect runs on init
      expect(effectRan, equals(1));

      // Trigger rebuild by sending a key
      await tester.sendKey(LogicalKey.space);

      // Effect should run again
      expect(effectRan, equals(2));
    });
  });
}

// Test Components

class _TestCounter extends StatefulComponent {
  const _TestCounter({required this.count});

  final Signal<int> count;

  @override
  State<_TestCounter> createState() => _TestCounterState();
}

class _TestCounterState extends State<_TestCounter> with SignalsMixin {
  @override
  void initState() {
    super.initState();
    bindSignal(component.count);
  }

  @override
  Component build(BuildContext context) {
    return Text('Count: ${component.count.value}');
  }
}

class _TestComputedCounter extends StatefulComponent {
  const _TestComputedCounter();

  @override
  State<_TestComputedCounter> createState() => _TestComputedCounterState();
}

class _TestComputedCounterState extends State<_TestComputedCounter>
    with SignalsMixin {
  late final _count = createSignal(0);
  late final _doubled = createComputed(() => _count() * 2);

  @override
  Component build(BuildContext context) {
    return Focusable(
      focused: true,
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKey.space) {
          _count.value++;
          return true;
        }
        return false;
      },
      child: Text('Count: ${_count()}, Doubled: ${_doubled()}'),
    );
  }
}

class _TestLocalSignal extends StatefulComponent {
  const _TestLocalSignal();

  @override
  State<_TestLocalSignal> createState() => _TestLocalSignalState();
}

class _TestLocalSignalState extends State<_TestLocalSignal> with SignalsMixin {
  late final _count = createSignal(0);

  @override
  Component build(BuildContext context) {
    return Text('Count: ${_count()}');
  }
}

class _TestWatch extends StatelessComponent {
  const _TestWatch({required this.count});

  final Signal<int> count;

  @override
  Component build(BuildContext context) {
    return Watch((context) => Text('Count: ${count()}'));
  }
}

class _TestWatchBuilder2 extends StatelessComponent {
  const _TestWatchBuilder2({required this.count});

  final Signal<int> count;

  @override
  Component build(BuildContext context) {
    return Watch.builder(
      builder: (context) => Text('Count: ${count()}'),
    );
  }
}

class _TestWatchWithDeps extends StatelessComponent {
  const _TestWatchWithDeps({required this.count, required this.dep});

  final Signal<int> count;
  final Signal<int> dep;

  @override
  Component build(BuildContext context) {
    return Watch(
      (context) => Text('Count: ${count()}, Dep: ${dep()}'),
      dependencies: [dep],
    );
  }
}

class _TestNestedWatch extends StatelessComponent {
  const _TestNestedWatch({required this.outer, required this.inner});

  final Signal<int> outer;
  final Signal<int> inner;

  @override
  Component build(BuildContext context) {
    return Watch((context) => Column(
      children: [
        Text('Outer: ${outer()}'),
        Watch((context) => Text('Inner: ${inner()}')),
      ],
    ));
  }
}

class _TestWatchBuilderNew extends StatelessComponent {
  const _TestWatchBuilderNew({required this.count});

  final Signal<int> count;

  @override
  Component build(BuildContext context) {
    return WatchBuilder(
      builder: (context, child) => Text('Value: ${count()}'),
    );
  }
}

class _TestWatchBuilderWithChild extends StatelessComponent {
  const _TestWatchBuilderWithChild({required this.count});

  final Signal<int> count;

  @override
  Component build(BuildContext context) {
    return WatchBuilder(
      child: const Text('Static Child'),
      builder: (context, child) => Column(
        children: [
          Text('Value: ${count()}'),
          if (child != null) child,
        ],
      ),
    );
  }
}

class _TestWatchSignal extends StatelessComponent {
  const _TestWatchSignal({required this.count});

  final Signal<int> count;

  @override
  Component build(BuildContext context) {
    final value = count.watch(context);
    return Text('Count: $value');
  }
}

class _TestWatchUnwatchWatch extends StatefulComponent {
  const _TestWatchUnwatchWatch({required this.count});

  final Signal<int> count;

  @override
  State<_TestWatchUnwatchWatch> createState() => _TestWatchUnwatchWatchState();
}

class _TestWatchUnwatchWatchState extends State<_TestWatchUnwatchWatch> with SignalsMixin {
  @override
  void initState() {
    super.initState();
    // Watch, unwatch, then watch again
    bindSignal(component.count);
    unbindSignal(component.count);
    bindSignal(component.count);
  }

  @override
  Component build(BuildContext context) {
    return Text('Count: ${component.count.value}');
  }
}

class _TestMultipleSignals extends StatelessComponent {
  const _TestMultipleSignals({required this.a, required this.b});

  final Signal<int> a;
  final Signal<int> b;

  @override
  Component build(BuildContext context) {
    return Watch((context) => Text('A: ${a()}, B: ${b()}'));
  }
}

class _TestEffect extends StatefulComponent {
  const _TestEffect({required this.onEffect});

  final void Function() onEffect;

  @override
  State<_TestEffect> createState() => _TestEffectState();
}

class _TestEffectState extends State<_TestEffect> with SignalsMixin {
  late final _count = createSignal(0);

  @override
  void initState() {
    super.initState();
    createEffect(() {
      _count(); // Track dependency
      component.onEffect();
    });
  }

  @override
  Component build(BuildContext context) {
    return Focusable(
      focused: true,
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKey.space) {
          _count.value++;
          return true;
        }
        return false;
      },
      child: Text('Count: ${_count()}'),
    );
  }
}
