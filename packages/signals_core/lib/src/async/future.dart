import 'dart:async';

import '../core/signals.dart';
import 'state.dart';
import 'stream.dart';

class FutureSignal<T> extends StreamSignal<T> {
  FutureSignal(
    Future<T> Function() callback, {
    super.initialValue,
    super.debugLabel,
    super.dependencies,
    super.equality,
    super.lazy,
  }) : super(() => callback().asStream());
}

FutureSignal<T> futureSignal<T>(
  Future<T> Function() callback, {
  T? initialValue,
  String? debugLabel,
  List<ReadonlySignal<dynamic>> dependencies = const [],
  SignalEquality<AsyncState<T>>? equality,
  bool lazy = true,
}) {
  return FutureSignal(
    callback,
    initialValue: initialValue,
    debugLabel: debugLabel,
    dependencies: dependencies,
    equality: equality,
    lazy: lazy,
  );
}
