# function `signalContainer`

Create a signal container used to instance signals based on args

```dart
final container = signalContainer<Cache, String>((e) {
  return signal(Cache(e));
});

final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');

cacheA.value = 'a';
cacheB.value = 'b';
cacheC.value = 'c';
```

---

## Signature

```dart
SignalContainer<T, Arg, Signal<T>> signalContainer(Signal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, Signal<T> signal)? onEvict})
```

