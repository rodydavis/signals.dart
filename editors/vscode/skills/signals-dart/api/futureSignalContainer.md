# function `futureSignalContainer`

Create a signal container for FutureSignals based on args.

```dart
final container = futureSignalContainer<Post, int>((id) {
  return futureSignal(() => fetchPost(id));
});
```

---

## Signature

```dart
SignalContainer<AsyncState<T>, Arg, FutureSignal<T>> futureSignalContainer(FutureSignal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, FutureSignal<T> signal)? onEvict})
```

