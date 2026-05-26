# useSignalValue

Directly extracts and watches the value of a signal, returning the unwrapped T value.

## Example

```dart
class DirectValueView extends HookWidget {
  final Signal<String> titleSignal;
  const DirectValueView(this.titleSignal, {super.key});

  @override
  Widget build(BuildContext context) {
    final title = useSignalValue(titleSignal);
    return Text('Title: $title');
  }
}
```
