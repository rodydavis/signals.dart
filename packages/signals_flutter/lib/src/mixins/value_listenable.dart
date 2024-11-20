import 'package:flutter/foundation.dart' show ValueListenable, VoidCallback;

import '../../signals_core.dart';

/// [ValueListenable] implementation for [ReadonlySignal]
mixin ValueListenableSignalMixin<T> on ReadonlySignal<T>
    implements ValueListenable<T> {
  final _listeners = <VoidCallback, void Function()>{};

  @override
  void addListener(VoidCallback listener) {
    _listeners.putIfAbsent(listener, () {
      return subscribe((_) => listener());
    });
  }

  @override
  void removeListener(VoidCallback listener) {
    final cleanup = _listeners.remove(listener);
    cleanup?.call();
  }

  @override
  void dispose() {
    super.dispose();
    _listeners.clear();
  }
}
