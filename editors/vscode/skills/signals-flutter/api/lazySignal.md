# function `lazySignal`

Creates a lazy, mutable [FlutterSignal](/types/fluttersignal) of type **T** whose value can be assigned later.

<Warning>
  Reading a lazy signal's value before it has been initialized will throw a runtime error.
</Warning>

### Example

```dart
final database = lazySignal<DatabaseConnection>();

// Initialize later (e.g. in initState or async initialization):
database.value = await connectToDatabase();

// Now it is safe to read:
print('Connected to: ${database.value.host}');
```

---

## Signature

```dart
FlutterSignal<T> lazySignal({core.SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```

