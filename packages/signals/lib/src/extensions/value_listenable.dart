import 'package:flutter/foundation.dart';

import '../signals.dart';

/// Extension on [ValueListenable] to provide helpful methods for signals
extension SignalValueListenableUtils<T> on ValueListenable<T> {
  /// Convert an existing [ValueListenable] to [ReadonlySignal]
  ReadonlySignal<T> toSignal({String? label}) {
    final s = signal<T>(value, label: label);
    addListener(() => s.value = value);
    return s;
  }
}
