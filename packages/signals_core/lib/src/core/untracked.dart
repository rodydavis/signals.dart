part of 'signals.dart';

/// A callback that is executed inside a computed.
typedef UntrackedCallback<T> = T Function();

/// {@template untracked}
/// In case when you're receiving a callback that can read some signals, but you don't want to subscribe to them, you can use `untracked` to prevent any subscriptions from happening.
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
/// @link https://dartsignals.dev/core/untracked
/// {@endtemplate}
T untracked<T>(UntrackedCallback<T> fn) => signals.untracked<T>(fn);
