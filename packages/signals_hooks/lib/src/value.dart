import 'dart:collection';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_core.dart';

import 'core.dart';

/// Creates a new [ListSignal] and subscribes to it.
///
/// A [ListSignal] provides a reactive wrapper around a standard Dart [List]. It tracks mutations
/// (such as `.add()`, `.remove()`, or setting an element at an index) and automatically triggers
/// rebuilds of the host [HookWidget] when they occur.
///
/// :::tip
/// Since Dart lists are objects, standard signals only track identity changes. [ListSignal] tracks
/// in-place mutations as well, making it highly efficient for managing dynamic lists in your UI.
/// :::
///
/// ### Parameters
/// - [value]: The initial list elements.
/// - [keys]: A list of objects to watch. If any key changes, the list signal is re-created.
/// - [debugLabel]: An optional debug label.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class TodoListWidget extends HookWidget {
///   const TodoListWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // Creates a reactive list managed by this widget
///     final todos = useListSignal<String>([]);
///
///     return Column(
///       children: [
///         ElevatedButton(
///           onPressed: () => todos.add('Task ${todos.length + 1}'),
///           child: const Text('Add Task'),
///         ),
///         Expanded(
///           child: ListView.builder(
///             itemCount: todos.length,
///             itemBuilder: (context, idx) => ListTile(
///               title: Text(todos[idx]),
///               trailing: IconButton(
///                 icon: const Icon(Icons.delete),
///                 onPressed: () => todos.removeAt(idx),
///               ),
///             ),
///           ),
///         ),
///       ],
///     );
///   }
/// }
/// ````
ListSignal<T> useListSignal<T>(
  List<T> value, [
  List<Object?> keys = const <Object>[],
  ListSignalOptions<T>? options,
]) {
  final s = useMemoized(() => listSignal(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [SetSignal] and subscribes to it.
///
/// A [SetSignal] provides a reactive wrapper around a standard Dart [Set]. It tracks mutations
/// (such as `.add()`, `.remove()`, `.clear()`) and automatically triggers rebuilds of the host [HookWidget].
///
/// :::tip
/// Useful for managing collections of unique items, like active filters, selected item IDs,
/// or tagged items in a multi-select interface.
/// :::
///
/// ### Parameters
/// - [value]: The initial set elements.
/// - [options]: The options for the signal.
/// - [keys]: A list of objects to watch. If any key changes, the set signal is re-created.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class CategoryFilterWidget extends HookWidget {
///   const CategoryFilterWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final selectedCategories = useSetSignal<String>({});
///
///     void toggleCategory(String cat) {
///       if (selectedCategories.contains(cat)) {
///         selectedCategories.remove(cat);
///       } else {
///         selectedCategories.add(cat);
///       }
///     }
///
///     return Row(
///       children: ['Tech', 'News', 'Lifestyle'].map((cat) {
///         final isSelected = selectedCategories.contains(cat);
///         return FilterChip(
///           label: Text(cat),
///           selected: isSelected,
///           onSelected: (_) => toggleCategory(cat),
///         );
///       }).toList(),
///     );
///   }
/// }
/// ````
SetSignal<T> useSetSignal<T>(
  Set<T> value, [
  List<Object?> keys = const <Object>[],
  SetSignalOptions<T>? options,
]) {
  final s = useMemoized(() => setSignal(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [IterableSignal] and subscribes to it.
///
/// An [IterableSignal] provides a reactive wrapper around a Dart [Iterable], notifying subscribers
/// and rebuilding [HookWidget]s when the iterable structure is mutated or replaced.
///
/// ### Parameters
/// - [value]: The initial iterable elements.
/// - [options]: The options for the signal.
/// - [keys]: A list of objects to watch. If any key changes, the iterable signal is re-created.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class IterableDisplay extends HookWidget {
///   const IterableDisplay({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final sequence = useIterableSignal(Iterable<int>.generate(5));
///     return ListView(
///       children: sequence.map((num) => ListTile(title: Text('Item $num'))).toList(),
///     );
///   }
/// }
/// ````
IterableSignal<T> useIterableSignal<T>(
  Iterable<T> value, [
  List<Object?> keys = const <Object>[],
  IterableSignalOptions<T>? options,
]) {
  final s =
      useMemoized(() => iterableSignal(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [MapSignal] and subscribes to it.
///
/// A [MapSignal] provides a reactive wrapper around a standard Dart [Map]. It tracks in-place mutations
/// (such as entry addition, value updates, or key removals) and automatically triggers rebuilds of the host [HookWidget].
///
/// :::tip
/// Excellent for storing state dictionaries, form configurations, cached records, or key-value structures
/// that require fine-grained reactivity.
/// :::
///
/// ### Parameters
/// - [value]: The initial map entries.
/// - [options]: The options for the signal.
/// - [keys]: A list of objects to watch. If any key changes, the map signal is re-created.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class DynamicFormWidget extends HookWidget {
///   const DynamicFormWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final formData = useMapSignal<String, String>({});
///
///     return Column(
///       children: [
///         TextField(
///           decoration: const InputDecoration(labelText: 'Email'),
///           onChanged: (val) => formData['email'] = val,
///         ),
///         TextField(
///           decoration: const InputDecoration(labelText: 'Password'),
///           onChanged: (val) => formData['password'] = val,
///         ),
///         Text('Live Form Data: ${formData.value}'),
///       ],
///     );
///   }
/// }
/// ````
MapSignal<K, V> useMapSignal<K, V>(
  Map<K, V> value, [
  List<Object?> keys = const <Object>[],
  MapSignalOptions<K, V>? options,
]) {
  final s = useMemoized(() => mapSignal(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [TrackedSignal] and subscribes to it.
///
/// A [TrackedSignal] extends standard signals by maintaining a record of its previous value alongside its
/// current value. This allows you to inspect history changes, calculate delta differences, or perform custom transition animations.
///
/// :::tip
/// You can access both the current value using `.value` and the previous value using `.previousValue`.
/// :::
///
/// ### Parameters
/// - [value]: The initial value of the signal.
/// - [options]: The options for the signal.
/// - [keys]: A list of objects to watch. If any key changes, the signal is re-created.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class DeltaCounterWidget extends HookWidget {
///   const DeltaCounterWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final count = useTrackedSignal(0);
///
///     return Column(
///       children: [
///         Text('Current: ${count.value}'),
///         Text('Previous: ${count.previousValue ?? "N/A"}'),
///         ElevatedButton(
///           onPressed: () => count.value++,
///           child: const Text('Increment'),
///         ),
///       ],
///     );
///   }
/// }
/// ````
TrackedSignal<T> useTrackedSignal<T>(
  T value, [
  List<Object?> keys = const <Object>[],
  TrackedSignalOptions<T>? options,
]) {
  final s =
      useMemoized(() => trackedSignal(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [QueueSignal] and subscribes to it.
///
/// A [QueueSignal] wraps a Dart [Queue], providing reactive tracking for queue operations like adding items to
/// the end or removing items from the front. Perfect for task pipelines, notification streams, or undo histories.
///
/// ### Parameters
/// - [value]: The initial queue items.
/// - [options]: The options for the signal.
/// - [keys]: A list of objects to watch. If any key changes, the queue signal is re-created.
///
/// ### Example
///
/// ````dart
/// import 'dart:collection';
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class NotificationQueueWidget extends HookWidget {
///   const NotificationQueueWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final notifications = useQueueSignal<String>(Queue());
///
///     return Column(
///       children: [
///         ElevatedButton(
///           onPressed: () => notifications.addLast('Alert at ${DateTime.now()}'),
///           child: const Text('Enqueue Alert'),
///         ),
///         if (notifications.isNotEmpty)
///           ElevatedButton(
///             onPressed: () => notifications.removeFirst(),
///             child: const Text('Dismiss Oldest Alert'),
///           ),
///         Expanded(
///           child: ListView(
///             children: notifications.map((note) => ListTile(title: Text(note))).toList(),
///           ),
///         ),
///       ],
///     );
///   }
/// }
/// ````
QueueSignal<T> useQueueSignal<T>(
  Queue<T> value, [
  List<Object?> keys = const <Object>[],
  QueueSignalOptions<T>? options,
]) {
  final s = useMemoized(() => queueSignal(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [ChangeStackSignal] and subscribes to it.
///
/// A [ChangeStackSignal] maintains an undo/redo history stack of value updates. This enables effortless
/// undo/redo mechanisms for user edits, document updates, or game actions.
///
/// :::tip
/// Use `.undo()` to step backwards, `.redo()` to step forwards, and check `.canUndo` and `.canRedo`
/// to determine button enabling states.
/// :::
///
/// ### Parameters
/// - [value]: The initial value of the stack.
/// - [options]: The options for the signal.
/// - [keys]: A list of objects to watch. If any key changes, the change stack is re-created.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class SketchPadWidget extends HookWidget {
///   const SketchPadWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final colorStack = useChangeStackSignal<Color>(Colors.red, limit: 10);
///
///     return Column(
///       children: [
///         Container(
///           width: 100,
///           height: 100,
///           color: colorStack.value,
///         ),
///         Row(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             IconButton(
///               icon: const Icon(Icons.undo),
///               onPressed: colorStack.canUndo ? () => colorStack.undo() : null,
///             ),
///             IconButton(
///               icon: const Icon(Icons.redo),
///               onPressed: colorStack.canRedo ? () => colorStack.redo() : null,
///             ),
///           ],
///         ),
///         Wrap(
///           children: [Colors.blue, Colors.green, Colors.orange, Colors.purple].map((col) {
///             return GestureDetector(
///               onTap: () => colorStack.value = col,
///               child: Container(
///                 width: 40,
///                 height: 40,
///                 color: col,
///                 margin: const EdgeInsets.all(4),
///               ),
///             );
///           }).toList(),
///         ),
///       ],
///     );
///   }
/// }
/// ````
ChangeStackSignal<T> useChangeStackSignal<T>(
  T value, [
  List<Object?> keys = const <Object>[],
  ChangeSignalOptions<T>? options,
]) {
  final s = useMemoized(
    () => changeStack(value, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}
