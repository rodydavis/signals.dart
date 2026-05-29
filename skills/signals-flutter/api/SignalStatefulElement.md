# class `SignalStatefulElement`

Element for [SignalStatefulWidget](/types/signalstatefulwidget) that manages implicit signal subscription and handles dynamic branching.

---

## Members of `SignalStatefulElement`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalStatefulElement** | `constructor` | `SignalStatefulElement(super.widget)` | Constructor for [SignalStatefulElement](/types/signalstatefulelement). |
| **watchSignal** | `method` | `void watchSignal(core.ReadonlySignal value)` | Subscribes to changes of the provided **value** and schedules a rebuild. |
| **build** | `method` | `Widget build()` |  |
| **unmount** | `method` | `void unmount()` |  |
