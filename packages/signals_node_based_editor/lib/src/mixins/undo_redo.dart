import 'dart:async';

import 'package:signals/signals.dart';

import '../graph.dart';
import '../node.dart';

mixin UndoRedoMixin<Node extends GraphNode, State> on BaseGraph<Node> {
  Timer? _timer;

  Duration get saveDuration => const Duration(milliseconds: 150);

  @override
  void init() {
    super.init();
    _timer = Timer.periodic(saveDuration, (_) {
      save();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void save() {
    if (locked()) return;
    if (!keyboardFocusNode.hasFocus) return;
    final state = saveSnapshot();
    if (state == changes.value) {
      return;
    }
    changes.value = state;
  }

  State saveSnapshot();

  void loadSnapshot(State state);

  late final changes = changeStack<State>(saveSnapshot());

  late Computed<bool> canUndo = computed(() {
    changes.value;
    return changes.canUndo && changes.history.length > 1;
  });

  void undo() {
    if (!canUndo()) return;
    changes.undo();
    loadSnapshot(changes.value);
  }

  late Computed<bool> canRedo = computed(() {
    changes.value;
    return changes.canRedo;
  });

  void redo() {
    if (!canRedo()) return;
    changes.redo();
    loadSnapshot(changes.value);
  }
}
