import '../core/signals.dart';

/// [Sink] implementation for [Signal]
mixin SinkSignalMixin<T> on Signal<T> implements Sink<T> {
  @override
  void add(T event) {
    set(event);
  }

  @override
  void close() {
    dispose();
  }
}
