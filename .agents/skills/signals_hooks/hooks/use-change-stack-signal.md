# useChangeStackSignal

Creates a **ChangeStackSignal** that manages undo/redo history.

## Example

```dart
class UndoRedoView extends HookWidget {
  const UndoRedoView({super.key});

  @override
  Widget build(BuildContext context) {
    final history = useChangeStackSignal(
      0,
      const [],
      ChangeSignalOptions(name: 'history-stack'),
    );

    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.undo),
          onPressed: history.canUndo ? () => history.undo() : null,
        ),
        Text('Value: \${history.value}'),
      ],
    );
  }
}
```
