# `StreamSignal<T>`

`StreamSignal<T>` listens to a Dart `Stream` and exposes its values reactively, cleanly mapping stream events to `AsyncState` classes.

---

## 1. Creation

```dart
final chatRoomId = signal('general');

final messages = streamSignal(
  () => connectToChatStream(chatRoomId.value),
  options: AsyncSignalOptions(
    cancelOnError: false,
    onDone: () => print('Stream completed!'),
  ),
);
```

---

## 2. Key Attributes
- **Dynamic Re-binding**: If `chatRoomId` changes, the old stream subscription is automatically cancelled and the new stream is subscribed to.
- **Subscription Management**: Subscription setup and teardown are fully managed by the signal's active state, protecting against resource and memory leaks.
