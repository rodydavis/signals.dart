---
title: PersistedSignal
description: A Signal whose value is persistently stored in a key-value database.
---

A `Signal` whose value is persistently stored in a key-value database.

`PersistedSignal` allows application state (such as user preferences, theme options,
authentication tokens, and drafts) to automatically survive application restarts
without writing tedious boilerplate for manual loading and saving.

### Concrete Subclasses
For common primitive types, use the provided concrete classes:
- [PersistedBoolSignal](/packages/signals/utilities/persisted) / [PersistedNullableBoolSignal](/packages/signals/utilities/persisted)
- [PersistedIntSignal](/packages/signals/utilities/persisted) / [PersistedNullableIntSignal](/packages/signals/utilities/persisted)
- [PersistedDoubleSignal](/packages/signals/utilities/persisted) / [PersistedNullableDoubleSignal](/packages/signals/utilities/persisted)
- [PersistedNumSignal](/packages/signals/utilities/persisted) / [PersistedNullableNumSignal](/packages/signals/utilities/persisted)
- [PersistedStringSignal](/packages/signals/utilities/persisted) / [PersistedNullableStringSignal](/packages/signals/utilities/persisted)
- [PersistedEnumSignal](/packages/signals/utilities/persisted) / [PersistedNullableEnumSignal](/packages/signals/utilities/persisted)

### Simple Usage Example
```dart
// 1. Create or obtain a key-value store adapter (like standard in-memory)
final localStore = SignalsInMemoryKeyValueStore();

// 2. Create the persisted signal with a unique key
final darkModeSignal = PersistedBoolSignal(
  false, // Fallback initial value
  key: 'settings.dark_mode',
  store: localStore,
);

// 3. The value is automatically loaded asynchronously on instantiation.
// Mutating the value synchronously schedules an async save under the hood:
darkModeSignal.value = true; // Automatically persisted to store
```

### Custom Serialization / Complex Objects
To persist complex objects (e.g. custom classes), subclass [PersistedSignal](/packages/signals/utilities/persisted)
and override the **decode** and **encode** methods, or mixin [PersistedSignalMixin](/packages/signals/utilities/persisted)
on a custom [Signal](/packages/signals/core/signal) class.

```dart
class User {
  final String name;
  final int age;
  User(this.name, this.age);

  Map<String, dynamic> toJson() => {'name': name, 'age': age};
  factory User.fromJson(Map<String, dynamic> json) => User(json['name'], json['age']);
}

class PersistedUserSignal extends PersistedSignal<User> {
  PersistedUserSignal(
    super.internalValue, {
    required super.key,
    required super.store,
  });

  @override
  User decode(String value) => User.fromJson(jsonDecode(value));

  @override
  String encode(User value) => jsonEncode(value.toJson());
}
```


### Constructors

##### <a name="persistedsignal"></a><a name="persistedsignal"></a>`PersistedSignal(super.internalValue, {required this.key, required this.store, PersistedSignalOptions<T>? options, @Deprecated('Use options: PersistedSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: PersistedSignalOptions(name: ...) instead') String? debugLabel, bool autoInit = true})`

Creates a new `PersistedSignal`.


### Properties

##### <a name="key"></a>`String key`

##### <a name="store"></a>`SignalsKeyValueStore store`



---

## SignalsKeyValueStore

An abstract class defining the persistence adapter contract for [PersistedSignal](/packages/signals/utilities/persisted).

Implement this interface to bind `PersistedSignal` to your storage engine of
choice, such as local files, SQLite, SharedPreferences, Hive, or indexedDB.

### Example: Custom Shared Preferences Store (Flutter)
```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

class SharedPreferencesStore implements SignalsKeyValueStore {
  final SharedPreferences prefs;
  SharedPreferencesStore(this.prefs);

  @override
  Future<String?> getItem(String key) async {
    return prefs.getString(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    await prefs.setString(key, value);
  }

  @override
  Future<void> removeItem(String key) async {
    await prefs.remove(key);
  }
}
```


