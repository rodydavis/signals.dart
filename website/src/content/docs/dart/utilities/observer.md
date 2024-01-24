---
title: SignalsObserver
description: Observe all signals created and updated
---

You can observe all signal values in the dart application by providing an implementation of `SignalsObserver`:

```dart
abstract class SignalsObserver {
  void onSignalCreated(Signal instance);

  void onSignalUpdated(Signal instance, dynamic value);

  void onComputedCreated(Computed instance);

  void onComputedUpdated(Computed instance, dynamic value);

  static SignalsObserver? instance;
}
```

> There is a prebuilt `LoggingSignalsObserver` for printing updates to the console.

To add the observer override the instance at the start of the application:

```dart
void main() {
    SignalsObserver.instance = LoggingSignalsObserver(); // or custom observer
    ...
}
```

This will have a slight performance hit since every update will be tracked via the observer. It is recommended to only set the `SignalsObserver.instance` in debug or profile mode.
