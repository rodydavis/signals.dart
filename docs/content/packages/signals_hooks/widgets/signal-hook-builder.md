---
title: SignalHookBuilder
description: A premium, localized builder widget that behaves exactly like SignalHookWidget.
---

A premium, localized builder widget that behaves exactly like [SignalHookWidget](/packages/signals_hooks/widgets/signal-hook-widget)
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

##### <a name="signalhookbuilder"></a><a name="signalhookbuilder"></a>`SignalHookBuilder({super.key, required this.builder})`

Creates a [SignalHookBuilder](/packages/signals_hooks/widgets/signal-hook-builder) widget.


### Properties

##### <a name="builder"></a>`Widget Function(BuildContext context) builder`

The widget builder callback.


### Methods

##### <a name="buildwidget"></a>`Widget buildWidget(BuildContext context)`
