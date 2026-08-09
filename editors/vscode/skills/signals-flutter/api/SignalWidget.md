# class `SignalWidget`

A reactive **StatelessWidget** that implicitly tracks and rebuilds on signal changes.

<code>SignalWidget</code> establishes a dynamic reactive context directly at the Flutter element layer.
Any signal accessed via <code>.value</code> inside the **build** method is **implicitly tracked** and
subscribed to. When any of these signals mutate, only this widget is rebuilt.

This offers a clean, Javascript-style reactivity experience without needing manual
builder widgets (like <code>SignalBuilder</code>) or deprecated context watch extensions.

### Implicit Reactivity Example (Stateless)
```dart
final username = signal('Rody');
final status = signal('Online');

class UserProfileView extends SignalWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // 'username' and 'status' are implicitly tracked on access:
    return Column(
      children: [
        Text('Name: ${username.value}'),
        Text('Status: ${status.value}'),
      ],
    );
  }
}
```

> [!IMPORTANT]
> Only signals accessed *synchronously* during the execution of the <code>build</code> method are tracked.
> Signals read inside async callbacks, listeners, or deferred tasks are not subscribed to.

---

## Members of `SignalWidget`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalWidget** | `constructor` | `SignalWidget({super.key})` | Constructor for [SignalWidget](/types/signalwidget). |
| **createElement** | `method` | `StatelessElement createElement()` |  |
