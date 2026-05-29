# class `PersistedSignal`

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

---

## Members of `PersistedSignal`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedSignal** | `constructor` | `PersistedSignal(super.internalValue, {required this.key, required this.store, PersistedSignalOptions<T>? options, @Deprecated('Use options: PersistedSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: PersistedSignalOptions(name: ...) instead') String? debugLabel, bool autoInit = true})` | Creates a new <code>PersistedSignal</code>. |
| **key** | `field` | `String key` |  |
| **store** | `field` | `SignalsKeyValueStore store` |  |
