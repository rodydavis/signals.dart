# useAsyncComputed

Creates a reactive computed signal driven by an asynchronous callback.

## Example

```dart
class AsyncComputedView extends HookWidget {
  const AsyncComputedView({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useSignal(1);
    final user = useAsyncComputed(
      () => fetchUserById(count.value),
      AsyncSignalOptions(name: 'async-computed-user'),
    );

    return Text('User: ${user.value.value?.name}');
  }
}
```
