import 'dart:async';

import '../core/signals.dart';
import 'state.dart';
import 'stream.dart';

/// Creates a signal that wraps a [Future].
class FutureSignal<T> extends StreamSignal<T> {
  /// Creates a signal that wraps a [Future].
  FutureSignal(
    Future<T> Function() callback, {
    super.initialValue,
    super.debugLabel,
    super.dependencies,
    super.equality,
    super.lazy,
    super.autoDispose,
  }) : super(
          () => callback().asStream(),
          cancelOnError: true,
        );
}

/// Creates a signal that wraps a [Future].
FutureSignal<T> futureSignal<T>(
  Future<T> Function() callback, {
  T? initialValue,
  String? debugLabel,
  List<ReadonlySignal<dynamic>> dependencies = const [],
  SignalEquality<AsyncState<T>>? equality,
  bool lazy = true,
  bool autoDispose = false,
}) {
  return FutureSignal(
    callback,
    initialValue: initialValue,
    debugLabel: debugLabel,
    dependencies: dependencies,
    equality: equality,
    lazy: lazy,
    autoDispose: autoDispose,
  );
}
