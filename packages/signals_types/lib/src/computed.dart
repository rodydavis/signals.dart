import 'readonly.dart';
import 'listenable.dart';

abstract class Computed<T> extends ReadonlySignal<T> implements Listenable {
  @override
  ComputedOptions<T> get options;

  T Function() get compute;

  ComputedError? error;
}

class ComputedError implements Error {
  Object? error;

  @override
  StackTrace? stackTrace;

  ComputedError(this.error, this.stackTrace);
}

class ComputedOptions<T> extends ReadonlySignalOptions<T>
    implements ListenableOptions {
  const ComputedOptions({
    super.debugLabel,
  });
}
