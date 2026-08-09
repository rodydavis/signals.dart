# class `RenderSignalProxyBox`

A low-level **RenderProxyBox** that subscribes to multiple reactive signals
and automatically schedules repaints without layout/rebuild when signals fire.

---

## Members of `RenderSignalProxyBox`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **RenderSignalProxyBox** | `constructor` | `RenderSignalProxyBox({required List<core.ReadonlySignal<dynamic>> signals})` | Creates a new [RenderSignalProxyBox](/types/rendersignalproxybox) with the specified list of observed **signals**. |
| **signals** | `method` | `List<core.ReadonlySignal<dynamic>> signals` | Gets the current list of signals being observed. |
| **signals** | `method` | `signals(List<core.ReadonlySignal<dynamic>> val)` | Sets a new list of observed signals and resubscribes to them. |
| **detach** | `method` | `void detach()` |  |
