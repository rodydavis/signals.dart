# useLinkedSignal

Creates a writable computed **LinkedSignal** bridging two signals.

## Example

```dart
class LinkedSignalView extends HookWidget {
  const LinkedSignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final source = useSignal(10);
    final linked = useLinkedSignal(
      LinkedSignalOptions(
        name: 'linked',
        read: () => source.value,
        write: (val) => source.value = val,
      ),
    );
    return Text('Linked: ${linked.value}');
  }
}
```
