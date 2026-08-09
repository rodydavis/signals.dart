# useIterableSignal

Creates a reactive **IterableSignal** for iterable collections.

## Example

```dart
class IterableSignalView extends HookWidget {
  const IterableSignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = useIterableSignal([1, 2, 3], IterableSignalOptions(name: 'iterable'));
    return Text('First: ${items.first}');
  }
}
```
