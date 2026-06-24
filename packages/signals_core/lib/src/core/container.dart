import '../value/value.dart';
import 'signals.dart';
import '../async/future.dart';
import '../async/mutation.dart';
import '../async/state.dart';
import '../async/stream.dart';

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
class SignalContainer<T, Arg, S extends ReadonlySignalMixin<T>> {
  /// If true then signals will be cached when created
  final bool cache;

  /// Optional callback when a signal is removed/evicted from the cache
  final void Function(Arg key, S signal)? onEvict;

  /// Store of created signals (if cache is true)
  final store = mapSignal<Arg, S>({});

  final S Function(Arg) _create;

  /// Signal container used to create multiple signals via args
  SignalContainer(
    this._create, {
    this.cache = false,
    this.onEvict,
  });

  /// Create the signal with the given args
  S call(Arg arg) {
    if (cache) {
      return untracked(
        () => store.putIfAbsent(arg, () {
          final t = _create(arg);
          if (t is SignalsAutoDisposeMixin) {
            (t as SignalsAutoDisposeMixin)
                .onDispose(() => untracked(() => remove(arg)));
          }
          return t;
        }),
      );
    } else {
      return _create(arg);
    }
  }

  /// Remove a signal from the cache
  S? remove(Arg arg) {
    final signal = store.remove(arg);
    if (signal != null) {
      onEvict?.call(arg, signal);
    }
    return signal;
  }

  /// Check if signal is currently stored in the cache
  bool containsKey(Arg arg) => store.containsKey(arg);

  /// Clear the cache
  void clear() {
    if (onEvict != null) {
      for (final entry in store.entries) {
        onEvict!(entry.key, entry.value);
      }
    }
    store.clear();
  }

  /// Dispose of all created signals
  void dispose() {
    if (onEvict != null) {
      for (final entry in store.entries) {
        onEvict!(entry.key, entry.value);
      }
    }
    for (final signal
        in store.values.whereType<SignalsAutoDisposeMixin>().toList()) {
      signal.dispose();
    }
    store.dispose();
  }

  /// Returns the number of cached signals.
  int get length => store.length;

  /// Returns true if the cache is empty.
  bool get isEmpty => store.isEmpty;

  /// Returns true if the cache is not empty.
  bool get isNotEmpty => store.isNotEmpty;

  /// Returns all currently cached keys.
  Iterable<Arg> get keys => store.keys;

  /// Returns all currently cached signals.
  Iterable<S> get values => store.values;

  /// Returns all currently cached entries.
  Iterable<MapEntry<Arg, S>> get entries => store.entries;

  /// Retrieve the cached signal for [arg] if it exists, without creating a new one if it is missing.
  S? lookup(Arg arg) => store[arg];

  /// Filter and remove matching cached signals.
  void removeWhere(bool Function(Arg key, S signal) test) {
    final toRemove = <Arg>[];
    for (final entry in store.entries) {
      if (test(entry.key, entry.value)) {
        toRemove.add(entry.key);
      }
    }
    for (final key in toRemove) {
      remove(key);
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
  void Function(Arg key, ReadonlySignal<T> signal)? onEvict,
}) {
  return SignalContainer<T, Arg, ReadonlySignal<T>>(
    create,
    cache: cache,
    onEvict: onEvict,
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
  void Function(Arg key, Signal<T> signal)? onEvict,
}) {
  return SignalContainer<T, Arg, Signal<T>>(
    create,
    cache: cache,
    onEvict: onEvict,
  );
}

/// Create a signal container for computed signals based on args.
///
/// ```dart
/// final container = computedContainer<int, int>((arg) {
///   return computed(() => sourceSignal.value * arg);
/// });
/// ```
SignalContainer<T, Arg, Computed<T>> computedContainer<T, Arg>(
  Computed<T> Function(Arg) create, {
  bool cache = false,
  void Function(Arg key, Computed<T> signal)? onEvict,
}) {
  return SignalContainer<T, Arg, Computed<T>>(
    create,
    cache: cache,
    onEvict: onEvict,
  );
}

/// Create a signal container for FutureSignals based on args.
///
/// ```dart
/// final container = futureSignalContainer<Post, int>((id) {
///   return futureSignal(() => fetchPost(id));
/// });
/// ```
SignalContainer<AsyncState<T>, Arg, FutureSignal<T>>
    futureSignalContainer<T, Arg>(
  FutureSignal<T> Function(Arg) create, {
  bool cache = false,
  void Function(Arg key, FutureSignal<T> signal)? onEvict,
}) {
  return SignalContainer<AsyncState<T>, Arg, FutureSignal<T>>(
    create,
    cache: cache,
    onEvict: onEvict,
  );
}

/// Create a signal container for StreamSignals based on args.
///
/// ```dart
/// final container = streamSignalContainer<Message, int>((roomId) {
///   return streamSignal(() => listenToRoom(roomId));
/// });
/// ```
SignalContainer<AsyncState<T>, Arg, StreamSignal<T>>
    streamSignalContainer<T, Arg>(
  StreamSignal<T> Function(Arg) create, {
  bool cache = false,
  void Function(Arg key, StreamSignal<T> signal)? onEvict,
}) {
  return SignalContainer<AsyncState<T>, Arg, StreamSignal<T>>(
    create,
    cache: cache,
    onEvict: onEvict,
  );
}

/// Create a signal container for MutationSignals based on args.
///
/// `A` is the mutation argument type, `T` the mutation result type, and `Arg`
/// the container key used to cache/look up each mutation.
///
/// ```dart
/// final container = mutationSignalContainer<Todo, void, int>((listId) {
///   return mutationSignal<Todo, void>((todo) => api.add(listId, todo));
/// }, cache: true);
///
/// container(1).mutate(myTodo); // per-list mutation, cached by listId
/// ```
SignalContainer<MutationState<T>, Arg, MutationSignal<A, T>>
    mutationSignalContainer<A, T, Arg>(
  MutationSignal<A, T> Function(Arg) create, {
  bool cache = false,
  void Function(Arg key, MutationSignal<A, T> signal)? onEvict,
}) {
  return SignalContainer<MutationState<T>, Arg, MutationSignal<A, T>>(
    create,
    cache: cache,
    onEvict: onEvict,
  );
}
