# useQueueSignal

Creates a reactive **QueueSignal** for queue collections.

## Example

```dart
class QueueView extends HookWidget {
  const QueueView({super.key});

  @override
  Widget build(BuildContext context) {
    final queue = useQueueSignal(
      Queue<String>(),
      const [],
      QueueSignalOptions(name: 'notification-queue'),
    );

    return Text('Notifications pending: \${queue.length}');
  }
}
```
