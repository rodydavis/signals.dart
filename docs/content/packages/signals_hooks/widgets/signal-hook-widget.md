---
title: SignalHookWidget
description: A premium reactive **HookWidget** that both supports Flutter Hooks and implicitly tracks and rebuilds on signal changes.
---

A premium reactive **HookWidget** that both supports Flutter Hooks and implicitly tracks and rebuilds on signal changes.

<code>SignalHookWidget</code> establishes a dynamic reactive context directly at the Flutter element layer.
Any signal accessed via <code>.value</code> inside the **buildWidget** method is **implicitly tracked** and
subscribed to. At the same time, you can call any hooks (like <code>useSignal</code>, <code>useFocusNode</code>, etc.)
within **buildWidget**.

This provides the ultimate developer experience, combining the power of implicit, boilerplate-free
signal tracking with the rich lifecycle management of Flutter Hooks.

### Dual Reactivity Example
```dart
final globalCartCount = signal(0);

class MyDualWidget extends SignalHookWidget {
  const MyDualWidget({super.key});

  @override
  Widget buildWidget(BuildContext context) {
    // 1. Declare hooks seamlessly:
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final localCounter = useSignal(0);

    // 2. Implicit tracking of external/global signals:
    // No .watch(context) needed! Just accessing .value tracks it.
    return Column(
      children: [
        TextField(controller: controller, focusNode: focusNode),
        Text('Global Signal: ${globalCartCount.value}'),
        Text('Local Signal: ${localCounter.value}'),
      ],
    );
  }
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalhookwidget"></a><a name="signalhookwidget"></a>`SignalHookWidget({super.key})`

Constructor for [SignalHookWidget](/packages/signals_hooks/widgets/signal-hook-widget).

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="buildwidget"></a>`Widget buildWidget(BuildContext context)`

Subclasses override this method instead of **build** to define their widget tree.

##### <a name="build"></a>`Widget build(BuildContext context)`

</details>
