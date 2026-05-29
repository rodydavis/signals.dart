# class `MultiSignalProvider`

A dependency-injection / state propagation widget that allows passing
multiple reactive signals down the Flutter widget tree.

This avoids the deeply nested trees that result from nesting multiple
single [SignalProvider](/types/signalprovider) widgets.

---

## Members of `MultiSignalProvider`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MultiSignalProvider** | `constructor` | `MultiSignalProvider({super.key, required this.providers, required this.child})` | Exposes multiple [SignalProvider](/types/signalprovider) widgets inside a flat list. |
| **providers** | `field` | `List<SignalProvider> providers` | The list of single [SignalProvider](/types/signalprovider) widgets to nest. |
| **child** | `field` | `Widget child` | The widget subtree that will have access to the provided signals. |
| **build** | `method` | `Widget build(BuildContext context)` |  |
