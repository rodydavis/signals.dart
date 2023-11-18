part of 'signals.dart';

typedef EffectCallback = void Function();

final _effectQueue = Queue<Effect>();

class Effect implements _Listenable {
  Effect(this._effectFn) {
    _isStale = true;
    _execute();
  }

  final EffectCallback _effectFn;
  bool _isStale = false;

  void _execute() {
    if (_isStale) {
      _currentAccessed = this;
      _effectFn();
      _currentAccessed = null;
    }
    _isStale = false;
  }

  @override
  void _update() {
    if (!_isStale) {
      _isStale = true;
      _effectQueue.addLast(this);
    }
  }
}

void _executeEffects() {
  while (_effectQueue.isNotEmpty) {
    final effect = _effectQueue.removeFirst();
    effect._execute();
  }
}
