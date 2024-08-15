import 'package:flutter/material.dart';

import 'package:signals/signals_flutter.dart';

import '../widgets/node_widget_render.dart';

typedef NodePort<T> = ({
  String label,
  String key,
  ReadonlySignal<dynamic> source,
});

abstract class GraphNode extends NodeWidgetRender {
  final offset$ = signal<Offset>(Offset.zero);

  late final String id = 'graph_node_${label$.globalId}';

  // ReadonlySignal<Size> get size$;

  late final rect$ = computed(() {
    return offset$.value & preferredSize.value;
  });

  static const portSize = Size(200, 40);

  static const previewPadding = EdgeInsets.all(8);

  late final nodeSize$ = computed(() => previewSize);

  // Could have been a signal
  Map<String, Object?> toJson() {
    return {
      '@id': id,
      '@type': type$,
      '@label': label$.value,
      '@collapsed': collapsed$.value,
      '@offset': {
        'x': offset$.value.dx,
        'y': offset$.value.dy,
      },
    };
  }

  void linkNodes(Map<String, Object?> data, List<GraphNode> nodes);

  String get type$;
}

class FallbackNode extends GraphNode {
  @override
  void linkNodes(Map<String, Object?> data, List<GraphNode> nodes) {}

  @override
  Computed<Rect> rect$ = computed(() => Rect.zero);

  @override
  String get type$ => 'fallback_node';

  @override
  ReadonlySignal<String> get label$ => signal('Fallback');
}
