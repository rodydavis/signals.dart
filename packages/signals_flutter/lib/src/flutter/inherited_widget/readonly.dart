import 'package:flutter/widgets.dart';

import '../../../signals_flutter.dart';
import 'provider.dart';

/// Convience method to pass signals with [InheritedWidget]
class ReadonlySignalProvider<T> extends InheritedSignalProvider<T, ReadonlySignal<T>> {
  /// Create a new [ReadonlySignal] by value to provide in a widget tree
  ReadonlySignalProvider({
    super.key,
    required super.child,
    required super.create,
  }) : super();

  /// Pass a [ReadonlySignal] by value to provide in a widget tree
  const ReadonlySignalProvider.value({
    super.key,
    required super.child,
    required super.value,
  }) : super.value();

  /// Look up a singal by its type
  static ReadonlySignal<T> of<T>(BuildContext context, {bool listen = true}) {
    return InheritedSignalProvider.of<ReadonlySignalProvider<T>>(
      context,
      listen: listen,
    )!
        .instance;
  }
}
