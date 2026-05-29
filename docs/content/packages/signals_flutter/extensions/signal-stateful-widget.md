---
title: SignalStatefulWidget
description: A reactive StatefulWidget that implicitly tracks and rebuilds on signal changes.
---

A reactive **StatefulWidget** that implicitly tracks and rebuilds on signal changes.

Subclasses of <code>SignalStatefulWidget</code> establish a dynamic reactive context directly at the
Flutter element layer. Any signal value accessed synchronously inside State's **build** method
is **implicitly tracked** and subscribed to. When a signal changes, only that element is rebuilt.

This offers a clean, Javascript-style reactivity experience while retaining all stateful lifecycles.
It is the modern, highly recommended replacement for the legacy, deprecated <code>SignalsMixin</code>.

### Implicit Reactivity Example (Stateful)
```dart
class CounterControl extends SignalStatefulWidget {
  const CounterControl({super.key});

  @override
  State<CounterControl> createState() => _CounterControlState();
}

class _CounterControlState extends State<CounterControl> {
  // Create state signals directly inside the State object:
  final count = signal(0);

  @override
  Widget build(BuildContext context) {
    // Automatically tracked on access and safely unsubscribed on unmount:
    return ElevatedButton(
      onPressed: () => count.value++,
      child: Text('Count: ${count.value}'),
    );
  }
}
```

> [!IMPORTANT]
> Only signals accessed *synchronously* during the execution of the <code>build</code> method are tracked.
> Signals read inside async callbacks, listeners, or deferred tasks are not subscribed to.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalstatefulwidget"></a><a name="signalstatefulwidget"></a><code>SignalStatefulWidget({super.key})</code>

Constructor for [SignalStatefulWidget](/types/signalstatefulwidget).

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createelement"></a><code>StatefulElement createElement()</code>

</details>
