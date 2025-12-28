import 'package:meta/meta.dart';

import 'effect.dart';
import 'globals.dart';
import 'listenable.dart';
import 'node.dart';
import 'signal.dart';

/// An interface for read-only signals.
import 'options.dart';
import 'untracked.dart';

import 'equality.dart';

/// An interface for read-only signals.
mixin class ReadonlySignal<T> {
  /// Global ID of the signal
  int get globalId => throw UnimplementedError();

  /// Compute the current value
  T get value => throw UnimplementedError();

  @internal

  /// @nodoc
  T get internalValue => throw UnimplementedError();

  /// The name of the signal, used for debugging
  String? name;

  /// Callback when the signal is first subscribed to
  @internal
  SignalCallback<T>? watched;

  /// Callback when the signal is no longer subscribed to
  @internal
  SignalCallback<T>? unwatched;

  /// Custom equality check for the signal value
  @internal
  SignalEquality<T> equalityCheck = SignalEquality.standard<T>();

  @override
  String toString() => value.toString();

  /// Convert value to JSON
  dynamic toJson() => value;

  /// Return the value when invoked
  T call() => value;

  /// Helper method to get the current value
  T get() => value;

  /// In the rare instance that you have an effect that should write to another signal based on the previous value, but you _don't_ want the effect to be subscribed to that signal, you can read a signals's previous value via `signal.peek()`.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final effectCount = signal(0);
  ///
  /// effect(() {
  /// 	print(counter.value);
  ///
  /// 	// Whenever this effect is triggered, increase `effectCount`.
  /// 	// But we don't want this signal to react to `effectCount`
  /// 	effectCount.value = effectCount.peek() + 1;
  /// });
  /// ```
  ///
  /// Note that you should only use `signal.peek()` if you really need it. Reading a signal's value via `signal.value` is the preferred way in most scenarios.
  T peek() {
    final prevContext = evalContext;
    evalContext = null;
    try {
      return value;
    } finally {
      evalContext = prevContext;
    }
  }

  /// Subscribe to value changes with a dispose function
  void Function() subscribe(void Function(T value) fn) =>
      throw UnimplementedError();

  @internal

  /// @nodoc
  void subscribeToNode(Node node) => throw UnimplementedError();

  @internal

  /// @nodoc
  void unsubscribeFromNode(Node node) => throw UnimplementedError();

  @internal

  /// @nodoc
  void internalSubscribe(Node node) {
    final signal = this;
    final targets = signal.targets;
    if (targets != node && node.prevTarget == null) {
      node.nextTarget = targets;
      signal.targets = node;

      if (targets != null) {
        targets.prevTarget = node;
      } else {
        // First subscriber
        if (watched != null) {
          untracked(() {
            watched!(signal);
          });
        }
      }
    }
  }

  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  @internal
  int get version => throw UnimplementedError();

  @internal

  /// @nodoc
  Node? node;

  @internal

  /// @nodoc
  Node? targets;

  @internal

  /// @nodoc
  bool internalRefresh() => throw UnimplementedError();

  @internal

  /// @nodoc
  final Symbol brand = BRAND_SYMBOL;

  @internal

  /// @nodoc
  Iterable<Listenable> readonlySignalTargets() sync* {
    final instance = this;
    for (Node? node = instance.targets; node != null; node = node.nextTarget) {
      yield node.target;
    }
  }

  @internal

  /// @nodoc
  Node? addDependency() {
    final signal = this;
    if (evalContext == null) {
      return null;
    }

    var node = signal.node;
    if (node == null || node.target != evalContext) {
      /**
		 * `signal` is a new dependency. Create a new dependency node, and set it
		 * as the tail of the current context's dependency list. e.g:
		 *
		 * { A <-> B       }
		 *         ↑     ↑
		 *        tail  node (new)
		 *               ↓
		 * { A <-> B <-> C }
		 *               ↑
		 *              tail (evalContext._sources)
		 */
      node = Node()
        ..version = 0
        ..source = signal
        ..prevSource = evalContext!.sources
        ..nextSource = null
        ..target = evalContext!
        ..prevTarget = null
        ..nextTarget = null
        ..rollbackNode = node;

      if (evalContext!.sources != null) {
        evalContext!.sources!.nextSource = node;
      }
      evalContext!.sources = node;
      signal.node = node;

      // Subscribe to change notifications from this dependency if we're in an effect
      // OR evaluating a computed signal that in turn has subscribers.
      if ((evalContext!.flags & TRACKING) != 0) {
        signal.subscribeToNode(node);
      }
      return node;
    } else if (node.version == -1) {
      // `signal` is an existing dependency from a previous evaluation. Reuse it.
      node.version = 0;

      /**
		 * If `node` is not already the current tail of the dependency list (i.e.
		 * there is a next node in the list), then make the `node` the new tail. e.g:
		 *
		 * { A <-> B <-> C <-> D }
		 *         ↑           ↑
		 *        node   ┌─── tail (evalContext._sources)
		 *         └─────│─────┐
		 *               ↓     ↓
		 * { A <-> C <-> D <-> B }
		 *                     ↑
		 *                    tail (evalContext._sources)
		 */
      if (node.nextSource != null) {
        node.nextSource!.prevSource = node.prevSource;

        if (node.prevSource != null) {
          node.prevSource!.nextSource = node.nextSource;
        }

        node.prevSource = evalContext!.sources;
        node.nextSource = null;

        evalContext!.sources!.nextSource = node;
        evalContext!.sources = node;
      }

      // We can assume that the currently evaluated effect / computed signal is already
      // subscribed to change notifications from `signal` if needed.
      return node;
    }
    return null;
  }

  @internal

  /// @nodoc
  void Function() signalSubscribe(
    void Function(T value) fn,
  ) {
    final signal = this;
    return effect(
      () {
        final value = signal.value;
        final prevContext = evalContext;
        evalContext = null;
        try {
          fn(value);
        } finally {
          evalContext = prevContext;
        }
      },
      EffectOptions(name: 'sub'),
    );
  }

  @internal

  /// @nodoc
  void signalUnsubscribe(Node node) {
    final signal = this;
    // Only run the unsubscribe step if the signal has any subscribers to begin with.
    if (signal.targets != null) {
      final prev = node.prevTarget;
      final next = node.nextTarget;
      if (prev != null) {
        prev.nextTarget = next;
        node.prevTarget = null;
      }
      if (next != null) {
        next.prevTarget = prev;
        node.nextTarget = null;
      }
      if (node == signal.targets) {
        signal.targets = next;
        // Last subscriber
        if (next == null) {
          if (unwatched != null) {
            untracked(() {
              unwatched!(signal);
            });
          }
        }
      }
    }
  }
}

/// Create a new plain readonly signal
ReadonlySignal<T> readonly<T>(
  /// The initial value for the signal
  T value,
) {
  return signal<T>(value);
}
