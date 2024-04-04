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
  StreamSignal<T> toSignal({
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
}
