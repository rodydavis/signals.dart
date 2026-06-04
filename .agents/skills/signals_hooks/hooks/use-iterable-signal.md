# useIterableSignal

Creates a reactive **IterableSignal** for iterable collections.

## Example

```dart
class IterableView extends HookWidget {
  const IterableView({super.key});

  @override
  Widget build(BuildContext context) {
    final numbers = useIterableSignal(
      [1, 2, 3],
      const [],
      IterableSignalOptions(name: 'numbers-iterable'),
    );

    return Column(
      children: numbers.map((n) => Text('\$n')).toList(),
    );
  }
}
```
