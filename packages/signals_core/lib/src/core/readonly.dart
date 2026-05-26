part of 'signals.dart';

/// Global callback when any signal is read.
void Function(signals.ReadonlySignal)? onSignalRead;

/// Read-only signals allow retrieving values but prevent direct mutations or state changes.
///
/// A [ReadonlySignal] is a reactive container whose value can be read but not directly modified.
/// Under the hood, a mutable [Signal] implements or can be cast/exposed as a [ReadonlySignal].
/// This is a core architectural pattern for encapsulating state in clean reactive architectures:
/// classes can modify their state internally using a private mutable `Signal`, while exposing
/// a public `ReadonlySignal` to external consumers to enforce unidirectional data flow.
///
/// Whenever the underlying value changes, any active [effect] or [computed] signal that reads this
/// signal's value will automatically re-evaluate and trigger UI/system rebuilds.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals_core/signals_core.dart';
///
/// class CounterController {
///   // Keep the mutable state private
///   final _counter = signal(0);
///
///   // Expose a public read-only signal to external consumers
///   ReadonlySignal<int> get counter => _counter;
///
///   void increment() {
///     _counter.value++;
///   }
/// }
///
/// void main() {
///   final controller = CounterController();
///
///   // React to updates from the read-only signal
///   effect(() {
///     print("Counter changed: ${controller.counter.value}");
///   });
///
///   // controller.counter.value = 10; // Error: Cannot mutate a ReadonlySignal!
///   controller.increment(); // Prints: "Counter changed: 1"
/// }
/// ```
///
/// <Info>
///   Use [ReadonlySignal] to prevent consumers of your stores or controllers from bypassing the
///   formal API methods. This guarantees predictable state flow throughout your application.
/// </Info>
abstract class ReadonlySignal<T> = signals.ReadonlySignal<T>
    with ReadonlySignalMixin<T>, SignalsAutoDisposeMixin<T>;

/// Readonly signal mixin for adding addition helper methods
mixin ReadonlySignalMixin<T> on signals.ReadonlySignal<T> {
  /// Check if a signal value is set (does not subscribe)
  bool get isInitialized;

  /// Internal hook for after a signal is created
  @internal
  void afterCreate(T val);

  /// Internal hook for after a signal is updated
  @internal
  void beforeUpdate(T val);

  /// Debug label for Debug Mode
  /// Debug label for Debug Mode
  @Deprecated('Use name instead')
  String? get debugLabel => name;

  @override
  T get value {
    onSignalRead?.call(this);
    return super.value;
  }

  @override
  T peek() {
    final prev = onSignalRead;
    onSignalRead = null;
    try {
      return super.peek();
    } finally {
      onSignalRead = prev;
    }
  }
}

/// Creates a new read-only signal initialized with [value].
///
/// This function returns a [ReadonlySignal] containing [value]. Under the hood, a mutable [Signal]
/// is created, but it is returned under the [ReadonlySignal] interface to prevent modification by clients.
///
/// This is particularly useful when you need to expose a constant reactive value, or bridge some external,
/// immutable value source into the signals reactivity system.
///
/// Parameters:
/// - [value]: The initial value held by the read-only signal.
/// - [options]: Optional configuration options (e.g., custom debug name or lifecycle callbacks).
///
/// Returns:
/// - A [ReadonlySignal] containing the initial value.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals_core/signals_core.dart';
///
/// final configUrl = readonly('https://api.example.com');
///
/// void main() {
///   effect(() {
///     print("Connecting to: ${configUrl.value}");
///   });
/// }
/// ```
///
/// <Warning>
///   If you are trying to derive a value from other signals, do not use [readonly]. Use [computed] instead
///   to ensure the derived signal automatically re-evaluates when its source signals change.
/// </Warning>
ReadonlySignal<T> readonly<T>(
  /// The initial value for the signal
  T value, {
  ReadonlySignalOptions<T>? options,
  @Deprecated('Use options: ReadonlySignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: ReadonlySignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return signal<T>(
    value,
    options: options?.toSignalOptions ??
        SignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}
