# extension `EnumSignalExtension`

Helper extensions for [ReadonlySignal<Enum>](/types/readonlysignal)

---

## Members of `EnumSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **index** | `method` | `int index` | A numeric identifier for the enumerated value.

The values of a single enumeration are numbered
consecutively from zero to one less than the
number of values.
This is also the index of the value in the
enumerated type's static <code>values</code> list. |
| **name** | `method` | `String name` | The name of the enum value.

The name is a string containing the source identifier used
to declare the enum value.

For example, given a declaration like:
```dart
enum MyEnum {
  value1,
  value2
}
```
the result of <code>MyEnum.value1.name</code> is the string <code>"value1"</code>. |
