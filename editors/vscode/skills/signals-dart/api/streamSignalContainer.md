# function `streamSignalContainer`

Create a signal container for StreamSignals based on args.

```dart
final container = streamSignalContainer<Message, int>((roomId) {
  return streamSignal(() => listenToRoom(roomId));
});
```

---

## Signature

```dart
SignalContainer<AsyncState<T>, Arg, StreamSignal<T>> streamSignalContainer(StreamSignal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, StreamSignal<T> signal)? onEvict})
```

