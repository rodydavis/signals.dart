import 'signals.dart';

/// Signal container used to create signals based on args
class SignalContainer<T, Arg, S extends ReadonlySignal<T>> {
  /// If true then signals will be cached when created
  final bool cache;

  final Map<Arg, S> _cache = {};

  final S Function(Arg) _create;

  /// Signal container used to create multiple signals via args
  SignalContainer(
    this._create, {
    this.cache = false,
  });

  /// Create the signal with the given args
  S call(Arg arg) {
    if (cache) {
      return _cache.putIfAbsent(arg, () => _create(arg));
    } else {
      return _create(arg);
    }
  }

  /// Remove a signal from the cache
  S? remove(Arg arg) {
    return _cache.remove(arg);
  }

  bool containsKey(Arg arg) {
    return _cache.containsKey(arg);
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
SignalContainer<T, Arg, ReadonlySignal<T>> signalContainer<T, Arg>(
  ReadonlySignal<T> Function(Arg) create, {
  bool cache = false,
}) {
  return SignalContainer<T, Arg, ReadonlySignal<T>>(
    create,
    cache: cache,
  );
}
