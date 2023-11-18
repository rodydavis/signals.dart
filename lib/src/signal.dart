part of '../dart_signals.dart';

class Signal<T> extends _Notifier {
  Signal(this._value);

  T _value;

  T get value {
    if (_currentAccessed != null) {
      _addListener(_currentAccessed!);
    }
    return _value;
  }

  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _notifyListeners();
      _executeEffects();
    }
  }
}

Signal<T> createSignal<T>(T initialValue) {
  return Signal<T>(initialValue);
}
