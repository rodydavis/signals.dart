# signals_hooks

Helper library to make working with [signals](https://pub.dev/packages/signals) in [flutter_hooks](https://pub.dev/packages/flutter_hooks) easier.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_flutter/signals_flutter.dart';

class Example extends HookWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);
    final countStr = useComputed(() => count.value.toString());
    useSignalEffect(() {
      debugPrint('count: $countStr');
    });
    return Scaffold(
      body: Center(
        child: Text('Count: $count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

All of the signals and effects created will get cleaned up when the widget gets unmounted.

## useSignal

How to create a new signal inside of a hook widget:

```dart
class Example extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);
    return Text('Count: $count');
  }
}
```

The value will auto rebuild the widget when it changes.

## useComputed

How to create a new computed signal inside of a hook widget:

```dart
class Example extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);
    final countStr = useComputed(() => count.toString());
    return Text('Count: $countStr');
  }
}
```

The value will auto rebuild the widget when it changes.

## useSignalEffect

How to create a new effect inside of a hook widget:

```dart
class Example extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);
    useSignalEffect(() {
        print('count: $count');
    });
    return Text('Count: $countStr');
  }
}
```
