import 'dart:async';

import '../async/connect.dart';
import '../async/stream.dart';
import '../core/signals.dart';

/// Extension on stream to provide helpful methods for signals
extension SignalStreamUtils<T> on Stream<T> {
  /// Convert a stream to a signal
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// Stream<int> createStream() async* {
  ///     yield 1;
  ///     yield 2;
  ///     yield 3;
  /// }
  /// final stream = createStream();
  /// final signal = stream.toSignal();
  /// ```
  @Deprecated('use [toStreamSignal] instead')
  StreamSignal<T> toSignal({
    bool? cancelOnError,
    String? debugLabel,
    T? initialValue,
    bool autoDispose = false,
    bool lazy = true,
    List<ReadonlySignal<dynamic>> dependencies = const [],
    void Function()? onDone,
  }) {
    return toStreamSignal(
      cancelOnError: cancelOnError,
      debugLabel: debugLabel,
      initialValue: initialValue,
      autoDispose: autoDispose,
      lazy: lazy,
      dependencies: dependencies,
      onDone: onDone,
    );
  }

  /// Convert a stream to a signal
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// Stream<int> createStream() async* {
  ///     yield 1;
  ///     yield 2;
  ///     yield 3;
  /// }
  /// final stream = createStream();
  /// final signal = stream.toSignal();
  /// ```
  ///
  /// For returning a signal with the value that can be accessed sync use
  /// stream.toSyncSignal instead.
  StreamSignal<T> toStreamSignal({
    bool? cancelOnError,
    String? debugLabel,
    T? initialValue,
    bool autoDispose = false,
    bool lazy = true,
    List<ReadonlySignal<dynamic>> dependencies = const [],
    void Function()? onDone,
  }) {
    return streamSignal<T>(
      () => this,
      cancelOnError: cancelOnError,
      debugLabel: debugLabel,
      initialValue: initialValue,
      autoDispose: autoDispose,
      lazy: lazy,
      dependencies: dependencies,
      onDone: onDone,
    );
  }

  /// Convert a [Stream] to [ReadonlySignal] and provide initial value.
  ///
  /// This is different than stream.toStreamSignal() that wraps
  /// the stream events in [StreamSignal].
  ReadonlySignal<T> toSyncSignal(T initialData) {
    final s = signal<T>(initialData);
    final connector = connect<T, T>(s);
    connector << this;
    s.onDispose(connector.dispose);
    return s;
  }
}
