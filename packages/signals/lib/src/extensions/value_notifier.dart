import 'package:flutter/foundation.dart';

import '../signals.dart';

/// Extension on [ValueNotifier] to provide helpful methods for signals
extension SignalValueNotifierUtils<T> on ValueNotifier<T> {
  /// Convert an existing [ValueNotifier] to [Signal]
  Signal<T> toSignal({String? label}) {
    final s = signal<T>(value, label: label);
    addListener(() => s.value = value);
    s.subscribe((_) => value = s.value);
    return s;
  }
}
