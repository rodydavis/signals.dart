# useAsyncSignal

Wraps an asynchronous task state inside a manageable **AsyncSignal**.

## Example

```dart
class AsyncStateView extends HookWidget {
  const AsyncStateView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = useAsyncSignal(
      AsyncState.loading(),
      AsyncSignalOptions(name: 'async-task'),
    );

    return Text('Task loaded: ${state.value.hasValue}');
  }
}
```
