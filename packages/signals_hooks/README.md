# signals_hooks

Helper library to make working with [signals](https://pub.dev/packages/signals) in [flutter_hooks](https://pub.dev/packages/flutter_hooks) easier.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class Example extends HookWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);
    final doubleCount = useComputed(() => count.value * 2);
    useSignalEffect(() {
      debugPrint('count: $count, double: $doubleCount');
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

## Core

### useSignal

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

### useComputed

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

### useSignalEffect

How to create a new effect inside of a hook widget:

```dart
class Example extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);
    useSignalEffect(() {
        print('count: $count');
    });
    return Text('Count: $count');
  }
}
```

### useExistingSignal

How to bind an existing signal inside of a hook widget:

```dart
class Example extends HookWidget {
  final Signal<int> count;

  const Example(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useExistingSignal(count);
    return Text('Count: $counter');
  }
}
```

The value will auto rebuild the widget when it changes.

### useSignalValue

How to get the value of a signal directly:

```dart
class Example extends HookWidget {
  final Signal<int> count;

  const Example(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useSignalValue(count);
    return Text('Count: $counter');
  }
}
```

The value will auto rebuild the widget when it changes.

## Async

### useFutureSignal

Creates a new `FutureSignal` and subscribes to it.

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final future = useFutureSignal(() => Future.delayed(const Duration(seconds: 1), () => 1));
    return future.value.map(
      data: (value) => Text('$value'),
      error: (error, stack) => Text('$error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
```

### useStreamSignal

Creates a new `StreamSignal` and subscribes to it.

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final stream = useStreamSignal(() => Stream.periodic(const Duration(seconds: 1), (i) => i));
    return stream.value.map(
      data: (value) => Text('$value'),
      error: (error, stack) => Text('$error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
```

### useAsyncSignal

Creates a new `AsyncSignal` and subscribes to it.

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final signal = useAsyncSignal<int>(AsyncState.loading());
    return signal.value.map(
      data: (value) => Text('$value'),
      error: (error, stack) => Text('$error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
```

### useAsyncComputed

Creates a new `FutureSignal` from a computed async value and subscribes to it.

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);
    final future = useAsyncComputed(() async {
      await Future.delayed(const Duration(seconds: 1));
      return count.value * 2;
    }, dependencies: [count]);
    return future.value.map(
      data: (value) => Text('$value'),
      error: (error, stack) => Text('$error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
```

## Collections

### useListSignal

Creates a new `ListSignal` and subscribes to it.

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final list = useListSignal([1, 2, 3]);
    return Text('${list.value}');
  }
}
```

### useSetSignal

Creates a new `SetSignal` and subscribes to it.

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final set = useSetSignal({1, 2, 3});
    return Text('${set.value}');
  }
}
```

### useMapSignal

Creates a new `MapSignal` and subscribes to it.

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final map = useMapSignal({'a': 1, 'b': 2});
    return Text('${map.value}');
  }
}
```

## Flutter

### useValueNotifierToSignal

Creates a new `Signal` from a `ValueNotifier` and subscribes to it.

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = useValueNotifier(0);
    final signal = useValueNotifierToSignal(notifier);
    return Text('${signal.value}');
  }
}
```

### useValueListenableToSignal

Creates a new `ReadonlySignal` from a `ValueListenable` and subscribes to it.

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = useValueNotifier(0);
    final signal = useValueListenableToSignal(notifier);
    return Text('${signal.value}');
  }
}
```

## Testing

To test hooks that use signals you can use `flutter_test` and `HookBuilder`.

Here is an example of how to test `useSignal`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_hooks/signals_hooks.dart';

void main() {
  testWidgets('useSignal', (tester) async {
    late Signal<int> state;
    await tester.pumpWidget(
      HookBuilder(builder: (context) {
        state = useSignal(42);
        return GestureDetector(
          onTap: () => state.value++,
          child: Text('$state', textDirection: TextDirection.ltr),
        );
      }),
    );

    expect(state.value, 42);
    expect(find.text('42'), findsOneWidget);

    // Click text and wait
    await tester.tap(find.text('42'));
    await tester.pumpAndSettle();

    expect(state.value, 43);
    expect(find.text('43'), findsOneWidget);
  });
}
```

You can find more examples in the [test folder](https://github.com/rodydavis/signals.dart/tree/main/packages/signals_hooks/test).
