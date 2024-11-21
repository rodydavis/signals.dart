part of 'signals.dart';

/// Read only signals can just retrieve a value but not update or cause mutations
abstract class ReadonlySignal<T> = signals.ReadonlySignal<T>
    with ReadonlySignalMixin<T>;

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

  final _disposeCallbacks = <void Function()>{};

  /// Add a cleanup function to be called when the signal is disposed
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final effectCount = signal(0);
  ///
  /// final cleanup = counter.onDispose(() {
  ///  print('Counter has been disposed');
  /// });
  ///
  /// // Remove the cleanup function
  /// cleanup();
  /// ```
  EffectCleanup onDispose(void Function() cleanup) {
    _disposeCallbacks.add(cleanup);
    return () {
      _disposeCallbacks.remove(cleanup);
    };
  }

  // @override
  // bool operator ==(Object other) {
  //   return other is ReadonlySignal<T> && value == other.value;
  // }

  // @override
  // int get hashCode {
  //   return Object.hashAll([
  //     globalId.hashCode,
  //     value.hashCode,
  //   ]);
  // }

  /// Throws and error if read after dispose and can be
  /// disposed on last unsubscribe.
  bool autoDispose = false;

  /// Returns true if dispose has been called and will throw and
  /// error on value read
  bool _disposed = false;

  /// Check if the effect is disposed
  bool get disposed => _disposed;

  /// Force a signal to be disposed
  set disposed(bool value) {
    if (_disposed == value) return;
    if (!_disposed & value) dispose();
    _disposed = value;
  }

  /// Dispose the signal
  void dispose() {
    if (_disposed) return;
    for (final cleanup in _disposeCallbacks) {
      cleanup();
    }
    _disposed = true;
  }

  /// Debug label for Debug Mode
  String? get debugLabel;
}

/// Create a new plain readonly signal
ReadonlySignal<T> readonly<T>(
  /// The initial value for the signal
  T value,
) {
  return signal<T>(value);
}
