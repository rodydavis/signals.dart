import 'dart:async';

import '../async/connect.dart';
import '../async/stream.dart';
import '../async/signal.dart';
import '../core/signals.dart';

/// Extension on [Stream] to provide convenient utilities to convert streams into reactive signals.
///
/// ```dart
/// import 'package:signals_core/signals_core.dart';
///
/// final myStream = Stream.periodic(Duration(seconds: 1), (x) => x).take(5);
/// final mySignal = myStream.toStreamSignal();
/// ```
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
  ///
  /// For returning a signal with the value that can be accessed sync use
  /// stream.toSyncSignal instead.
  StreamSignal<T> toStreamSignal({
    bool? cancelOnError,
    T? initialValue,
    bool lazy = true,
    List<ReadonlySignal<dynamic>> dependencies = const [],
    void Function()? onDone,
    AsyncSignalOptions<T>? options,
  }) {
    return streamSignal<T>(
      () => this,
      cancelOnError: cancelOnError,
      initialValue: initialValue,
      lazy: lazy,
      dependencies: dependencies,
      onDone: onDone,
      options: options,
    );
  }

  /// Convert a [Stream] to a synchronous [ReadonlySignal] and provide an initial value.
  ///
  /// This is different from `toStreamSignal()` because it directly feeds the stream's values
  /// into a standard `Signal<T>`, allowing you to read the bare, synchronous values directly
  /// instead of wrapping them in an [AsyncState].
  ///
  /// ```dart
  /// import 'package:signals_core/signals_core.dart';
  ///
  /// final stream = Stream.value(42);
  /// final syncSignal = stream.toSyncSignal(0);
  /// print(syncSignal.value); // 0 (initially)
  /// // After the stream emits:
  /// // print(syncSignal.value); // 42
  /// ```
  ReadonlySignal<T> toSyncSignal(T initialData) {
    final s = signal<T>(initialData);
    final connector = connect<T, T>(s);
    connector << this;
    s.onDispose(connector.dispose);
    return s;
  }
}
