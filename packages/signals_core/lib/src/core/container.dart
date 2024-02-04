import '../value/map.dart';
import 'signals.dart';

/// Signal container used to create signals based on args
///
/// ```dart
/// final container = readonlySignalContainer<Cache, String>((e) {
///   return signal(Cache(e));
/// });
///
/// final cacheA = container('cache-a');
/// final cacheB = container('cache-b');
/// final cacheC = container('cache-c');
/// ```
///
/// Example of settings and SharedPreferences:
///
/// ```dart
/// class Settings {
///   final SharedPreferences prefs;
///   EffectCleanup? _cleanup;
///
///   Settings(this.prefs) {
///     _cleanup = effect(() {
///       for (final entry in setting.store.entries) {
///         final value = entry.value.peek();
///         if (prefs.getString(entry.key.$1) != value) {
///           prefs.setString(entry.key.$1, value).ignore();
///         }
///       }
///     });
///   }
///
///   late final setting = signalContainer<String, (String, String)>(
///     (val) => signal(prefs.getString(val.$1) ?? val.$2),
///     cache: true,
///   );
///
///   Signal<String> get darkMode => setting(('dark-mode', 'false'));
///
///   void dispose() {
///     _cleanup?.call();
///     setting.dispose();
///   }
/// }
///
///void main() {
///  // Load or find instance
///  late final SharedPreferences prefs = ...;
///
///  // Create settings
///  final settings = Settings(prefs);
///
///  // Get value
///  print('dark mode: ${settings.darkMode}');
///
///  // Update value
///  settings.darkMode.value = 'true';
///}
/// ```
class SignalContainer<T, Arg, S extends ReadonlySignal<T>> {
  /// If true then signals will be cached when created
  final bool cache;

  final store = mapSignal<Arg, S>({});

  final S Function(Arg) _create;

  /// Signal container used to create multiple signals via args
  SignalContainer(
    this._create, {
    this.cache = false,
  });

  /// Create the signal with the given args
  S call(Arg arg) {
    if (cache) {
      return store.putIfAbsent(arg, () {
        return _create(arg)..onDispose((_) => store.remove(arg));
      });
    } else {
      return _create(arg);
    }
  }

  /// Remove a signal from the cache
  S? remove(Arg arg) => store.remove(arg);

  /// Check if signal is currently stored in the cache
  bool containsKey(Arg arg) => store.containsKey(arg);

  /// Clear the cache
  void clear() => store.clear();

  /// Dispose of all created signals
  void dispose() {
    for (final signal in store.values) {
      signal.dispose();
    }
  }
}

/// Create a signal container used to instance signals based on args
///
/// ```dart
/// final container = readonlySignalContainer<Cache, String>((e) {
///   return signal(Cache(e));
/// });
///
/// final cacheA = container('cache-a');
/// final cacheB = container('cache-b');
/// final cacheC = container('cache-c');
/// ```
///
/// The signals cannot be updated but allows for
/// using computed where the value is only derived from other signals.
SignalContainer<T, Arg, ReadonlySignal<T>> readonlySignalContainer<T, Arg>(
  ReadonlySignal<T> Function(Arg) create, {
  bool cache = false,
}) {
  return SignalContainer<T, Arg, ReadonlySignal<T>>(
    create,
    cache: cache,
  );
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
///
/// cacheA.value = 'a';
/// cacheB.value = 'b';
/// cacheC.value = 'c';
/// ```
SignalContainer<T, Arg, Signal<T>> signalContainer<T, Arg>(
  Signal<T> Function(Arg) create, {
  bool cache = false,
}) {
  return SignalContainer<T, Arg, Signal<T>>(
    create,
    cache: cache,
  );
}
