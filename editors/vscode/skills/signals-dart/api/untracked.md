# function `untracked`

In case when you're receiving a callback that can read some signals, but you don't want to subscribe to them, you can use <code>untracked</code> to prevent any subscriptions from happening.

```dart
final counter = signal(0);
final effectCount = signal(0);
final fn = () => effectCount.value + 1;

effect(() {
	print(counter.value);

	// Whenever this effect is triggered, run `fn` that gives new value
	effectCount.value = untracked(fn);
});
```

---

## Signature

```dart
T untracked(UntrackedCallback<T> fn)
```

