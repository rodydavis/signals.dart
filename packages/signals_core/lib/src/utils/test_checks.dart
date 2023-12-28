import 'package:checks/context.dart';

import '../../signals_core.dart';

/// Extension on 'checks' test lib
extension SignalChecks<T> on Subject<ReadonlySignal<T>?> {
  /// Compare Signal<T>.peek() to ref T
  Subject<T> peeked(T ref) {
    return context.nest<T>(() => ['is not null'], (actual) {
      if (actual == null) return Extracted.rejection();
      return Extracted.value(actual.peek());
    }, atSameLevel: true);
  }
}
