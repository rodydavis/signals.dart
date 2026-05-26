# useExistingSignal

Safely binds an existing, external signal to automatically rebuild the widget on change.

## Example

```dart
class ExternalCounter extends HookWidget {
  final Signal<int> externalCount;
  const ExternalCounter(this.externalCount, {super.key});

  @override
  Widget build(BuildContext context) {
    useExistingSignal(externalCount);
    return Text('Count: ${externalCount.value}');
  }
}
```
