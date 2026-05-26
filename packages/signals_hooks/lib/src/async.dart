import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_core.dart';

import 'core.dart';

/// Creates a new [FutureSignal] and subscribes to it.
///
/// A [FutureSignal] wraps a standard Dart [Future] in a reactive state container, allowing you to
/// easily read the asynchronous operation's progress (`loading`, `error`, `data`) directly
/// in your build method without needing `FutureBuilder`.
///
/// :::tip
/// The signal automatically manages the lifecycle of the future and rebuilds the host widget
/// when the future transitions from loading to data or error.
/// :::
///
/// ### Parameters
/// - [value]: A callback returning the [Future] to execute.
/// - [keys]: A list of objects to watch for changes. If any key in this list changes, the existing future
///   is cancelled/ignored and a new future is created and subscribed to.
/// - [initialValue]: An optional initial value to display before the future completes.
/// - [dependencies]: An optional list of signals that this future depends on. If any dependency changes,
///   the future is automatically re-run.
/// - [lazy]: If true (default), the future won't start executing until the signal's value is first read.
/// - [debugLabel]: An optional debug label to identify this signal in devtools.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class UserProfileWidget extends HookWidget {
///   final int userId;
///   const UserProfileWidget({required this.userId, super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // Re-fetches user profile if userId changes
///     final userSignal = useFutureSignal(
///       () => fetchUserProfile(userId),
///       [userId],
///     );
///
///     return userSignal.value.map(
///       data: (user) => ListTile(
///         title: Text(user.name),
///         subtitle: Text(user.email),
///       ),
///       error: (err, stack) => Text('Error: $err'),
///       loading: () => const CircularProgressIndicator(),
///     );
///   }
/// }
/// ````
FutureSignal<T> useFutureSignal<T>(
  Future<T> Function() value, {
  List<Object?> keys = const <Object>[],
  AsyncSignalOptions<T>? options,
}) {
  final s = useMemoized(
    () => futureSignal(value, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [StreamSignal] and subscribes to it.
///
/// A [StreamSignal] wraps a standard Dart [Stream], capturing emitted events, errors,
/// and done notifications as reactive states (`loading`, `data`, `error`). The host widget
/// is automatically rebuilt on every stream emission.
///
/// :::tip
/// Clean up is fully automated: when the [HookWidget] is disposed, the underlying stream subscription
/// is cancelled to prevent memory leaks.
/// :::
///
/// ### Parameters
/// - [value]: A callback returning the [Stream] to subscribe to.
/// - [options]: An optional [StreamSignalOptions] to configure the stream signal.
/// - [keys]: A list of objects to watch. If any key changes, the hook unsubscribes from the old stream and
///   subscribes to the new one.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class ChatMessagesWidget extends HookWidget {
///   final String channelId;
///   const ChatMessagesWidget({required this.channelId, super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // Subscribes to chat stream, automatically switching streams if channelId changes
///     final streamSignal = useStreamSignal(
///       () => listenToChannel(channelId),
///       [channelId],
///     );
///
///     return streamSignal.value.map(
///       data: (message) => Text('New message: ${message.text}'),
///       error: (err, stack) => Text('Stream error: $err'),
///       loading: () => const Text('Connecting to channel...'),
///     );
///   }
/// }
/// ````
StreamSignal<T> useStreamSignal<T>(
  Stream<T> Function() value, {
  List<Object?> keys = const <Object>[],
  AsyncSignalOptions<T>? options,
}) {
  final s = useMemoized(
    () => streamSignal(value, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new mutable [AsyncSignal] initialized with a specific [AsyncState] and subscribes to it.
///
/// Unlike [useFutureSignal] and [useStreamSignal], an [AsyncSignal] exposes a mutable container where you can
/// manually publish asynchronous states (e.g. `AsyncState.loading()`, `AsyncState.data(...)`, or `AsyncState.error(...)`).
///
/// :::tip
/// This is perfect for manually managed async workflows, like handling a login button click where you want to
/// transitions states explicitly under your control.
/// :::
///
/// ### Parameters
/// - [value]: The initial [AsyncState] (e.g. `AsyncState.loading()` or `AsyncState.data(initialValue)`).
/// - [keys]: A list of objects to watch. If any key changes, the async signal will be re-created.
/// - [debugLabel]: An optional debug label.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class LoginButton extends HookWidget {
///   const LoginButton({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // Start in idle data state
///     final loginState = useAsyncSignal<void>(AsyncState.data(null));
///
///     Future<void> performLogin() async {
///       loginState.value = AsyncState.loading();
///       try {
///         await apiLogin();
///         loginState.value = AsyncState.data(null);
///       } catch (err, stack) {
///         loginState.value = AsyncState.error(err, stack);
///       }
///     }
///
///     return loginState.value.map(
///       data: (_) => ElevatedButton(
///         onPressed: performLogin,
///         child: const Text('Login'),
///       ),
///       error: (err, _) => Column(
///         children: [
///           Text('Error: $err', style: const TextStyle(color: Colors.red)),
///           ElevatedButton(onPressed: performLogin, child: const Text('Retry')),
///         ],
///       ),
///       loading: () => const CircularProgressIndicator(),
///     );
///   }
/// }
/// ````
AsyncSignal<T> useAsyncSignal<T>(
  AsyncState<T> value, {
  List<Object?> keys = const <Object>[],
  AsyncSignalOptions<T>? options,
}) {
  final s = useMemoized(() => asyncSignal(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [FutureSignal] from a computed async value and subscribes to it.
///
/// This hook allows you to construct an async computation that automatically reruns whenever its
/// reactive dependencies (e.g. other signals accessed via `.value`) or hook keys change.
///
/// :::tip
/// It combines the capabilities of computed/derived state with asynchronous futures, serving as a powerful
/// replacement for complex chain reactions of streams or state notifier combinations.
/// :::
///
/// ### Parameters
/// - [value]: The async computation function that depends on one or more reactive signals.
/// - [keys]: A list of objects to watch. If any key changes, the computation will be re-created.
/// - [dependencies]: A list of dependency signals to monitor. If any dependency signal fires, the async computation will rerun.
/// - [lazy]: If true (default), execution is delayed until the signal is first read.
/// - [initialValue]: An optional initial value before the computation resolves.
/// - [debugLabel]: An optional debug label.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class SearchResultsWidget extends HookWidget {
///   const SearchResultsWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final searchQuery = useSignal('');
///
///     // Re-runs search query automatically whenever searchQuery.value changes
///     final resultsSignal = useAsyncComputed(
///       () async {
///         if (searchQuery.value.isEmpty) return <SearchResult>[];
///         return await performSearch(searchQuery.value);
///       },
///       dependencies: [searchQuery],
///     );
///
///     return Column(
///       children: [
///         TextField(
///           onChanged: (val) => searchQuery.value = val,
///           decoration: const InputDecoration(labelText: 'Search'),
///         ),
///         Expanded(
///           child: resultsSignal.value.map(
///             data: (results) => ListView.builder(
///               itemCount: results.length,
///               itemBuilder: (context, idx) => ListTile(title: Text(results[idx].title)),
///             ),
///             error: (err, _) => Text('Error: $err'),
///             loading: () => const Center(child: CircularProgressIndicator()),
///           ),
///         ),
///       ],
///     );
///   }
/// }
/// ````
FutureSignal<T> useAsyncComputed<T>(
  Future<T> Function() value, {
  List<Object?> keys = const <Object>[],
  AsyncSignalOptions<T>? options,
}) {
  final s = useMemoized(
    () => computedAsync(value, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [Connect] instance and automatically disposes of it when the widget unmounts.
///
/// [Connect] connects one or more streams to feed a target signal.
///
/// :::tip
/// Clean up is fully automated: when the [HookWidget] is disposed, all connected streams are unsubscribed,
/// and the connected signal is disposed.
/// :::
///
/// ### Parameters
/// - [signal]: The target [Signal] to feed.
/// - [stream]: An optional initial stream to connect immediately.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class StreamingCounterWidget extends HookWidget {
///   const StreamingCounterWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final counter = useSignal(0);
///
///     // Automatically connects the periodic stream to the counter signal
///     final periodicStream = useMemoized(
///       () => Stream.periodic(const Duration(seconds: 1), (i) => i),
///     );
///     useConnect(counter, periodicStream);
///
///     return Text('Tick count: ${counter.value}');
///   }
/// }
/// ````
Connect<T, S> useConnect<T, S extends T>(
  Signal<T> signal, {
  Stream<S>? stream,
}) {
  final connector = useMemoized(() => connect<T, S>(signal, stream), [signal]);
  useEffect(() => connector.dispose, [connector]);
  return connector;
}
