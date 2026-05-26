# useSetSignal

Creates a reactive **SetSignal** for set collections.

## Example

```dart
class SetSignalView extends HookWidget {
  const SetSignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = useSetSignal({1, 2, 3}, SetSignalOptions(name: 'unique-items'));
    return Text('Count: ${items.length}');
  }
}
```
