# class `SignalProxyWidget`

A low-level widget wrapper around [RenderSignalProxyBox](/types/rendersignalproxybox) for custom painting / sizing needs.

---

## Members of `SignalProxyWidget`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **signals** | `field` | `List<core.ReadonlySignal<dynamic>> signals` | The list of signals to observe. |
| **SignalProxyWidget** | `constructor` | `SignalProxyWidget({super.key, required this.signals, super.child})` | Creates a new [SignalProxyWidget](/types/signalproxywidget). |
| **createRenderObject** | `method` | `RenderSignalProxyBox createRenderObject(BuildContext context)` |  |
| **updateRenderObject** | `method` | `void updateRenderObject(BuildContext context, RenderSignalProxyBox renderObject)` |  |
