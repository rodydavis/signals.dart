# Primitive: `AsyncComputed`

- **Category**: Derived
- **Description**: Asynchronous Computed is syntax sugar around FutureSignal for async dependent tasks.

---

## Standard Usage Example

```dart
final apiResults = computedAsync(() => 
  fetchFromApi(searchQuery.value),
  options: AsyncSignalOptions(name: 'apiResults')
);

```
