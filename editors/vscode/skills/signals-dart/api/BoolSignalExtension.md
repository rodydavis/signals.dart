# extension `BoolSignalExtension`

Helper extensions for [ReadonlySignal<bool>](/types/readonlysignal), enabling direct reactive logical conjunction (&), disjunction (|), and exclusive or (^) operations.

```dart
import 'package:signals_core/signals_core.dart';

final a = true.$;
final b = false.$;
final andResult = a & b.value; // false
final orResult = a | b.value; // true
```

---

## Members of `BoolSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **&** | `method` | `bool &(bool other)` | The logical conjunction ("and") of this and **other**.

Returns <code>true</code> if both this and **other** are <code>true</code>, and <code>false</code> otherwise. |
| **|** | `method` | `bool |(bool other)` | The logical disjunction ("inclusive or") of this and **other**.

Returns <code>true</code> if either this or **other** is <code>true</code>, and <code>false</code> otherwise. |
| **^** | `method` | `bool ^(bool other)` | The logical exclusive disjunction ("exclusive or") of this and **other**.

Returns whether this and **other** are neither both <code>true</code> nor both <code>false</code>. |
