import 'package:flutter/widgets.dart';

/// Auto dispose any signal/computed/effect created within the state class
mixin SignalsAutoDisposeMixin<T extends StatefulWidget> on State<T> {
  final _callbacks = <void Function()>{};

  /// Add a new effect dispose callback to call when the widget is disposed
  void addEffectDisposeCallback(void Function() callback) {
    _callbacks.add(callback);
  }

  /// Remove am effect dispose callback
  void removeEffectDisposeCallback(void Function() callback) {
    _callbacks.remove(callback);
  }

  /// Remove all effect dispose callbacks
  void clearEffectDisposeCallbacks() {
    _callbacks.clear();
  }

  /// Call all of the effect dispose callbacks
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
