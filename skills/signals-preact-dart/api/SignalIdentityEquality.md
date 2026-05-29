# class `SignalIdentityEquality`

Identity equality check (identical(a, b))

Matches two objects only if they point to the exact same instance in memory.

### Example Usage

```dart
final listA = [1, 2];
final listB = [1, 2];
final equality = SignalEquality.identity<List<int>>();
print(equality.equals(listA, listB)); // false
print(equality.equals(listA, listA)); // true
```

---

## Members of `SignalIdentityEquality`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalIdentityEquality** | `constructor` | `SignalIdentityEquality()` | Creates a new [SignalIdentityEquality](/types/signalidentityequality) instance. |
| **equals** | `method` | `bool equals(Object? a, Object? b)` |  |
