import 'package:signals_types/signals_types.dart';

import 'effect.dart';

class SimpleSignal<T> extends Signal<T> {
  bool _dirty = true;
  SimpleSignal(this._value, [this.options = const SignalOptions()]);
  T _value;

  @override
  SignalOptions<T> options;

  @override
  T get value {
    if (!_dirty) return _value;
    for (final listenable in listenables) {
      listenable.notify();
    }
    _dirty = false;
    return _value;
  }

  @override
  set value(T value) {
    if (options.equalityCheck(peek(), value)) return;
    _value = value;
    _dirty = true;
  }

  @override
  T peek() => _value;

  @override
  EffectCleanup subscribe(void Function(T value) fn) {
    final effect = SimpleEffect(() => fn(value));
    addListenable(effect);
    return effect();
  }

  @override
  bool isDirty() => _dirty;

  @override
  List<Listenable> listenables = [];

  @override
  void addListenable(Listenable listenable) {
    listenables.add(listenable);
  }

  @override
  void removeListenable(Listenable listenable) {
    listenables.remove(listenable);
  }
}
