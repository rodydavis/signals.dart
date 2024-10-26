// ignore: implementation_imports
import 'package:preact_signals/src/node.dart';

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
  late Symbol brand = source.brand;

  @override
  late Node? node = source.node;

  @override
  late Node? targets = source.targets;

  @override
  set autoDispose(bool val) {
    source.autoDispose = val;
  }

  @override
  bool internalRefresh() => source.internalRefresh();

  @override
  void subscribeToNode(Node node) {
    source.subscribeToNode(node);
  }

  @override
  void unsubscribeFromNode(Node node) {
    source.unsubscribeFromNode(node);
  }

  @override
  T get internalValue => source.initialValue;
}

/// Wrap a [Signal] and implement the same API
class WrappedSignal<T> extends WrappedReadonlySignal<T, Signal<T>>
    implements Signal<T> {
  /// Wrap a [Signal] and implement the same API
  WrappedSignal(super.source);

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
  late T internalValue = source.internalValue;

  @override
  late bool isInitialized = source.isInitialized;

  @override
  set initialValue(T val) {
    source.initialValue = val;
  }

  @override
  void internalSetValue(T val) {
    source.internalSetValue(val);
  }

  @override
  set version(int val) {
    source.version = val;
  }
}
