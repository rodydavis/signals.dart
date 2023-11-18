# Dart Signals

Based on the [following article](http://webcache.googleusercontent.com/search?q=cache:https://medium.com/gft-engineering/implementing-signals-in-javascript-step-by-step-9d0be46fb014&sca_esv=583538769&strip=1&vwsrc=0).

## Example

```dart
// Create signals
final count = createSignal(0);
final multiplier = createSignal(2);

// Creating a computed value
final multipliedCount = createComputed(() {
    return count.value * multiplier.value;
});

createEffect(() {
    print('Effect called: Count is ${count.value} and multiplier is ${multiplier.value}');
});

expect(multipliedCount.value, 0);

count.value = 1;
expect(multipliedCount.value, 2);

multiplier.value = 3;
expect(multipliedCount.value, 3);
```

This should print:

```
Effect called: Count is 0 and multiplier is 2
Effect called: Count is 1 and multiplier is 2
Effect called: Count is 1 and multiplier is 3
```

See [example/web/main.dart](example/web/main.dart) for a full example.
