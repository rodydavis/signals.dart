import 'package:flutter/widgets.dart';

import '../../../signals_flutter.dart';
import 'provider.dart';

/// Convience method to pass signals with [InheritedWidget]
class ComputedProvider<T> extends InheritedSignalProvider<T, Computed<T>>
    implements Computed<T> {
  /// Create a new [Computed] by value to provide in a widget tree
  ComputedProvider({
    super.key,
    required super.child,
    required super.create,
  }) : super();

  /// Pass a [Computed] by value to provide in a widget tree
  const ComputedProvider.value({
    super.key,
    required super.child,
    required super.value,
  }) : super.value();

  /// Look up a singal by its type
  static Computed<T> of<T>(BuildContext context, {bool listen = true}) {
    return InheritedSignalProvider.of<ComputedProvider<T>>(
      context,
      listen: listen,
    )!
        .instance;
  }

  @override
  ReadonlySignal<T> readonly() {
    return instance.readonly();
  }

  @override
  Computed<T> overrideWith(T value) {
    return instance.overrideWith(value);
  }

  @override
  void recompute() {
    return instance.recompute();
  }

  @override
  Iterable<ReadonlySignal> get sources => instance.sources;

  @override
  bool get hasSources => instance.hasSources;
}
