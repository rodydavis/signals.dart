# extension `WriteableSignalUtils`

Utility extensions on [Signal](/types/signal) providing functional programming wrappers like React-style hooks destructuring.

---

## Members of `WriteableSignalUtils`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **hooks** | `method` | `(T Function(), void Function(T)) hooks` | Easy destructure to get and set the value

```dart
final counter = signal(0);
...
final (getCount, setCount) = counter.hooks;
``` |
