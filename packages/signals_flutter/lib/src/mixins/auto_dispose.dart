import 'package:flutter/widgets.dart';

// coverage:ignore-start
/// Auto dispose any signal/computed/effect created within the state class
mixin SignalsAutoDisposeMixin<T extends StatefulWidget> on State<T> {
  /// Internal list of callbacks to dispose effects
  final cleanupCallbacks = <void Function()>{};

  /// Add a new effect dispose callback to call when the widget is disposed
  void addEffectDisposeCallback(void Function() callback) {
    cleanupCallbacks.add(callback);
  }

  /// Remove am effect dispose callback
  void removeEffectDisposeCallback(void Function() callback) {
    cleanupCallbacks.remove(callback);
  }

  /// Remove all effect dispose callbacks
  void clearEffectDisposeCallbacks() {
    cleanupCallbacks.clear();
  }

  /// Call all of the effect dispose callbacks
  void disposeEffectDisposeCallbacks() {
    for (final callback in cleanupCallbacks) {
      callback();
    }
  }

  @override
  void dispose() {
    disposeEffectDisposeCallbacks();
    super.dispose();
  }
}
// coverage:ignore-end
