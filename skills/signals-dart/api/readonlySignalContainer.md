# function `readonlySignalContainer`

Create a signal container used to instance signals based on args

```dart
final container = readonlySignalContainer<Cache, String>((e) {
  return signal(Cache(e));
});

final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');
```

The signals cannot be updated but allows for
using computed where the value is only derived from other signals.

---

## Signature

```dart
SignalContainer<T, Arg, ReadonlySignal<T>> readonlySignalContainer(ReadonlySignal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, ReadonlySignal<T> signal)? onEvict})
```

