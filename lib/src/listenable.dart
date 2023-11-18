part of '../dart_signals.dart';

abstract class _Listenable {
  void _update();
}

abstract class _Notifier {
  final _listeners = <_Listenable>{};

  void _addListener(_Listenable listener) {
    _listeners.add(listener);
  }

  // ignore: unused_element
  void _removeListener(_Listenable listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener._update();
    }
  }
}
