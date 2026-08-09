# class `SignalModel`

A premium wrapper for cohesive state packages constructed with [createModel](/types/createmodel).

It holds the instanced model **value** and all the [Effect](/types/effect)s that were captured
during its construction. Disposing the [SignalModel](/types/signalmodel) automatically disposes of all
nested/captured effects, completely avoiding memory leaks.

### Premium Pattern: Dart 3+ Extension Type Wrappers
To avoid unchecked subscript access like <code>model['count'].value</code>, wrap your model in an extension type:

```dart
extension type TypeSafeCounter(SignalModel<Map<String, dynamic>> _model) {
  int get count => (_model['count'] as Signal<int>).value;
  set count(int val) => (_model['count'] as Signal<int>).value = val;
  void increment() => (_model['increment'] as Function)();
  void dispose() => _model.dispose();
}
```

---

## Members of `SignalModel`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **value** | `field` | `T value` | The instanced model value. |
| **options** | `field` | `SignalModelOptions options` | Options used to configure this model. |
| **SignalModel** | `constructor` | `SignalModel(this.value, this._effects, {this.options = const SignalModelOptions()})` | Creates a new model instance. |
| **[]** | `method` | `dynamic [](Object? key)` | Access properties dynamically if the underlying **value** is a **Map**. |
| **[]=** | `method` | `void []=(dynamic key, dynamic val)` | Set properties dynamically if the underlying **value** is a **Map**. |
| **call** | `method` | `T call()` | Returns the **value** of this model. Alias for [.value] |
| **dispose** | `method` | `void dispose()` | Disposes of all captured effects. |
