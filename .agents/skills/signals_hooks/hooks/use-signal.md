# useSignal

Wraps a standard mutable **Signal** bound to the hook state lifecycle.

## Example

```dart
class CounterWidget extends HookWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useSignal(0, const [], SignalOptions(name: 'counter'));
    return ElevatedButton(
      onPressed: () => count.value++,
      child: Text('Count: \${count.value}'),
    );
  }
}
```
