# `QueueSignal<T>` (Reactive Queues)

`QueueSignal<T>` wraps Dart Double-Ended Queues (`Queue`), providing efficient reactive FIFO/LIFO pipelines.

---

## 1. Creation

```dart
final pipeline = queueSignal(
  Queue<String>(),
  options: QueueSignalOptions(
    name: 'event_queue',
  ),
);
```

---

## 2. Usage
```dart
pipeline.addLast('event_1'); // Push
final first = pipeline.removeFirst(); // Pop FIFO
```
- Extremely useful for building reactive event queues and buffers.
