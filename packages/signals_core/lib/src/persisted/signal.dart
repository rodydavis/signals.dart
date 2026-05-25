import 'dart:async';
import 'dart:convert';

import '../core/signals.dart';
import 'store.dart';

/// A signal that persists its value in a key-value store.
class PersistedSignal<T> extends Signal<T> with PersistedSignalMixin<T> {
  /// Creates a new `PersistedSignal`.
  PersistedSignal(
    super.internalValue, {
    required this.key,
    required this.store,
    PersistedSignalOptions<T>? options,
    @Deprecated('Use options: PersistedSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: PersistedSignalOptions(name: ...) instead')
    String? debugLabel,
    bool autoInit = true,
  }) : super(
          options: options ??
              PersistedSignalOptions<T>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        ) {
    if (autoInit) init().ignore();
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
    return decode(val);
  }

  /// Saves the value to the store.
  Future<void> save(T value) async {
    final str = encode(value);
    await store.setItem(key, str);
  }

  /// Decodes the value from a string.
  T decode(String value) => jsonDecode(value);

  /// Encodes the value to a string.
  String encode(T value) => jsonEncode(value);
}

/// Configuration options for a [PersistedSignal].
class PersistedSignalOptions<T> extends SignalOptions<T> {
  /// Creates a new [PersistedSignalOptions] instance.
  const PersistedSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
  });

  @override
  PersistedSignalOptions<T> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return PersistedSignalOptions<T>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PersistedSignalOptions<T> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(name, autoDispose, watched, unwatched);
}
