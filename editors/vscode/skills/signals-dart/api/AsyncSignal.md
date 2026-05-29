# function `asyncSignal`

Helper function to create an [AsyncSignal](/types/asyncsignal) initialized with an [AsyncState](/types/asyncstate).

### Example
```dart
// Create an AsyncSignal initialized to a loading state
final counter = asyncSignal<int>(AsyncState.loading());

// Create an AsyncSignal initialized with initial data
final status = asyncSignal<String>(AsyncState.data('Active'));
```

---

## Signature

```dart
AsyncSignal<T> asyncSignal(AsyncState<T> value, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose})
```

