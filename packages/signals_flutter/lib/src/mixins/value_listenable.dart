import 'package:flutter/foundation.dart' show ValueListenable, VoidCallback;

import '../../signals_core.dart';

/// [ValueListenable] implementation for [ReadonlySignal]
abstract mixin class ValueListenableSignalMixin<T>
    implements ReadonlySignal<T>, ValueListenable<T> {
  final _listeners = <VoidCallback, void Function()>{};

  /// If true, the callback will be run when the listener is added
  bool get runCallbackOnListen => false;

  @override
  void addListener(VoidCallback listener) {
    if (_listeners.isEmpty) {
      onDispose(_listeners.clear);
    }
    bool first = true;
    _listeners.putIfAbsent(listener, () {
      return subscribe((_) {
        if (runCallbackOnListen) {
          listener();
        } else {
          if (!first) listener();
          first = false;
        }
      });
    });
  }

  @override
  void removeListener(VoidCallback listener) {
    final cleanup = _listeners.remove(listener);
    cleanup?.call();
  }
}
