import 'package:flutter/widgets.dart';

/// Auto dispose any signal/computed/effect created within the state class
mixin SignalsAutoDisposeMixin<T extends StatefulWidget> on State<T> {
  final _callbacks = <void Function()>{};

  void addEffectDisposeCallback(void Function() callback) {
    _callbacks.add(callback);
  }

  void removeEffectDisposeCallback(void Function() callback) {
    _callbacks.remove(callback);
  }

  void clearEffectDisposeCallbacks() {
    _callbacks.clear();
  }

  void disposeEffectDisposeCallbacks() {
    for (final callback in _callbacks) {
      callback();
    }
  }

  @override
  void dispose() {
    disposeEffectDisposeCallbacks();
    super.dispose();
  }
}
