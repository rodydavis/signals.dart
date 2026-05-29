# useStreamSignal

Subscribes to a Stream and exposes its events via a **StreamSignal**.

## Example

```dart
class NotificationStreamView extends HookWidget {
  const NotificationStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = useStreamSignal(
      () => streamNotifications(),
      AsyncSignalOptions(name: 'notifications'),
    );

    if (notifications.value.isLoading) return Text('Connecting...');
    return Text('Latest Notification: ${notifications.value.value}');
  }
}
```
