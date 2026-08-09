# useChangeStackSignal

Creates a **ChangeStackSignal** that manages undo/redo history.

## Example

```dart
class ChangeStackView extends HookWidget {
  const ChangeStackView({super.key});

  @override
  Widget build(BuildContext context) {
    final history = useChangeStackSignal(0, ChangeStackSignalOptions(name: 'history'));
    return Column(
      children: [
        Text('Count: ${history.value}'),
        ElevatedButton(
          onPressed: () => history.undo(),
          child: Text('Undo'),
        ),
      ],
    );
  }
}
```
