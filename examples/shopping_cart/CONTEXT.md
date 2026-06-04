# Shopping Cart Example

A complex Flutter application demonstrating architectural best practices using Signals and dependency injection.

## Architecture

This example follows a **Service-Controller-View** pattern:
- **Services**: Handle raw data operations and I/O (e.g., `CartService`).
- **Controllers**: Manage business logic and expose state via signals (e.g., `CartController`). They use `AsyncState` to represent loading, data, and error states.
- **Views**: Flutter widgets that "watch" signals for surgical updates.

## Key Features

- **[AsyncState](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/CONTEXT.md)**: Demonstrates how to handle asynchronous data loading with a signalized state.
- **Dependency Injection**: Uses `lite_ref` in **[deps.dart](file:///Users/rodydavis/Developer/signals.dart/examples/shopping_cart/lib/deps.dart)** to provide singletons and handle dependency graph management.
- **Event-Based Updates**: Controllers use a `dispatch` method to handle events, ensuring a clear flow of data.

## Directory Structure

### [lib/](file:///Users/rodydavis/Developer/signals.dart/examples/shopping_cart/lib/)
The core implementation.
- **`src/`**: Divided into feature modules (`cart`, `catalog`).
- **`deps.dart`**: Global reference definitions for the application services.
