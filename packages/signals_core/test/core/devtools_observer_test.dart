import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  late DevToolsSignalsObserver observer;

  setUp(() {
    observer = DevToolsSignalsObserver();
    SignalsObserver.instance = observer;
  });

  tearDown(() {
    SignalsObserver.instance = null;
  });

  test(
      'DevToolsSignalsObserver tracks signal, computed and effect dependencies correctly',
      () {
    final s1 = signal(1, options: const SignalOptions(name: 's1'));
    final s2 = signal(2, options: const SignalOptions(name: 's2'));

    final c1 = computed(
      () {
        return s1.value + s2.value;
      },
      options: const ComputedOptions(name: 'c1'),
    );

    final calls = <int>[];
    final e1 = effect(
      () {
        calls.add(c1.value);
      },
      options: const EffectOptions(name: 'e1'),
    );

    // Initially trigger computed evaluation and effect evaluation
    expect(c1.value, 3);
    expect(calls, [3]);

    final nodes = observer.getNodes()['nodes'] as List;

    // Helper to find a node by name or id
    Map<String, dynamic>? findNode(String label) {
      for (final node in nodes) {
        if (node['label'] == label) {
          return node as Map<String, dynamic>;
        }
      }
      return null;
    }

    final s1Node = findNode('s1');
    final s2Node = findNode('s2');
    final c1Node = findNode('c1');
    final e1Node = findNode('e1');

    expect(s1Node, isNotNull);
    expect(s2Node, isNotNull);
    expect(c1Node, isNotNull);
    expect(e1Node, isNotNull);

    // Verify types
    expect(s1Node!['type'], 'signal');
    expect(s2Node!['type'], 'signal');
    expect(c1Node!['type'], 'computed');
    expect(e1Node!['type'], 'effect');

    // Verify dependencies:
    // c1 has sources s1 and s2, and target e1
    final s1Id = s1.globalId;
    final s2Id = s2.globalId;
    final c1Id = c1.globalId;

    expect(s1Node['targets']?.split(','), containsAll([c1Id.toString()]));
    expect(s2Node['targets']?.split(','), containsAll([c1Id.toString()]));

    expect(c1Node['sources']?.split(','),
        containsAll([s1Id.toString(), s2Id.toString()]));
    expect(c1Node['targets']?.split(','), isNotEmpty);

    expect(c1Id.toString(), isNotNull);
    e1();
  });
}
