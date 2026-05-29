---
title: SignalHookWidget
description: A premium reactive widget that both supports Flutter Hooks and implicitly tracks and rebuilds on signal changes.
---

A premium reactive widget that both supports Flutter Hooks and implicitly tracks and rebuilds on signal changes.

<code>SignalHookWidget</code> establishes a dynamic reactive context directly at the Flutter element layer.
Any signal accessed via <code>.value</code> inside the **build** method is **implicitly tracked** and
subscribed to. At the same time, you can call any hooks (like <code>useFocusNode</code>, <code>useTextEditingController</code>, etc.)
within **build**.

This provides the ultimate developer experience, combining the power of implicit, boilerplate-free
signal tracking with the rich lifecycle management of Flutter Hooks.

### Dual Reactivity Example
```dart
final globalCartCount = signal(0);

class MyDualWidget extends SignalHookWidget {
  const MyDualWidget({super.key});

  @override
  Widget build(BuildContext context) {
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

##### <a name="signalhookwidget"></a><a name="signalhookwidget"></a><code>SignalHookWidget({super.key})</code>

Constructor for [SignalHookWidget](/types/signalhookwidget).

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createelement"></a><code>StatelessElement createElement()</code>

##### <a name="build"></a><code>Widget build(BuildContext context)</code>

Subclasses override this method to define their widget tree.

For backward compatibility, this defaults to calling **buildWidget**.

##### <a name="buildwidget"></a><code>Widget buildWidget(BuildContext context)</code>

Subclasses override this method instead of **build** to define their widget tree.

</details>
