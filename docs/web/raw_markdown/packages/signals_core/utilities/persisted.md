---
title: PersistedSignal
description: A <code>Signal</code> whose value is persistently stored in a key-value database.
---

A <code>Signal</code> whose value is persistently stored in a key-value database.

<code>PersistedSignal</code> allows application state (such as user preferences, theme options,
authentication tokens, and drafts) to automatically survive application restarts
without writing tedious boilerplate for manual loading and saving.

### Concrete Subclasses
For common primitive types, use the provided concrete classes:
- [PersistedBoolSignal](/types/persistedboolsignal) / [PersistedNullableBoolSignal](/types/persistednullableboolsignal)
- [PersistedIntSignal](/types/persistedintsignal) / [PersistedNullableIntSignal](/types/persistednullableintsignal)
- [PersistedDoubleSignal](/types/persisteddoublesignal) / [PersistedNullableDoubleSignal](/types/persistednullabledoublesignal)
- [PersistedNumSignal](/types/persistednumsignal) / [PersistedNullableNumSignal](/types/persistednullablenumsignal)
- [PersistedStringSignal](/types/persistedstringsignal) / [PersistedNullableStringSignal](/types/persistednullablestringsignal)
- [PersistedEnumSignal](/types/persistedenumsignal) / [PersistedNullableEnumSignal](/types/persistednullableenumsignal)

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
To persist complex objects (e.g. custom classes), subclass [PersistedSignal](/types/persistedsignal)
and override the **decode** and **encode** methods, or mixin [PersistedSignalMixin](/types/persistedsignalmixin)
on a custom [Signal](/types/signal) class.

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

<details>
<summary> View Constructors </summary>

##### <a name="persistedsignal"></a><a name="persistedsignal"></a>`PersistedSignal(super.internalValue, {required this.key, required this.store, PersistedSignalOptions<T>? options, @Deprecated('Use options: PersistedSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: PersistedSignalOptions(name: ...) instead') String? debugLabel, bool autoInit = true})`

Creates a new <code>PersistedSignal</code>.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="key"></a>`String key`

##### <a name="store"></a>`SignalsKeyValueStore store`

</details>



---

## SignalsKeyValueStore

An abstract class defining the persistence adapter contract for [PersistedSignal](/types/persistedsignal).

Implement this interface to bind <code>PersistedSignal</code> to your storage engine of
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

<details>
<summary> View Properties </summary>

##### <a name="defaultstore"></a>`static SignalsKeyValueStore defaultStore`

The default store to be used if no store is provided.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="setitem"></a>`Future<void> setItem(String key, String value)`

Sets an item in the store.

##### <a name="getitem"></a>`Future<String?> getItem(String key)`

Gets an item from the store.

##### <a name="removeitem"></a>`Future<void> removeItem(String key)`

Removes an item from the store.

</details>



---

## PersistedSignalMixin

A mixin that adds local persistence capabilities to a standard [Signal](/types/signal).

By mixing in <code>PersistedSignalMixin<T></code> on a <code>Signal<T></code> subclass, the signal
will automatically retrieve its stored state on boot and save its state whenever
<code>.value</code> is mutated.

Classes mixing in <code>PersistedSignalMixin<T></code> must implement:
- **key**: A unique identifier string for the key-value database.
- **store**: An implementation of [SignalsKeyValueStore](/types/signalskeyvaluestore).

### Serialization Customization
By default, the mixin uses standard JSON parsing (<code>jsonDecode</code> / <code>jsonEncode</code>).
If your data type <code>T</code> is not natively supported by JSON, override:
- **decode** to convert the raw string value back into type <code>T</code>.
- **encode** to serialize type <code>T</code> into a string.


### Properties

<details>
<summary> View Properties </summary>

##### <a name="loaded"></a>`bool loaded`

Whether the signal has been loaded from the store.

</details>


### Methods

<details>
<summary> View Methods </summary>

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

</details>



---

## SignalsInMemoryKeyValueStore

An in-memory, volatile implementation of [SignalsKeyValueStore](/types/signalskeyvaluestore).

This serves as a fallback engine and does not persist across restarts/reload.


### Properties

<details>
<summary> View Properties </summary>

##### <a name="store"></a>`store`

The in-memory store.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="getitem"></a>`Future<String?> getItem(String key)`

##### <a name="removeitem"></a>`Future<void> removeItem(String key)`

##### <a name="setitem"></a>`Future<void> setItem(String key, String value)`

</details>



---

