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
  });

  group('WatchBuilder', () {
    testNocterm('should rebuild when signal changes', (tester) async {
      final count = signal(0);

      await tester.pumpComponent(_TestWatchBuilder(count: count));

      expect(tester.terminalState, containsText('Value: 0'));

      count.value = 42;
      await tester.pump();

      expect(tester.terminalState, containsText('Value: 42'));
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
  });
}

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

class _TestWatch extends StatelessComponent {
  const _TestWatch({required this.count});

  final Signal<int> count;

  @override
  Component build(BuildContext context) {
    return Watch((context) => Text('Count: ${count()}'));
  }
}

class _TestWatchBuilder extends StatelessComponent {
  const _TestWatchBuilder({required this.count});

  final Signal<int> count;

  @override
  Component build(BuildContext context) {
    return WatchBuilder<int>(
      signal: count,
      builder: (context, value, child) => Text('Value: $value'),
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
