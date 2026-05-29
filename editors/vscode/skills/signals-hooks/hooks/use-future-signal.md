# useFutureSignal

Triggers an asynchronous callback and returns its result wrapped in a **FutureSignal**.

## Example

```dart
class UserProfileView extends HookWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = useFutureSignal(
      () => fetchUserProfile(),
      AsyncSignalOptions(name: 'user-profile'),
    );

    if (user.value.isLoading) return CircularProgressIndicator();
    if (user.value.hasError) return Text('Error: ${user.value.error}');
    return Text('Name: ${user.value.value}');
  }
}
```
