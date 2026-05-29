# class `SignalEffectException`

Error for when a effect fails to run the callback

---

## Members of `SignalEffectException`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **error** | `field` | `Object? error` | Error during callback |
| **stackTrace** | `field` | `StackTrace? stackTrace` | StackTrace for where the error started |
| **SignalEffectException** | `constructor` | `SignalEffectException(this.error, [this.stackTrace])` | Error for when a effect fails to run the callback |
| **toString** | `method` | `String toString()` |  |