### Properties

##### <a name="defaultstore"></a>`static SignalsKeyValueStore defaultStore`

The default store to be used if no store is provided.


### Methods

##### <a name="setitem"></a>`Future<void> setItem(String key, String value)`

Sets an item in the store.

##### <a name="getitem"></a>`Future<String?> getItem(String key)`

Gets an item from the store.

##### <a name="removeitem"></a>`Future<void> removeItem(String key)`

Removes an item from the store.



---

## PersistedSignalMixin

A mixin that adds local persistence capabilities to a standard [Signal](/packages/signals/core/signal).

By mixing in `PersistedSignalMixin<T>` on a `Signal<T>` subclass, the signal
will automatically retrieve its stored state on boot and save its state whenever
`.value` is mutated.

Classes mixing in `PersistedSignalMixin<T>` must implement:
- **key**: A unique identifier string for the key-value database.
- **store**: An implementation of [SignalsKeyValueStore](/packages/signals/utilities/persisted).

### Serialization Customization
By default, the mixin uses standard JSON parsing (`jsonDecode` / `jsonEncode`).
If your data type `T` is not natively supported by JSON, override:
- **decode** to convert the raw string value back into type `T`.
- **encode** to serialize type `T` into a string.


### Properties

##### <a name="loaded"></a>`bool loaded`

Whether the signal has been loaded from the store.


### Methods

##### <a name="key"></a>`String key`

The key to use for storing the value.

##### <a name="store"></a>`SignalsKeyValueStore store`

The store to use for storing the value.

##### <a name="init"></a>`Future<void> init()`

Initializes the signal by loading the value from the store.

##### <a name="value"></a>`T value`

##### <a name="value"></a>`value(T value)`

##### <a name="load"></a>`Future<T> load()`

Loads the value from the store.

##### <a name="save"></a>`Future<void> save(T value)`

Saves the value to the store.

##### <a name="decode"></a>`T decode(String value)`

Decodes the value from a string.

##### <a name="encode"></a>`String encode(T value)`

Encodes the value to a string.



---

## SignalsInMemoryKeyValueStore

An in-memory, volatile implementation of [SignalsKeyValueStore](/packages/signals/utilities/persisted).

This serves as a fallback engine and does not persist across restarts/reload.


### Properties

##### <a name="store"></a>`store`

The in-memory store.


### Methods

##### <a name="getitem"></a>`Future<String?> getItem(String key)`

##### <a name="removeitem"></a>`Future<void> removeItem(String key)`

##### <a name="setitem"></a>`Future<void> setItem(String key, String value)`



---

## PersistedNullableStringSignal

A `PersistedSignal` that stores a nullable string value.

> [!warning] An empty value is considered null


### Constructors

##### <a name="persistednullablestringsignal"></a><a name="persistednullablestringsignal"></a>`PersistedNullableStringSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `NullableStringSignal`.


### Methods

##### <a name="decode"></a>`String? decode(String value)`

##### <a name="encode"></a>`String encode(String? value)`



---

## PersistedNullableIntSignal

A `PersistedSignal` that stores a nullable integer value.


### Constructors

##### <a name="persistednullableintsignal"></a><a name="persistednullableintsignal"></a>`PersistedNullableIntSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `NullableIntSignal`.


### Methods

##### <a name="decode"></a>`int? decode(String value)`

##### <a name="encode"></a>`String encode(int? value)`



---

## PersistedNullableNumSignal

A `PersistedSignal` that stores a nullable numeric value.


### Constructors

##### <a name="persistednullablenumsignal"></a><a name="persistednullablenumsignal"></a>`PersistedNullableNumSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `NullableNumSignal`.


### Methods

##### <a name="decode"></a>`num? decode(String value)`

##### <a name="encode"></a>`String encode(num? value)`



---

## PersistedNullableBoolSignal

A `PersistedSignal` that stores a nullable string value.


### Constructors

