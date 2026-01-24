import 'package:reactivity_benchmark/run_framework_bench.dart';
import 'package:signals_core/signals_core.dart' as signals_core;
import 'package:reactivity_benchmark/reactive_framework.dart';
import 'package:reactivity_benchmark/utils/create_computed.dart';
import 'package:reactivity_benchmark/utils/create_signal.dart';

final class _SignalsReactiveFramework extends ReactiveFramework {
  const _SignalsReactiveFramework()
      : super('[signals_core](https://pub.dev/packages/signals_core)');

  @override
  Computed<T> computed<T>(T Function() fn) {
    final inner = signals_core.computed(fn);
    return createComputed(() => inner.value);
  }

  @override
  void effect(void Function() fn) {
    signals_core.effect(fn);
  }

  @override
  Signal<T> signal<T>(T value) {
    final inner = signals_core.signal(value);
    return createSignal(
      () => inner.value,
      (value) => inner.value = value,
    );
  }

  @override
  void withBatch<T>(T Function() fn) {
    signals_core.batch(fn);
  }

  @override
  T withBuild<T>(T Function() fn) => fn();
}

void main() {
  signals_core.SignalsObserver.instance = null;
  runFrameworkBench(const _SignalsReactiveFramework());
}
