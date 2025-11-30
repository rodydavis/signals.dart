import 'package:flutter/foundation.dart';
import 'package:signals_core/signals_core.dart' as core;

import '../mixins/value_notifier.dart';
import 'readonly.dart';

/// Simple writeable single
class FlutterSignal<T> extends core.Signal<T>
    with ValueNotifierSignalMixin<T>
    implements ValueNotifier<T>, FlutterReadonlySignal<T> {
  /// Simple writeable signal.
  ///
  /// ```dart
  /// final count = signal(0);
  /// print(count.value); // 0
  /// count.value++;
  /// print(count.value); // 1
  /// ```
  FlutterSignal(
    super.value, {
    super.options,
    this.runCallbackOnListen = false,
  });

  /// Lazy signal that can be created with type T that
  /// the value will be assigned later.
  ///
  /// ```dart
  /// final db = FlutterSignal.lazy<DatabaseConnection>();
  /// ...
  /// db.value = DatabaseConnect(...);
  /// ```
  FlutterSignal.lazy({
    super.options,
    this.runCallbackOnListen = false,
  }) : super.lazy();

  @override
  bool runCallbackOnListen;
}

/// Simple signal that can be created with type T that
/// can read and write a value.
///
/// ```dart
/// final count = signal(0);
/// print(count.value); // 0
/// count.value++;
/// print(count.value); // 1
/// ```
FlutterSignal<T> signal<T>(
  T value, {
  String? debugLabel,
  bool autoDispose = false,
  bool runCallbackOnListen = false,
  core.SignalOptions<T>? options,
}) {
  return FlutterSignal<T>(
    value,
    options: options ??
        core.SignalOptions<T>(
          name: debugLabel,
          autoDispose: autoDispose,
        ),
    runCallbackOnListen: runCallbackOnListen,
  );
}

/// Create a [Signal] that is bound to a [ValueListenable]
FlutterSignal<T> lazySignal<T>({
  core.SignalOptions<T>? options,
}) {
  return FlutterSignal<T>.lazy(
    options: options,
  );
}
