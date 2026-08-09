# class `SignalElement`

Element for [SignalWidget](/types/signalwidget) that manages implicit signal subscription and handles dynamic branching.

---

## Members of `SignalElement`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalElement** | `constructor` | `SignalElement(super.widget)` | Constructor for [SignalElement](/types/signalelement). |
| **watchSignal** | `method` | `void watchSignal(core.ReadonlySignal value)` | Subscribes to changes of the provided **value** and schedules a rebuild. |
| **build** | `method` | `Widget build()` |  |
| **unmount** | `method` | `void unmount()` |  |
