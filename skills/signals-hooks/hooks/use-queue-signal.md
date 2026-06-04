# useQueueSignal

Creates a reactive **QueueSignal** for queue collections.

## Example

```dart
class QueueSignalView extends HookWidget {
  const QueueSignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final queue = useQueueSignal<int>([], QueueSignalOptions(name: 'queue'));
    return Text('Queue size: ${queue.length}');
  }
}
```
