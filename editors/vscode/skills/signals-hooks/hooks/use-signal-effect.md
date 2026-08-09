# useSignalEffect

Registers a side-effect callback that automatically disposes when the hook unmounts.

## Example

```dart
class LoggedCounter extends HookWidget {
  const LoggedCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);
    useSignalEffect(() {
      print('Counter value changed to: ${count.value}');
    });
    return ElevatedButton(
      onPressed: () => count.value++,
      child: Text('Increment'),
    );
  }
}
```
