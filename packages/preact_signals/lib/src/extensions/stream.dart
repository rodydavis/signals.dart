import 'package:preact_signals/preact_signals.dart';

import '../stream_signal.dart';

/// Extension on stream to provide helpful methods for signals
extension SignalStreamUtils<T> on Stream<T> {
  /// Return [ReadonlySignal] from an existing stream
  StreamSignal<T> toSignal({bool? cancelOnError}) {
    return StreamSignal<T>(
      () => this,
      cancelOnError: cancelOnError,
    );
  }
}
