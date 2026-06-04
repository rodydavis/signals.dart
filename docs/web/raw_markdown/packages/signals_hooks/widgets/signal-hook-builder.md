---
title: SignalHookBuilder
description: A premium, localized builder widget that behaves exactly like SignalHookWidget.
---

A premium, localized builder widget that behaves exactly like [SignalHookWidget](/types/signalhookwidget)
but in a builder format.

Allows mixing hooks and implicit signal tracking within a localized subtree builder callback.

### Example Usage
```dart
final count = signal(0);

Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: SignalHookBuilder(
        builder: (context) {
          // Call standard hooks inside the builder:
          final controller = useTextEditingController();
          final focusNode = useFocusNode();

          // Access signals implicitly. Only this subtree will rebuild when count changes:
          return Column(
            children: [
              TextField(controller: controller, focusNode: focusNode),
              Text('Counter: ${count.value}'),
            ],
          );
        },
      ),
    ),
  );
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalhookbuilder"></a><a name="signalhookbuilder"></a>`SignalHookBuilder({super.key, required this.builder})`

Creates a [SignalHookBuilder](/types/signalhookbuilder) widget.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="builder"></a>`Widget Function(BuildContext context) builder`

The widget builder callback.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a>`Widget build(BuildContext context)`

</details>
