import 'dart:async';
import 'dart:convert';

import '../../signals_core.dart';
import 'store.dart';

/// A signal that persists its value in a key-value store.
class PersistedSignal<T> extends Signal<T> with PersistedSignalMixin<T> {
  /// Creates a new `PersistedSignal`.
  PersistedSignal(
    super.internalValue, {
    super.autoDispose,
    super.debugLabel,
    required this.key,
    required this.store,
  }) {
    init().ignore();
  }

  @override
  final String key;

  @override
  final SignalsKeyValueStore store;
}

/// A mixin that provides the persistence logic for a signal.
mixin PersistedSignalMixin<T> on Signal<T> {
  /// The key to use for storing the value.
  String get key;

  /// The store to use for storing the value.
  SignalsKeyValueStore get store;

  /// Whether the signal has been loaded from the store.
  bool loaded = false;

  /// Initializes the signal by loading the value from the store.
  Future<void> init() async {
    try {
      super.value = await load();
    } catch (e) {
      rethrow;
    } finally {
      loaded = true;
    }
  }

  @override
  T get value {
    if (!loaded) init().ignore();
    return super.value;
  }

  @override
  set value(T value) {
    super.value = value;
    save(value).ignore();
  }

  /// Loads the value from the store.
  Future<T> load() async {
    final val = await store.getItem(key);
    if (val == null) return value;
    return await decode(val);
  }

  /// Saves the value to the store.
  Future<void> save(T value) async {
    final str = await encode(value);
    await store.setItem(key, str);
  }

  /// Decodes the value from a string.
  FutureOr<T> decode(String value) async => jsonDecode(value);

  /// Encodes the value to a string.
  FutureOr<String> encode(T value) async => jsonEncode(value);
}
