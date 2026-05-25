import '../core/signals.dart';

/// [Sink] implementation for [Signal]
abstract mixin class SinkSignalMixin<T> implements Signal<T>, Sink<T> {
  @override
  void add(T event) {
    set(event);
  }

  @override
  void close() {
    dispose();
  }
}
