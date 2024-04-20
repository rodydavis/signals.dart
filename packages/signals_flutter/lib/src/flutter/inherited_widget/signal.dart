import 'package:flutter/widgets.dart';

import '../../../signals_flutter.dart';
import 'provider.dart';

/// Convience method to pass signals with [InheritedWidget]
class SignalProvider<T> extends InheritedSignalProvider<T, Signal<T>>
    implements Signal<T> {
  /// Create a new [Signal] by value to provide in a widget tree
  SignalProvider({
    super.key,
    required super.child,
    required super.create,
  }) : super();

  /// Pass a [Signal] by value to provide in a widget tree
  const SignalProvider.value({
    super.key,
    required super.child,
    required super.value,
  }) : super.value();

  /// Look up a singal by its type
  static Signal<T> of<T>(BuildContext context, {bool listen = true}) {
    return InheritedSignalProvider.of<SignalProvider<T>>(
      context,
      listen: listen,
    )!
        .instance;
  }

  @override
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
  void set(T val, {bool force = false}) {
    return instance.set(val, force: force);
  }

  @override
  set value(T val) {
    instance.value = val;
  }
}
