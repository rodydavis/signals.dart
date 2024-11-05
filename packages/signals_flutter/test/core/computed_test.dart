import 'package:signals_flutter/signals_flutter.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  failingWithTearOff(Signal source) => computed((source.value / 2).round);
  workingWithExplicitCall(Signal source) =>
      computed(() => (source.value / 2).round());

  group('Callback invocation variants', () {
    _testDerived(workingWithExplicitCall);

    _testDerived(failingWithTearOff);
  });
}

_testDerived(ReadonlySignal Function(Signal source) deriveSignal) {
  test('Tear-off', () {
    final source = Signal(0);
    var invocations = 0;
    callback(_) => invocations++;

    final derived = deriveSignal(source);

    // no listeners running the callback yet
    expect(invocations, equals(0));
    expect(derived.peek(), equals(0));

    // start calling callback on changes
    derived.subscribe(callback);

    // initial invocation triggered by subscription start
    expect(invocations, equals(1));
    expect(derived.peek(), equals(0));

    source.set(1);

    // invocation after computed value rounded <0.5> to <1>
    expect(
      invocations,
      equals(2),
      reason: 'Value change did not trigger callback invocation',
    );
    expect(derived.peek(), equals(1));

    // no additional invocation (result unchanged)
    source.set(2);
    expect(invocations, equals(2));
    expect(derived.peek(), equals(1));
  });
}
