# function `lazySignal`

Lazy signal that can be created with type T that
the value will be assigned later.

```dart
final db = lazySignal<DatabaseConnection>();
...
db.value = DatabaseConnect(...);
```

---

## Signature

```dart
Signal<T> lazySignal({SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})
```

