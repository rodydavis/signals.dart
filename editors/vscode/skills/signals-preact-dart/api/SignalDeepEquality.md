# class `SignalDeepEquality`

Deep equality check for collections

Recursively compares Lists, Maps, and Sets to see if their nested elements are equal.

### Example Usage

```dart
final equality = SignalEquality.deep();
print(equality.equals([1, [2, 3]], [1, [2, 3]])); // true
```

---

## Members of `SignalDeepEquality`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalDeepEquality** | `constructor` | `SignalDeepEquality()` | Creates a new [SignalDeepEquality](/types/signaldeepequality) instance. |
| **equals** | `method` | `bool equals(Object? a, Object? b)` |  |
