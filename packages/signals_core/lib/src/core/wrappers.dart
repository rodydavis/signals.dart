import 'signals.dart';

/// Wrap a [ReadonlySignal] and implement the same API
class WrappedReadonlySignal<T, S extends ReadonlySignal<T>>
    implements ReadonlySignal<T> {
  /// Internal source signal
  final S source;

  /// Wrap a [ReadonlySignal] and implement the same API
  WrappedReadonlySignal(this.source);

  @override
  bool get disposed => source.disposed;

  @override
  set disposed(bool value) => source.disposed = value;

  @override
  bool get autoDispose => source.autoDispose;

  @override
  String? get debugLabel => source.debugLabel;

  @override
  T get() => source.get();

  @override
  int get globalId => source.globalId;

  @override
  T get initialValue => source.initialValue;

  @override
  T? get previousValue => source.previousValue;

  @override
  EffectCleanup onDispose(void Function() cleanup) => source.onDispose(cleanup);

  @override
  T peek() => source.peek();

  @override
  EffectCleanup subscribe(void Function(T value) fn) => source.subscribe(fn);

  @override
  dynamic toJson() => source.toJson();

  @override
  T call() => source.call();

  @override
  String toString() => source.toString();

  @override
  T get value => source.value;

  @override
  int get version => source.version;

  @override
  void dispose() => source.dispose();

  @override
  Iterable<SignalListenable> get targets => source.targets;

  @override
  bool get hasTargets => source.hasTargets;

  @override
  bool get isInitialized => source.isInitialized;
}

/// Wrap a [Signal] and implement the same API
class WrappedSignal<T> extends WrappedReadonlySignal<T, Signal<T>>
    implements Signal<T> {
  /// Wrap a [Signal] and implement the same API
  WrappedSignal(super.source);

  @override
  @Deprecated('use .set(..., force: true) instead')
  void forceUpdate([T? val]) => source.forceUpdate(val);

  @override
  Signal<T> overrideWith(T value) => source.overrideWith(value);

  @override
  ReadonlySignal<T> readonly() => source.readonly();

  /// Optional method to check if to values are the same
  @override
  bool Function(T a, T b) equalityCheck = (T a, T b) => a == b;

  @override
  bool set(
    T val, {
    bool force = false,
  }) {
    return source.set(val, force: force);
  }

  @override
  set value(T val) => source.value = val;

  @override
  get untrackedValue => untracked(() => source.value);
}
