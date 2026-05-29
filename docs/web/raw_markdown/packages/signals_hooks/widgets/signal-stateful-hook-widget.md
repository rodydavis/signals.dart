---
title: SignalStatefulHookWidget
description: A premium stateful widget that both supports Flutter Hooks and implicitly tracks and rebuilds on signal changes.
---

A premium stateful widget that both supports Flutter Hooks and implicitly tracks and rebuilds on signal changes.

Stateful counterpart of [SignalHookWidget](/types/signalhookwidget).

### Example Usage
```dart
class CounterWidget extends SignalStatefulHookWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    // Standard flutter hooks work here:
    final controller = useTextEditingController();
    // Reactive signals work here as well:
    final counter = useSignal(0);
    return Column(
      children: [
        TextField(controller: controller),
        Text('Count: $counter'),
        ElevatedButton(
          onPressed: () => counter.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalstatefulhookwidget"></a><a name="signalstatefulhookwidget"></a>`SignalStatefulHookWidget({super.key})`

Constructor for [SignalStatefulHookWidget](/types/signalstatefulhookwidget).

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createelement"></a>`StatefulElement createElement()`

</details>
