# extension `ComparableSignalExtension`

Helper extensions for [ReadonlySignal<Comparable<T>>]

---

## Members of `ComparableSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **compareTo** | `method` | `int compareTo(T other)` | Compares this object to another object.

Returns a value like a **Comparator** when comparing <code>this</code> to **other**.
That is, it returns a negative integer if <code>this</code> is ordered before **other**,
a positive integer if <code>this</code> is ordered after **other**,
and zero if <code>this</code> and **other** are ordered together.

The **other** argument must be a value that is comparable to this object. |
