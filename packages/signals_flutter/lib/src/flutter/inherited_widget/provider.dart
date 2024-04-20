import 'package:flutter/widgets.dart';

import '../../../signals_flutter.dart';

/// [ReadonlySignal] based on [InheritedWidget]
class InheritedSignalProvider<T, S extends ReadonlySignal<T>>
    extends InheritedWidget implements ReadonlySignal<T> {
  /// Create a new [ReadonlySignal] and provide it in the tree
  InheritedSignalProvider({
    super.key,
    required S Function() create,
    required super.child,
  })  : instance = create(),
        super();

  /// Pass a [ReadonlySignal] and provide it in the tree
  const InheritedSignalProvider.value({
    super.key,
    required S value,
    required super.child,
  }) : instance = value;

  /// Internal signal
  final S instance;

  @override
  bool updateShouldNotify(InheritedSignalProvider<T, S> oldWidget) {
    return oldWidget.instance.globalId == instance.globalId &&
        oldWidget.instance.version != instance.version;
  }

  @override
  InheritedSignalElement createElement() {
    return InheritedSignalElement<T, S>(this, instance: instance);
  }

  /// Find widget in tree
  static T? of<T extends InheritedWidget>(BuildContext context,
      {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<T>();
    } else {
      return context.findAncestorWidgetOfExactType<T>();
    }
  }

  @override
  bool get disposed => instance.disposed;

  @override
  set disposed(bool val) => instance.disposed = val;

  @override
  bool get autoDispose => instance.autoDispose;

  @override
  T call() => instance();

  @override
  String? get debugLabel => instance.debugLabel;

  @override
  void dispose() => instance.dispose();

  @override
  T get() => instance.get();

  @override
  int get globalId => instance.globalId;

  @override
  T get initialValue => instance.initialValue;

  @override
  T? get previousValue => instance.previousValue;

  @override
  EffectCleanup onDispose(void Function() cleanup) {
    return instance.onDispose(cleanup);
  }

  @override
  T peek() => instance.peek();

  @override
  EffectCleanup subscribe(void Function(T value) fn) {
    return instance.subscribe(fn);
  }

  @override
  Iterable<SignalListenable> get targets => instance.targets;

  @override
  T toJson() => instance.toJson();

  @override
  T get value => instance.value;

  @override
  int get version => instance.version;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return instance.toString();
  }
}

/// [ReadonlySignal] based on [InheritedElement]
class InheritedSignalElement<T, S extends ReadonlySignal<T>>
    extends InheritedElement {
  /// Internal [ReadonlySignal]
  final S instance;
  bool _dirty = false;
  EffectCleanup? _cleanup;

  /// [ReadonlySignal] based on [InheritedElement]
  InheritedSignalElement(
    super.widget, {
    required this.instance,
  }) {
    _cleanup = instance.subscribe(_update);
  }

  void _update(T val) {
    _dirty = true;
    markNeedsBuild();
  }

  @override
  Widget build() {
    if (_dirty) {
      final root = widget as InheritedSignalProvider<T, S>;
      notifyClients(root);
    }
    return super.build();
  }

  @override
  void notifyClients(covariant InheritedWidget oldWidget) {
    super.notifyClients(oldWidget);
    _dirty = false;
  }

  @override
  void unmount() {
    _cleanup?.call();
    super.unmount();
  }
}
