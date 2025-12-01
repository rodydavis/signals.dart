import 'computed.dart';
import 'equality.dart';
import 'globals.dart';
import 'listenable.dart';
import 'node.dart';
import 'options.dart';
import 'readonly.dart';
import 'signal.dart';

/// Configuration options for creating a Linked Signal.
class LinkedSignalOptions<S, T> extends SignalOptions<T> {
  /// Initial value for the signal
  final T? initialValue;

  /// Create a LinkedSignalOptions.
  const LinkedSignalOptions({
    this.initialValue,
    super.name,
    super.equalityCheck,
    super.watched,
    super.unwatched,
  });
}

/// A LinkedSignal is a Signal that also reacts to an upstream source.
class LinkedSignal<S, T> implements Signal<T> {
  late final ReadonlySignal<S> _sourceNode;
  late final Signal<T?> _backingStore;
  late final Computed<T> _outputNode;

  bool _isInitialized = false;
  late S _lastSeenSourceValue;

  /// The source signal(s) that trigger the reset.
  /// Can be a direct signal or a function returning a value (which will be wrapped in a computed).
  final S Function() source;

  /// The computation function that derives the reset value.
  /// Receives the new source value and the previous value of the linked signal.
  final T Function(S source, T? previous) computation;

  /// Create a LinkedSignal.
  LinkedSignal({
    required this.source,
    required this.computation,
    LinkedSignalOptions<S, T>? options,
  }) {
    // 1. Normalize the source into a trackable Computed.
    _sourceNode = computed<S>(source);

    // 2. Internal State Container.
    _backingStore = signal<T?>(
      options?.initialValue,
      SignalOptions<T?>(
        name: options?.name != null ? '${options!.name} (backing)' : null,
      ),
    );

    // 3. The "Brain" of the operation: A Computed that manages the Reset Logic.
    _outputNode = computed<T>(
      () {
        // A. READ Phase: Check the Source.
        final currentSourceValue = _sourceNode.value;

        // B. EVALUATION Phase: Detect Change.
        if (!_isInitialized || currentSourceValue != _lastSeenSourceValue) {
          // C. COMPUTATION Phase: Execute the user's logic.
          final previousValue = _backingStore.peek();
          final newValue = computation(currentSourceValue, previousValue);

          // D. SYNCHRONIZATION Phase: Update the backing store.
          _lastSeenSourceValue = currentSourceValue;
          _isInitialized = true;

          if (_backingStore.peek() != newValue) {
            _backingStore.value = newValue;
          }

          // Ensure we are subscribed to backing store for manual overrides
          final _ = _backingStore.value;

          return newValue;
        }

        // E. STABLE Phase: Source hasn't changed.
        return _backingStore.value as T;
      },
      options,
    );
  }

  @override
  T get value => _outputNode.value;

  @override
  set value(T v) {
    _backingStore.value = v;
    _lastSeenSourceValue = _sourceNode.peek();
    _isInitialized = true;
  }

  @override
  T peek() => _outputNode.peek();

  @override
  bool set(T val, {bool force = false}) {
    final updated = _backingStore.set(val, force: force);
    if (updated) {
      _lastSeenSourceValue = _sourceNode.peek();
      _isInitialized = true;
    }
    return updated;
  }

  @override
  void Function() subscribe(void Function(T value) fn) {
    return _outputNode.subscribe(fn);
  }

  @override
  int get globalId => _outputNode.globalId;

  @override
  int get version => _outputNode.version;

  @override
  set version(int v) {
    _outputNode.version = v;
  }

  @override
  bool internalRefresh() => _outputNode.internalRefresh();

  @override
  void subscribeToNode(Node node) => _outputNode.subscribeToNode(node);

  @override
  void unsubscribeFromNode(Node node) => _outputNode.unsubscribeFromNode(node);

  @override
  Node? get targets => _outputNode.targets;

  @override
  set targets(Node? v) => _outputNode.targets = v;

  @override
  T get internalValue => _outputNode.internalValue;

  @override
  set internalValue(T v) => _outputNode.internalValue = v;

  @override
  SignalEquality<T> get equalityCheck => _outputNode.equalityCheck;

  @override
  set equalityCheck(SignalEquality<T> v) => _outputNode.equalityCheck = v;

  @override
  String? get name => _outputNode.name;

  @override
  set name(String? v) => _outputNode.name = v;

  @override
  SignalCallback<T>? get watched => _outputNode.watched;

  @override
  set watched(SignalCallback<T>? v) => _outputNode.watched = v;

  @override
  SignalCallback<T>? get unwatched => _outputNode.unwatched;

  @override
  set unwatched(SignalCallback<T>? v) => _outputNode.unwatched = v;

  @override

  /// @nodoc
  void notify() => _outputNode.notify();

  @override
  Node? addDependency() => _outputNode.addDependency();

  @override
  Symbol get brand => BRAND_SYMBOL;

  @override
  T call() => value;

  @override
  T get() => value;

  @override
  void internalSetValue(T val) {
    // This is called by Signal.set, but we override set.
    // However, we must implement it.
    // We can delegate to backing store if types match, but backing store is T?
    // Since we override set, this might not be called.
    // But if it is, we should probably update backing store.
    _backingStore.internalSetValue(val);
  }

  @override
  void internalSubscribe(Node node) => _outputNode.internalSubscribe(node);

  @override
  bool get isInitialized => _outputNode.isInitialized;

  @override
  set isInitialized(bool val) {
    // Computed doesn't have a setter for isInitialized in public API?
    // Computed has `bool _isInitialized` and getter.
    // Signal has setter.
    // We can ignore setter or try to set it on backing store?
    // Setting isInitialized on LinkedSignal seems weird.
    // But we must implement it.
    _backingStore.isInitialized = val;
  }

  @override
  Node? get node => _outputNode.node;

  @override
  set node(Node? v) => _outputNode.node = v;

  @override
  Iterable<Listenable> readonlySignalTargets() =>
      _outputNode.readonlySignalTargets();

  @override
  void Function() signalSubscribe(void Function(T value) fn) =>
      _outputNode.signalSubscribe(fn);

  @override
  void signalUnsubscribe(Node node) => _outputNode.signalUnsubscribe(node);

  @override
  dynamic toJson() => value;
}

/// Create a LinkedSignal.
LinkedSignal<S, T> linkedSignal<S, T>(
  S Function() source,
  T Function(S source, T? previous) computation, {
  LinkedSignalOptions<S, T>? options,
}) {
  return LinkedSignal<S, T>(
    source: source,
    computation: computation,
    options: options,
  );
}
