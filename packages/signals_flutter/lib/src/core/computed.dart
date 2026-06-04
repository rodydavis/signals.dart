import 'package:flutter/foundation.dart';
import 'package:signals_core/signals_core.dart' as core;

import '../mixins/value_listenable.dart';
import 'readonly.dart';

/// A read-only reactive signal whose value is automatically computed and cached
/// based on other signals it depends on.
///
/// `FlutterComputed` extends the core `Computed` signal and implements Flutter's
/// [ValueListenable], making it seamlessly compatible with native Flutter widgets
/// (like `ValueListenableBuilder`) and other ecosystem packages.
///
/// ### Example Usage
///
/// ```dart
/// final count = signal(2);
/// final doubled = computed(() => count.value * 2);
///
/// print(doubled.value); // 4
/// count.value = 5;
/// print(doubled.value); // 10
/// ```
///
/// ### Custom Signals
/// To create a custom signal that behaves like a computed value and implements [ValueListenable],
/// you can extend `FlutterComputed` directly or mix in `ValueListenableSignalMixin`.
class FlutterComputed<T> extends core.Computed<T>
    with ValueListenableSignalMixin<T>
    implements ValueListenable<T>, FlutterReadonlySignal<T> {
  /// Create a new signal that is computed based on the values of other signals.
  ///
  /// The returned computed signal is read-only, and its value is automatically
  /// updated when any signals accessed from within the callback function change.
  FlutterComputed(
    super.internalValue, {
    super.options,
    @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead')
    super.autoDispose,
    @Deprecated('Use options: ComputedOptions(name: ...) instead')
    super.debugLabel,
    this.runCallbackOnListen = false,
  });

  @override
  bool runCallbackOnListen;
}

/// Creates a new [FlutterComputed] signal that recalculates its value dynamically
/// based on the signals accessed inside the [compute] callback.
///
/// The returned computed signal is read-only and cached. It will only re-evaluate
/// when one of its tracked dependencies changes.
///
/// ### Flutter Example
///
/// ```dart
/// final firstName = signal('John');
/// final lastName = signal('Doe');
///
/// // Automatically combines both signals and caches the result:
/// final fullName = computed(() => '${firstName.value} ${lastName.value}');
///
/// // Usage inside a widget build:
/// @override
/// Widget build(BuildContext context) {
///   return SignalBuilder(
///     builder: (context) => Text('Hello, ${fullName.value}!'),
///   );
/// }
/// ```
FlutterComputed<T> computed<T>(
  T Function() compute, {
  core.ComputedOptions<T>? options,
  @Deprecated('Use options: ComputedOptions(name: ...) instead')
  String? debugLabel,
  @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead')
  bool? autoDispose,
  bool runCallbackOnListen = false,
}) {
  return FlutterComputed<T>(
    compute,
    options: options,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    runCallbackOnListen: runCallbackOnListen,
  );
}
