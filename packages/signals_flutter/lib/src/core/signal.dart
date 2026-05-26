import 'package:flutter/foundation.dart';
import 'package:signals_core/signals_core.dart' as core;

import '../mixins/value_notifier.dart';
import 'readonly.dart';

/// A mutable, reactive state cell that exposes both standard Signals and Flutter
/// [ValueNotifier] interfaces.
/// 
/// `FlutterSignal` extends the core `Signal` class and mixes in `ValueNotifierSignalMixin`,
/// making it completely interoperable with Flutter's build pipelines and widgets that expect
/// a [ValueNotifier] or [ValueListenable].
/// 
/// ### Example Usage
/// 
/// ```dart
/// final count = signal(0);
/// 
/// // Interoperates with native ValueListenable listeners:
/// count.addListener(() {
///   print('ValueNotifier update: ${count.value}');
/// });
/// 
/// count.value++; // Mutates the signal and triggers both Signals and ValueNotifier listeners.
/// ```
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
    super.internalValue, {
    super.options,
    @Deprecated('Use options: SignalOptions(autoDispose: ...) instead')
    super.autoDispose,
    @Deprecated('Use options: SignalOptions(name: ...) instead')
    super.debugLabel,
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
    @Deprecated('Use options: SignalOptions(autoDispose: ...) instead')
    super.autoDispose,
    @Deprecated('Use options: SignalOptions(name: ...) instead')
    super.debugLabel,
    this.runCallbackOnListen = false,
  }) : super.lazy();

  @override
  bool runCallbackOnListen;
}

/// Creates a mutable, reactive [FlutterSignal] initialized with the given [value].
/// 
/// When the value changes, all registered builders, effects, and [ValueNotifier] listeners
/// are automatically scheduled to update/rebuild.
/// 
/// ### Flutter Widget Example
/// 
/// ```dart
/// final count = signal(0);
/// 
/// class CounterView extends StatelessWidget {
///   const CounterView({super.key});
/// 
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: SignalBuilder(
///           builder: (context) => Text('Count: ${count.value}'),
///         ),
///       ),
///       floatingActionButton: FloatingActionButton(
///         onPressed: () => count.value++,
///         child: const Icon(Icons.add),
///       ),
///     );
///   }
/// }
/// ```
FlutterSignal<T> signal<T>(
  T value, {
  core.SignalOptions<T>? options,
  @Deprecated('Use options: SignalOptions(name: ...) instead')
  String? debugLabel,
  @Deprecated('Use options: SignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  bool runCallbackOnListen = false,
}) {
  return FlutterSignal<T>(
    value,
    options: options,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    runCallbackOnListen: runCallbackOnListen,
  );
}

/// Creates a lazy, mutable [FlutterSignal] of type [T] whose value can be assigned later.
/// 
/// :::caution
/// Reading a lazy signal's value before it has been initialized will throw a runtime error.
/// :::
/// 
/// ### Example
/// 
/// ```dart
/// final database = lazySignal<DatabaseConnection>();
/// 
/// // Initialize later (e.g. in initState or async initialization):
/// database.value = await connectToDatabase();
/// 
/// // Now it is safe to read:
/// print('Connected to: ${database.value.host}');
/// ```
FlutterSignal<T> lazySignal<T>({
  core.SignalOptions<T>? options,
  @Deprecated('Use options: SignalOptions(name: ...) instead')
  String? debugLabel,
  @Deprecated('Use options: SignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  bool runCallbackOnListen = false,
}) {
  return FlutterSignal<T>.lazy(
    options: options,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    runCallbackOnListen: runCallbackOnListen,
  );
}
