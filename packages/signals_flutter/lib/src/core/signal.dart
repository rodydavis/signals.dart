import 'package:flutter/foundation.dart';
import 'package:signals_core/signals_core.dart' as core;

import '../mixins/value_notifier.dart';
import 'options.dart';
import 'readonly.dart';

/// Simple writeable single
class FlutterSignal<T> extends core.Signal<T>
    with ValueNotifierSignalMixin<T>
    implements ValueNotifier<T>, FlutterReadonlySignal<T> {
  /// Options used to create the signal
  final FlutterSignalOptions<T>? options;

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
    this.options,
  }) : super(options: options);

  /// Lazy signal that can be created with type T that
  /// the value will be assigned later.
  ///
  /// ```dart
  /// final db = FlutterSignal.lazy<DatabaseConnection>();
  /// ...
  /// db.value = DatabaseConnect(...);
  /// ```
  FlutterSignal.lazy({
    this.options,
  }) : super.lazy(options: options);

  @override
  bool get runCallbackOnListen => options?.runCallbackOnListen ?? false;
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
  FlutterSignalOptions<T>? options,
}) {
  return FlutterSignal<T>(
    value,
    options: options,
  );
}

/// Create a [Signal] that is bound to a [ValueListenable]
FlutterSignal<T> lazySignal<T>({
  FlutterSignalOptions<T>? options,
}) {
  return FlutterSignal<T>.lazy(
    options: options,
  );
}
