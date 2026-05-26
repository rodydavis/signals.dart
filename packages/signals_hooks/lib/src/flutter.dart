import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';

import 'core.dart';

/// Creates a new mutable [Signal] from a [ValueNotifier] and subscribes to it.
///
/// This provides interoperability with standard Flutter classes, allowing you to bridge a [ValueNotifier]
/// into a fully reactive [Signal] container. Changes made to the [ValueNotifier] automatically update the signal,
/// and changes made to the [signal] automatically write back to the [ValueNotifier].
///
/// :::tip
/// This enables seamless bi-directional integration when working with external packages or existing widgets
/// that rely heavily on [ValueNotifier].
/// :::
///
/// ### Parameters
/// - [value]: The [ValueNotifier] to bridge.
/// - [keys]: A list of objects to watch. If any key changes, the signal is re-created.
/// - [debugLabel]: An optional debug label.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class LegacyBridgeWidget extends HookWidget {
///   const LegacyBridgeWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final notifier = useValueNotifier(0);
///     // Bridge the standard ValueNotifier to a fully reactive Signal
///     final countSignal = useValueNotifierToSignal(notifier);
///
///     return Column(
///       children: [
///         Text('ValueNotifier value: ${notifier.value}'),
///         Text('Signal value: ${countSignal.value}'),
///         ElevatedButton(
///           onPressed: () => countSignal.value++, // Updates notifier automatically
///           child: const Text('Increment Signal'),
///         ),
///       ],
///     );
///   }
/// }
/// ````
Signal<T> useValueNotifierToSignal<T>(
  ValueNotifier<T> value, {
  SignalOptions<T>? options,
  List<Object?> keys = const <Object>[],
}) {
  final s = useMemoized(
    () => valueNotifierToSignal(
      value,
      debugLabel: options?.name,
      autoDispose: options?.autoDispose ?? false,
    ),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [ReadonlySignal] from a [ValueListenable] and subscribes to it.
///
/// This provides read-only interoperability with standard Flutter classes, allowing you to bridge any
/// [ValueListenable] (like [ScrollController], [TextEditingController], or other custom listenables) into a
/// reactive [ReadonlySignal].
///
/// :::tip
/// Perfect for listening to UI framework states such as scroll offsets, keyboard visibility, or text inputs in a
/// clean, functional reactive style.
/// :::
///
/// ### Parameters
/// - [value]: The [ValueListenable] to bridge.
/// - [keys]: A list of objects to watch. If any key changes, the signal is re-created.
/// - [debugLabel]: An optional debug label.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class ScrollTrackerWidget extends HookWidget {
///   const ScrollTrackerWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final scrollController = useScrollController();
///     // Bridge the listenable offset to a reactive ReadonlySignal
///     final scrollSignal = useValueListenableToSignal(scrollController);
///
///     return Scaffold(
///       appBar: AppBar(
///         title: Text('Scroll Position: ${scrollSignal.value.toStringAsFixed(1)}'),
///       ),
///       body: ListView.builder(
///         controller: scrollController,
///         itemCount: 100,
///         itemBuilder: (context, idx) => ListTile(title: Text('Row $idx')),
///       ),
///     );
///   }
/// }
/// ````
ReadonlySignal<T> useValueListenableToSignal<T>(
  ValueListenable<T> value, {
  SignalOptions<T>? options,
  List<Object?> keys = const <Object>[],
}) {
  final s = useMemoized(
    () => valueListenableToSignal(
      value,
      debugLabel: options?.name,
      autoDispose: options?.autoDispose ?? false,
    ),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}
