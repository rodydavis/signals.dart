import 'signals.dart';

/// Signal container used to create signals based on args
class SignalContainer<T, Arg> {
  /// If true then signals will be cached when created
  final bool cache;

  final Map<Arg, ReadonlySignal<T>> _cache = {};

  final ReadonlySignal<T> Function(Arg) _create;

  /// Signal container used to create multiple signals via args
  SignalContainer(
    this._create, {
    this.cache = false,
  });

  /// Create the signal with the given args
  ReadonlySignal<T> call(Arg arg) {
    if (cache) {
      return _cache.putIfAbsent(arg, () => _create(arg));
    } else {
      return _create(arg);
    }
  }

  /// Dispose of all created signals
  void dispose() {
    for (final signal in _cache.values) {
      signal.dispose();
    }
  }

  /// Clear the cache
  void clear() {
    _cache.clear();
  }
}

/// Create a signal container used to instance signals based on args
///
/// ```dart
/// final container = signalContainer<Cache, String>((e) {
///   return signal(Cache(e));
/// });
///
/// final cacheA = container('cache-a');
/// final cacheB = container('cache-b');
/// final cacheC = container('cache-c');
/// ```
SignalContainer<T, Arg> signalContainer<T, Arg>(
  ReadonlySignal<T> Function(Arg) create, {
  bool cache = false,
}) {
  return SignalContainer<T, Arg>(
    create,
    cache: cache,
  );
}
