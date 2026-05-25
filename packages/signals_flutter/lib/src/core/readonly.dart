import 'package:flutter/foundation.dart';
import 'package:signals_core/signals_core.dart' as core;

import '../mixins/value_listenable.dart';
import 'signal.dart';

/// Simple writeable single
abstract class FlutterReadonlySignal<T> extends core.ReadonlySignal<T>
    with ValueListenableSignalMixin<T>
    implements ValueListenable<T> {}

/// Create a new plain readonly signal
FlutterReadonlySignal<T> readonly<T>(
  /// The initial value for the signal
  T value, {
  core.SignalOptions<T>? options,
  @Deprecated('Use options: SignalOptions(name: ...) instead')
  String? debugLabel,
  @Deprecated('Use options: SignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  bool runCallbackOnListen = false,
}) {
  return signal<T>(
    value,
    options: options,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    runCallbackOnListen: runCallbackOnListen,
  );
}
