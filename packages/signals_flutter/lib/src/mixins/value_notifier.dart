import 'package:flutter/foundation.dart' show ValueNotifier, VoidCallback;

import '../../signals_core.dart';

/// [ValueNotifier] implementation for [Signal]
mixin ValueNotifierSignalMixin<T> on Signal<T> implements ValueNotifier<T> {
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
  bool get hasListeners => _listeners.isNotEmpty;

  @override
  void notifyListeners() {
    set(value, force: true);
  }

  @override
  void dispose() {
    super.dispose();
    _listeners.clear();
  }
}
