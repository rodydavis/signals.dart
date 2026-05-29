# class `SignalCustomEquality`

Custom equality check using a custom function

Uses a custom comparison function to determine if two values of type **T** are equal.

### Example Usage

```dart
final equality = SignalEquality.custom((User a, User b) => a.id == b.id);
```

---

## Members of `SignalCustomEquality`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalCustomEquality** | `constructor` | `SignalCustomEquality(this._fn)` | Creates a new [SignalCustomEquality](/types/signalcustomequality) instance. |
| **equals** | `method` | `bool equals(Object? a, Object? b)` |  |
