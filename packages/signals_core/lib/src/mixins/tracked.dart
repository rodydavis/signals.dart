import '../core/signals.dart';

/// A mixin that adds tracking for the initial and previous values to a [Signal].
///
/// [TrackedSignalMixin] stores the `initialValue` (the value the signal had when it was
/// created or initialized) and the `previousValue` (the value of the signal right before
/// the most recent update).
///
/// :::note
/// If you are looking for full undo/redo capabilities, use [ChangeStackSignalMixin] instead.
/// :::
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// class MyTrackedSignal extends Signal<int> with TrackedSignalMixin<int> {
///   MyTrackedSignal(super.internalValue);
/// }
///
/// void main() {
///   final signal = MyTrackedSignal(0);
///
///   print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
///   print('Previous: ${signal.previousValue}'); // Prints: "Previous: null"
///
///   signal.value = 1;
///   print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
///   print('Previous: ${signal.previousValue}'); // Prints: "Previous: 0"
///
///   signal.value = 2;
///   print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
///   print('Previous: ${signal.previousValue}'); // Prints: "Previous: 1"
/// }
/// ```
///
/// :::caution
/// This mixin only works with values that are immutable or are copied/cloned on mutation.
/// If the value is mutated directly in-place without re-assigning, `initialValue` and
/// `previousValue` will end up pointing to the same modified instance as the current value.
/// :::
mixin TrackedSignalMixin<T> on ReadonlySignal<T> {
  /// The initial value the signal was created with
  T get initialValue => _initialValue;
  late T _initialValue;

  /// Get the previous value (if exists)
  T? get previousValue => _previousValue;
  T? _previousValue;

  @override
  void afterCreate(T val) {
    super.afterCreate(val);
    _initialValue = val;
    _previousValue = null;
  }

  @override
  void beforeUpdate(val) {
    final ready = isInitialized;
    super.beforeUpdate(val);
    if (ready) {
      _previousValue = internalValue;
    } else {
      afterCreate(val);
    }
  }

  // void Function() onUpdate(void Function(T currentValue, T? previousValue) cb) {
  //   return subscribe((val) {
  //     cb(val, previousValue);
  //   });
  // }
}
