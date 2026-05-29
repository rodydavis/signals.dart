---
title: SignalEffect
description: A widget that enables executing scoped reactive side-effects inline within the widget tree.
---

A widget that enables executing scoped reactive side-effects inline within the widget tree.

<code>SignalEffect</code> (and its direct type alias **SignalListener**) allows you to run side-effects
(such as showing snackbars, opening dialogs, navigating, or logging metrics) in response
to signal updates, without triggering rebuilds of the child widget tree.

The [effect](/types/effect) callback runs immediately on mount and dynamically tracks any signals accessed
within its scope. The underlying subscription is automatically disposed when this widget
is removed from the tree. You can optionally return a cleanup function (e.g. <code>void Function()</code>)
to run before the next execution or when the widget is disposed.

### Dialog and Snackbar Trigger Example
```dart
final count = signal(0);

class SnackBarTrigger extends StatelessWidget {
  const SnackBarTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalEffect(
      effect: (context) {
        // Triggers whenever 'count' updates:
        if (count.value >= 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Limit reached: ${count.value}!')),
          );
        }
        // Optional: return cleanup callback
        return () => print('Cleaning up effect');
      },
      child: ElevatedButton(
        onPressed: () => count.value++,
        child: const Text('Increment and Watch'),
      ),
    );
  }
}
```

> [!IMPORTANT]
> Do not perform synchronous state changes or trigger widget rebuilds directly inside
> the effect callback to prevent infinite reactive loops.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signaleffect"></a><a name="signaleffect"></a><code>SignalEffect({dynamic Function(BuildContext context)? effect, @Deprecated('Use effect instead') void Function(BuildContext context)? callback, required this.child, this.debugLabel, super.key})</code>

Creates a [SignalEffect](/types/signaleffect) widget.

The [effect](/types/effect) is executed inside a reactive effect.
The **child** is rendered normally.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="child"></a><code>Widget child</code>

The child widget to render.

##### <a name="debuglabel"></a><code>String? debugLabel</code>

Optional debug label for the effect.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="effect"></a><code>dynamic Function(BuildContext context) effect</code>

Gets the effect callback to run inside the reactive effect.

##### <a name="createstate"></a><code>State<SignalEffect> createState()</code>

</details>
