# useListSignal

Creates a reactive **ListSignal** for list collections.

## Example

```dart
class TodoListView extends HookWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final list = useListSignal(
      ['Buy Milk'],
      const [],
      ListSignalOptions(name: 'todos-list'),
    );

    return ListView(
      children: list.map((item) => Text(item)).toList(),
    );
  }
}
```
