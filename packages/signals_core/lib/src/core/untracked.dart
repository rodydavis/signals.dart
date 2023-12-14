part of 'signals.dart';

int _untrackedDepth = 0;

typedef UntrackedCallback<T> = T Function();

/// In case when you're receiving a callback that can read some signals,
/// but you don't want to subscribe to them, you can use `untracked` to
/// prevent any subscriptions from happening.
///
/// ```dart
/// final counter = signal(0);
/// final effectCount = signal(0);
/// final fn = () => effectCount.value + 1;
///
/// effect(() {
/// 	print(counter.value);
///
/// 	// Whenever this effect is triggered, run `fn` that gives new value
/// 	effectCount.value = untracked(fn);
/// });
/// ```
T untracked<T>(UntrackedCallback<T> callback) {
  if (_untrackedDepth > 0) {
    return callback();
  }
  final prevContext = _evalContext;
  _evalContext = null;
  _untrackedDepth++;
  try {
    return callback();
  } finally {
    _untrackedDepth--;
    _evalContext = prevContext;
  }
}