## PersistedNullableStringSignal

A <code>PersistedSignal</code> that stores a nullable string value.

> [!warning] An empty value is considered null


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistednullablestringsignal"></a><a name="persistednullablestringsignal"></a>`PersistedNullableStringSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>NullableStringSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`String? decode(String value)`

##### <a name="encode"></a>`String encode(String? value)`

</details>



---

## PersistedNullableIntSignal

A <code>PersistedSignal</code> that stores a nullable integer value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistednullableintsignal"></a><a name="persistednullableintsignal"></a>`PersistedNullableIntSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>NullableIntSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`int? decode(String value)`

##### <a name="encode"></a>`String encode(int? value)`

</details>



---

## PersistedNullableNumSignal

A <code>PersistedSignal</code> that stores a nullable numeric value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistednullablenumsignal"></a><a name="persistednullablenumsignal"></a>`PersistedNullableNumSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>NullableNumSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`num? decode(String value)`

##### <a name="encode"></a>`String encode(num? value)`

</details>



---

## PersistedNullableBoolSignal

A <code>PersistedSignal</code> that stores a nullable string value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistednullableboolsignal"></a><a name="persistednullableboolsignal"></a>`PersistedNullableBoolSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>NullableBoolSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`bool? decode(String value)`

##### <a name="encode"></a>`String encode(bool? value)`

</details>



---

## PersistedNullableDoubleSignal

A <code>PersistedSignal</code> that stores a nullable double value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistednullabledoublesignal"></a><a name="persistednullabledoublesignal"></a>`PersistedNullableDoubleSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>NullableDoubleSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`double? decode(String value)`

##### <a name="encode"></a>`String encode(double? value)`

</details>



---

## PersistedNullableEnumSignal

A <code>PersistedSignal</code> that stores a nullable enum value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistednullableenumsignal"></a><a name="persistednullableenumsignal"></a>`PersistedNullableEnumSignal(super.val, String key, this.values, {SignalsKeyValueStore? store})`

Creates a new <code>NullableEnumSignal</code>.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="values"></a>`List<T> values`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`T? decode(String value)`

##### <a name="encode"></a>`String encode(T? value)`

</details>



---

## PersistedIntSignal

A <code>PersistedSignal</code> that stores an integer value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistedintsignal"></a><a name="persistedintsignal"></a>`PersistedIntSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>IntSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`int decode(String value)`

##### <a name="encode"></a>`String encode(int value)`

</details>



---

## PersistedBoolSignal

A <code>PersistedSignal</code> that stores a boolean value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistedboolsignal"></a><a name="persistedboolsignal"></a>`PersistedBoolSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>BoolSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`bool decode(String value)`

##### <a name="encode"></a>`String encode(bool value)`

</details>



---

## PersistedDoubleSignal

A <code>PersistedSignal</code> that stores an double value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persisteddoublesignal"></a><a name="persisteddoublesignal"></a>`PersistedDoubleSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>DoubleSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`double decode(String value)`

##### <a name="encode"></a>`String encode(double value)`

</details>



---

## PersistedNumSignal

A <code>PersistedSignal</code> that stores a numeric value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistednumsignal"></a><a name="persistednumsignal"></a>`PersistedNumSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>NumSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`num decode(String value)`

##### <a name="encode"></a>`String encode(num value)`

</details>



---

## PersistedStringSignal

A <code>PersistedSignal</code> that stores a string value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistedstringsignal"></a><a name="persistedstringsignal"></a>`PersistedStringSignal(super.val, String key, {SignalsKeyValueStore? store})`

Creates a new <code>StringSignal</code>.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`String decode(String value)`

##### <a name="encode"></a>`String encode(String value)`

</details>



---

## PersistedEnumSignal

A <code>PersistedSignal</code> that stores an enum value.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistedenumsignal"></a><a name="persistedenumsignal"></a>`PersistedEnumSignal(super.val, String key, this.values, {SignalsKeyValueStore? store})`

Creates a new <code>EnumSignal</code>.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="values"></a>`List<T> values`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="decode"></a>`T decode(String value)`

##### <a name="encode"></a>`String encode(T value)`

</details>



---

## PersistedSignalOptions

Configuration options for a [PersistedSignal](/types/persistedsignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="persistedsignaloptions"></a><a name="persistedsignaloptions"></a>`PersistedSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched})`

Creates a new [PersistedSignalOptions](/types/persistedsignaloptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a>`PersistedSignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})`

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`

</details>
