import '../core/signals.dart';

/// Get the previous and initial values used
mixin TrackedSignalMixin<T> on ReadonlySignal<T> {
  /// The initial value the signal was created with
  T get initialValue => _initialValue;
  late T _initialValue;

  /// Get the previous value (if exists)
  T? get previousValue => _previousValue;
  T? _previousValue;

  @override
  void afterCreate(T value) {
    super.afterCreate(value);
    _initialValue = value;
    _previousValue = null;
  }

  @override
  void beforeUpdate(T value) {
    final ready = isInitialized;
    super.beforeUpdate(value);
    if (ready) {
      _previousValue = internalValue;
    } else {
      afterCreate(value);
    }
  }

  // void Function() onUpdate(void Function(T currentValue, T? previousValue) cb) {
  //   return subscribe((val) {
  //     cb(val, previousValue);
  //   });
  // }
}
