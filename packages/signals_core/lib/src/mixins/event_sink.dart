import 'dart:async';

import '../async/state.dart';
import '../core/signals.dart';

/// [EventSink] implementation for [AsyncState]
mixin EventSinkSignalMixin<T> on Signal<AsyncState<T>> implements EventSink<T> {
  @override
  void add(T event) {
    set(AsyncState.data(event));
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    set(AsyncState.error(error, stackTrace));
  }

  @override
  void close() {
    dispose();
  }
}
