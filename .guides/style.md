# Style Guide

## General

### Computed vs Effects

Use `computed` for derived state that you want to read later. Use `effect` for side effects (logging, API calls, etc.).

### Peek

Use `.peek()` only when you need to read a signal's value without subscribing to it (e.g., inside an effect where you update the signal based on its previous value).

### Collections

When working with lists, maps, or sets, prefer `ListSignal`, `MapSignal`, and `SetSignal` over `Signal<List>`, `Signal<Map>`, and `Signal<Set>`.

**Good:**

```dart
final list = listSignal([1, 2, 3]);
list.add(4); // Updates automatically
```

**Bad:**

```dart
final list = signal([1, 2, 3]);
list.value.add(4); // Does NOT trigger update!
list.value = [...list.value, 4]; // Expensive copy
```

## Flutter

### Watch vs .watch(context)

Prefer using the `Watch` widget over the `.watch(context)` extension method. `Watch` automatically handles subscription and unsubscription, whereas `.watch(context)` relies on the widget's lifecycle and garbage collection.

**Good:**

```dart
Watch((context) => Text('${signal.value}'))
```

**Bad:**

```dart
Text('${signal.watch(context)}')
```

### Creating Signals in Widgets

Do not create signals inside the `build` method unless you are using `SignalsMixin` and `createSignal` or `signals_hooks` and `useSignal`. Creating a global signal or a static signal is preferred for shared state.

**Good (Mixin):**

```dart
class _MyState extends State<MyWidget> with SignalsMixin {
  late final counter = createSignal(0);
  // ...
}
```

**Good (Hooks):**

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useSignal(0);
    // ...
  }
}
```

**Bad:**

```dart
Widget build(BuildContext context) {
  final counter = signal(0); // Recreated on every build!
  // ...
}
```
