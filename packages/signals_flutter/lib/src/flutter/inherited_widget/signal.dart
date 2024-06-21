import 'package:flutter/widgets.dart';

import '../../../signals_flutter.dart';
import 'provider.dart';

/// Convenience method to pass signals with [InheritedWidget]
// ignore: must_be_immutable
class SignalProvider<T> extends InheritedSignalProvider<T, Signal<T>>
    implements Signal<T> {
  /// Create a new [Signal] by value to provide in a widget tree
  SignalProvider({
    super.key,
    required super.child,
    required super.create,
  }) : super();

  /// Pass a [Signal] by value to provide in a widget tree
  SignalProvider.value({
    super.key,
    required super.child,
    required super.value,
  }) : super.value();

  /// Look up a signal by its type
  static Signal<T> of<T>(BuildContext context, {bool listen = true}) {
    return InheritedSignalProvider.of<SignalProvider<T>>(
      context,
      listen: listen,
    )!
        .instance;
  }

  @override
  @Deprecated('use .set(..., force: true) instead')
  void forceUpdate([T? val]) {
    return instance.forceUpdate(val);
  }

  @override
  Signal<T> overrideWith(T value) {
    return instance.overrideWith(value);
  }

  @override
  ReadonlySignal<T> readonly() {
    return instance.readonly();
  }

  @override
  bool set(T val, {bool force = false}) {
    return instance.set(val, force: force);
  }

  @override
  set value(T val) {
    instance.value = val;
  }

  /// Optional method to check if to values are the same
  @override
  bool Function(T a, T b) equalityCheck = (a, b) => a == b;
}
