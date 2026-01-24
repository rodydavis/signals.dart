import 'package:reactivity_benchmark/run_framework_bench.dart';
import 'package:preact_signals/preact_signals.dart' as preact_signals;
import 'package:reactivity_benchmark/reactive_framework.dart';
import 'package:reactivity_benchmark/utils/create_computed.dart';
import 'package:reactivity_benchmark/utils/create_signal.dart';

final class _PreactSignalsReactiveFramework extends ReactiveFramework {
  const _PreactSignalsReactiveFramework()
      : super('[preact_signals](https://pub.dev/packages/preact_signals)');

  @override
  Computed<T> computed<T>(T Function() fn) {
    final inner = preact_signals.computed(() => fn());
    return createComputed(() => inner.value);
  }

  @override
  void effect(void Function() fn) {
    preact_signals.effect(fn);
  }

  @override
  Signal<T> signal<T>(T value) {
    final inner = preact_signals.signal(value);
    return createSignal(
      () => inner.value,
      (value) => inner.value = value,
    );
  }

  @override
  void withBatch<T>(T Function() fn) {
    preact_signals.batch(fn);
  }

  @override
  T withBuild<T>(T Function() fn) => fn();
}

void main() {
  runFrameworkBench(
    const _PreactSignalsReactiveFramework(),
  );
}
