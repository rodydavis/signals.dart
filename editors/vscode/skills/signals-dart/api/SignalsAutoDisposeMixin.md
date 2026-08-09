# mixin `SignalsAutoDisposeMixin`

Mixin to enable autodispose on a signal

---

## Members of `SignalsAutoDisposeMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Throws and error if read after dispose and can be
disposed on last unsubscribe. |
| **disposed** | `method` | `bool disposed` | Check if the effect is disposed |
| **onDispose** | `method` | `void Function() onDispose(void Function() cleanup)` | Add a cleanup function to be called when the signal is disposed

```dart
final counter = signal(0);
final effectCount = signal(0);

final cleanup = counter.onDispose(() {
 print('Counter has been disposed');
});

// Remove the cleanup function
cleanup();
``` |
| **disposed** | `method` | `disposed(bool value)` | Force a signal to be disposed |
| **dispose** | `method` | `void dispose()` | Dispose the signal |
