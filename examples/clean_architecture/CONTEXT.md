# Clean Architecture Example

This project demonstrates a production-ready application architecture using Signals, following the principles of **Clean Architecture**.

## Architectural Layers

### [Domain](file:///Users/rodydavis/Developer/signals.dart/examples/clean_architecture/lib/domain/)
The core of the application, independent of any external frameworks.
- **Models**: Plain Dart classes representing the business entities.
- **Usecases**: The application-specific business rules.
- **Repositories (Interfaces)**: Abstract definitions for data fetching.

### [Data](file:///Users/rodydavis/Developer/signals.dart/examples/clean_architecture/lib/data/)
The implementation layer for data sources and repository interfaces.
- **Sources**: Concrete implementations for API calls or database operations.
- **Repositories**: Map data models to domain models and coordinate data flow.

### [Presentation](file:///Users/rodydavis/Developer/signals.dart/examples/clean_architecture/lib/presentation/)
The UI layer where Signals are utilized.
- **ViewModels**: Use Signals to expose reactive state to the view.
- **Views**: Flutter widgets that use `Watch` or `SignalsMixin` to surgically rebuild based on view model changes.

## Why Signals in Clean Architecture?
Signals provide a robust way to bridge the gap between the Domain layer's reactive requirements and the Presentation layer's UI updates without introducing a heavy dependence on Flutter-specific logic in the business layer.
