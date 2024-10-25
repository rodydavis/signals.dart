class Spy<T> {
  final T Function() _spy;
  Spy(this._spy);

  int calls = 0;

  T call() {
    calls++;
    return _spy();
  }

  void resetHistory() => calls = 0;
}

class SpyWithArgs<T, A> {
  final T Function(A args) _spy;
  SpyWithArgs(this._spy);

  List<A> calls = [];

  T call(A args) {
    calls.add(args);
    return _spy(args);
  }

  A? get lastCalledWith => calls.isEmpty ? null : calls.last;
  void resetHistory() => calls.clear();
}
