import 'package:flutter/foundation.dart' show ValueListenable, VoidCallback;

import '../../signals_core.dart';

/// [ValueListenable] implementation for [ReadonlySignal]
mixin ValueListenableSignalMixin<T> on ReadonlySignal<T>
    implements ValueListenable<T> {
  final _listeners = <VoidCallback, void Function()>{};

  /// If true, the callback will be run when the listener is added
  bool get runCallbackOnListen => false;

  @override
  void addListener(VoidCallback listener) {
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

  @override
  void dispose() {
    super.dispose();
    _listeners.clear();
  }
}
