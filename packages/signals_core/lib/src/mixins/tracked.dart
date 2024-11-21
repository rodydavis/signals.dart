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
      _previousValue = value;
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
