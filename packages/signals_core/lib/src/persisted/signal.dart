import 'dart:async';
import 'dart:convert';

import '../core/signals.dart';
import 'store.dart';

/// A `Signal` whose value is persistently stored in a key-value database.
///
/// `PersistedSignal` allows application state (such as user preferences, theme options,
/// authentication tokens, and drafts) to automatically survive application restarts
/// without writing tedious boilerplate for manual loading and saving.
///
/// ### Concrete Subclasses
/// For common primitive types, use the provided concrete classes:
/// - [PersistedBoolSignal] / [PersistedNullableBoolSignal]
/// - [PersistedIntSignal] / [PersistedNullableIntSignal]
/// - [PersistedDoubleSignal] / [PersistedNullableDoubleSignal]
/// - [PersistedNumSignal] / [PersistedNullableNumSignal]
/// - [PersistedStringSignal] / [PersistedNullableStringSignal]
/// - [PersistedEnumSignal] / [PersistedNullableEnumSignal]
///
/// ### Simple Usage Example
/// ```dart
/// // 1. Create or obtain a key-value store adapter (like standard in-memory)
/// final localStore = SignalsInMemoryKeyValueStore();
///
/// // 2. Create the persisted signal with a unique key
/// final darkModeSignal = PersistedBoolSignal(
///   false, // Fallback initial value
///   key: 'settings.dark_mode',
///   store: localStore,
/// );
///
/// // 3. The value is automatically loaded asynchronously on instantiation.
/// // Mutating the value synchronously schedules an async save under the hood:
/// darkModeSignal.value = true; // Automatically persisted to store
/// ```
///
/// ### Custom Serialization / Complex Objects
/// To persist complex objects (e.g. custom classes), subclass [PersistedSignal]
/// and override the [decode] and [encode] methods, or mixin [PersistedSignalMixin]
/// on a custom [Signal] class.
///
/// ```dart
/// class User {
///   final String name;
///   final int age;
///   User(this.name, this.age);
///
///   Map<String, dynamic> toJson() => {'name': name, 'age': age};
///   factory User.fromJson(Map<String, dynamic> json) => User(json['name'], json['age']);
/// }
///
/// class PersistedUserSignal extends PersistedSignal<User> {
///   PersistedUserSignal(
///     super.internalValue, {
///     required super.key,
///     required super.store,
///   });
///
///   @override
///   User decode(String value) => User.fromJson(jsonDecode(value));
///
///   @override
///   String encode(User value) => jsonEncode(value.toJson());
/// }
/// ```
///
/// @link https://dartsignals.dev/utilities/persisted
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

/// A mixin that adds local persistence capabilities to a standard [Signal].
///
/// By mixing in `PersistedSignalMixin<T>` on a `Signal<T>` subclass, the signal
/// will automatically retrieve its stored state on boot and save its state whenever
/// `.value` is mutated.
///
/// Classes mixing in `PersistedSignalMixin<T>` must implement:
/// - [key]: A unique identifier string for the key-value database.
/// - [store]: An implementation of [SignalsKeyValueStore].
///
/// ### Serialization Customization
/// By default, the mixin uses standard JSON parsing (`jsonDecode` / `jsonEncode`).
/// If your data type `T` is not natively supported by JSON, override:
/// - [decode] to convert the raw string value back into type `T`.
/// - [encode] to serialize type `T` into a string.
///
/// @link https://dartsignals.dev/utilities/persisted
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
