part of 'signals.dart';

/// Mixin to enable autodispose on a signal
mixin SignalsAutoDisposeMixin<T> on signals.ReadonlySignal<T> {
  /// Throws and error if read after dispose and can be
  /// disposed on last unsubscribe.
  bool autoDispose = false;

  /// Returns true if dispose has been called and will throw and
  /// error on value read
  bool _disposed = false;

  /// Check if the effect is disposed
  bool get disposed => _disposed;

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
  void Function() onDispose(void Function() cleanup) {
    _disposeCallbacks.add(cleanup);
    return () {
      _disposeCallbacks.remove(cleanup);
    };
  }

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
}
