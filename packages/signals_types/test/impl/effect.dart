import 'package:signals_types/signals_types.dart';

class SimpleEffect extends Effect {
  @override
  final EffectCallback callback;

  SimpleEffect(this.callback, [this.options = const EffectOptions()]);

  @override
  bool needsToRecompute() {
    for (final source in sources) {
      if (source.isDirty()) return true;
    }
    return true;
  }

  @override
  EffectOptions options;

  @override
  void addSource(ReadonlySignal source) {
    sources.add(source);
  }

  @override
  void removeSource(ReadonlySignal source) {
    sources.remove(source);
  }

  @override
  List<ReadonlySignal> sources = [];

  @override
  void dispose() {
    for (final source in sources) {
      source.removeListenable(this);
    }
  }

  @override
  void notify() {
    callback();
  }
}
