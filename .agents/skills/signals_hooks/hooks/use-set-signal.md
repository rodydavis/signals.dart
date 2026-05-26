# useSetSignal

Creates a reactive **SetSignal** for set collections.

## Example

```dart
class SetView extends HookWidget {
  const SetView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIds = useSetSignal(
      <int>{},
      const [],
      SetSignalOptions(name: 'selected-items'),
    );

    return Text('Selected: \${selectedIds.length}');
  }
}
```
