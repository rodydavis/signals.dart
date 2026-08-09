# useListSignal

Creates a reactive **ListSignal** for list collections.

## Example

```dart
class ListSignalView extends HookWidget {
  const ListSignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final list = useListSignal([1, 2, 3], ListSignalOptions(name: 'items'));
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => Text('${list[index]}'),
    );
  }
}
```
