import 'package:flutter/widgets.dart';

final class _MemorizedNode<T> {
  _MemorizedNode({
    required this.value,
    this.next,
    this.prev,
    _MemorizedNode? head,
  }) {
    this.head = head ?? this;
  }

  final T value;

  _MemorizedNode? next;
  _MemorizedNode? prev;

  late _MemorizedNode head;

  bool valueTypeof<V>() => value is V;
}

final class _RootMemorized extends _MemorizedNode<Null> {
  _RootMemorized() : super(value: null);

  bool reset = true;

  @override
  _MemorizedNode get head => this;
}

final _bindings = Expando<_MemorizedNode>('signals_compose:context bindings');

T withMemorized<T>(BuildContext? context, T Function() factory) {
  if (context == null) factory();
  final prev = _bindings[context!] ??= _RootMemorized(),
      root = prev.head as _RootMemorized,
      current = prev.next;
  if (root.reset) {
    root.reset = false;
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      _bindings[context] = root;
      root.reset = true;
    });
  }

  if (current != null && current.valueTypeof<T>()) {
    _bindings[context] = current;
    return current.value;
  }

  final value = factory(),
      node = _MemorizedNode(value: value, prev: prev, head: root);
  prev.next = node;
  _bindings[context] = node;

  return value;
}

/// Resets the memoized value for the given context.
///
/// This will cause the next call to [useMemoized] to recompute the value.
void resetMemoizedFor(BuildContext context) {
  final node = _bindings[context], root = node?.head as _RootMemorized?;
  root?.reset = true;
  _bindings[context] = root;
}
