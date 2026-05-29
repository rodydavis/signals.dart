# function `computedContainer`

Create a signal container for computed signals based on args.

```dart
final container = computedContainer<int, int>((arg) {
  return computed(() => sourceSignal.value * arg);
});
```

---

## Signature

```dart
SignalContainer<T, Arg, Computed<T>> computedContainer(Computed<T> Function(Arg) create, {bool cache = false, void Function(Arg key, Computed<T> signal)? onEvict})
```

