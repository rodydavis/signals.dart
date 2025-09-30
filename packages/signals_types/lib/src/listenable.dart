import 'options.dart';
import 'readonly.dart';

abstract class Listenable {
  ListenableOptions get options;

  Iterable<ReadonlySignal> get sources;

  bool needsToRecompute();

  void notify();

  void addSource(ReadonlySignal source);

  void removeSource(ReadonlySignal source);
}

class ListenableOptions extends SignalsOptions {
  const ListenableOptions({
    super.debugLabel,
  });
}
