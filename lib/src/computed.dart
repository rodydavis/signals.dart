part of 'signals.dart';

typedef ComputedCallback<T> = T Function();

class Computed<T> extends _Notifier implements _Listenable {
  Computed(this._computeFn) {
    _isStale = true;
  }

  late T _value;
  final ComputedCallback<T> _computeFn;
  bool _isStale = false;

  T get value {
    if (_isStale) {
      final previousContext = _currentAccessed;
      _currentAccessed = this;
      _recomputeValue();
      _currentAccessed = previousContext;
    }
    if (_currentAccessed != null) {
      _addListener(_currentAccessed!);
    }
    return _value;
  }

  void _recomputeValue() {
    _value = _computeFn();
    _isStale = false;
  }

  @override
  void _update() {
    if (!_isStale) {
      _isStale = true;
      for (final listener in _listeners) {
        listener._update();
      }
    }
  }
}