##### <a name="persistednullableboolsignal"></a><a name="persistednullableboolsignal"></a>`PersistedNullableBoolSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `NullableBoolSignal`.


### Methods

##### <a name="decode"></a>`bool? decode(String value)`

##### <a name="encode"></a>`String encode(bool? value)`



---

## PersistedNullableDoubleSignal

A `PersistedSignal` that stores a nullable double value.


### Constructors

##### <a name="persistednullabledoublesignal"></a><a name="persistednullabledoublesignal"></a>`PersistedNullableDoubleSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `NullableDoubleSignal`.


### Methods

##### <a name="decode"></a>`double? decode(String value)`

##### <a name="encode"></a>`String encode(double? value)`



---

## PersistedNullableEnumSignal

A `PersistedSignal` that stores a nullable enum value.


### Constructors

##### <a name="persistednullableenumsignal"></a><a name="persistednullableenumsignal"></a>`PersistedNullableEnumSignal(super.val, String key, this.values, {SignalsKeyValueStore? store})`

Creates a new `NullableEnumSignal`.


### Properties

##### <a name="values"></a>`List<T> values`


### Methods

##### <a name="decode"></a>`T? decode(String value)`

##### <a name="encode"></a>`String encode(T? value)`



---

## PersistedIntSignal

A `PersistedSignal` that stores an integer value.


### Constructors

##### <a name="persistedintsignal"></a><a name="persistedintsignal"></a>`PersistedIntSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `IntSignal`.


### Methods

##### <a name="decode"></a>`int decode(String value)`

##### <a name="encode"></a>`String encode(int value)`



---

## PersistedBoolSignal

A `PersistedSignal` that stores a boolean value.


### Constructors

##### <a name="persistedboolsignal"></a><a name="persistedboolsignal"></a>`PersistedBoolSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `BoolSignal`.


### Methods

##### <a name="decode"></a>`bool decode(String value)`

##### <a name="encode"></a>`String encode(bool value)`



---

## PersistedDoubleSignal

A `PersistedSignal` that stores an double value.


### Constructors

##### <a name="persisteddoublesignal"></a><a name="persisteddoublesignal"></a>`PersistedDoubleSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `DoubleSignal`.


### Methods

##### <a name="decode"></a>`double decode(String value)`

##### <a name="encode"></a>`String encode(double value)`



---

## PersistedNumSignal

A `PersistedSignal` that stores a numeric value.


### Constructors

##### <a name="persistednumsignal"></a><a name="persistednumsignal"></a>`PersistedNumSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `NumSignal`.


### Methods

##### <a name="decode"></a>`num decode(String value)`

##### <a name="encode"></a>`String encode(num value)`



---

## PersistedStringSignal

A `PersistedSignal` that stores a string value.


### Constructors

##### <a name="persistedstringsignal"></a><a name="persistedstringsignal"></a>`PersistedStringSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new `StringSignal`.


### Methods

##### <a name="decode"></a>`String decode(String value)`

##### <a name="encode"></a>`String encode(String value)`



---

## PersistedEnumSignal

A `PersistedSignal` that stores an enum value.


### Constructors

##### <a name="persistedenumsignal"></a><a name="persistedenumsignal"></a>`PersistedEnumSignal(super.val, String key, this.values, {SignalsKeyValueStore? store})`

Creates a new `EnumSignal`.


### Properties

##### <a name="values"></a>`List<T> values`


### Methods

##### <a name="decode"></a>`T decode(String value)`

##### <a name="encode"></a>`String encode(T value)`



---

## PersistedSignalOptions

Configuration options for a [PersistedSignal](/packages/signals/utilities/persisted).


### Constructors

##### <a name="persistedsignaloptions"></a><a name="persistedsignaloptions"></a>`PersistedSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched})`

Creates a new [PersistedSignalOptions](/packages/signals/utilities/persisted) instance.


### Methods

##### <a name="copywith"></a>`PersistedSignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})`

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`
