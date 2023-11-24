import 'package:preact_signals/preact_signals.dart';

import '../stream_signal.dart';

/// Extension on stream to provide helpful methods for signals
extension SignalStreamUtils on Stream {
  /// Return [ReadonlySignal] from an existing stream
  StreamSignal toSignal({bool? cancelOnError}) {
    return StreamSignal(
      () => this,
      cancelOnError: cancelOnError,
    );
  }
}
