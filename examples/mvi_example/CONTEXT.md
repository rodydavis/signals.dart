# MVI (Model-View-Intent) Example

This example demonstrates how to implement the **Model-View-Intent** (MVI) architecture using Signals as the primary state mechanism.

## Architecture

The project is structured around the core principles of MVI:
- **Model (State)**: Represented by a single, immutable state class (e.g., `LoginState`) held within a **`Signal`**.
- **View**: Flutter widgets that observe the state signal and render the UI. They use **`view_model_mixin.dart`** to handle lifecycle and event dispatching.
- **Intent (Events)**: User actions or system triggers are represented as discrete event classes (e.g., `LoginEmailChanged`).

## Core Components

### [BaseViewModel](file:///Users/rodydavis/Developer/signals.dart/examples/mvi_example/lib/core/base_view_model.dart)
The generic base class that orchestrates the MVI flow.
- **State Signal**: Manages a private `_state` signal and exposes a `readonly()` version to the view.
- **Events**: Uses a `StreamController` to queue and process incoming events sequentially via the `onEvent` method.
- **Effects**: Uses a separate stream for one-time side effects (like showing a snackbar or navigating), which shouldn't be part of the persistent UI state.

### [ViewModelMixin](file:///Users/rodydavis/Developer/signals.dart/examples/mvi_example/lib/core/view_model_mixin.dart)
A Flutter mixin that binds a `BaseViewModel` to a widget's lifecycle, ensuring that the view model is disposed of when the widget is unmounted.

## Feature Modules

- **[login/](file:///Users/rodydavis/Developer/signals.dart/examples/mvi_example/lib/login/)**: Demonstrates a complete flow including form validation, loading states, and side effects.
- **[posts/](file:///Users/rodydavis/Developer/signals.dart/examples/mvi_example/lib/posts/)**: Demonstrates list loading and asynchronous data fetching within the MVI pattern.
