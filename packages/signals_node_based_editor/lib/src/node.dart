import 'package:flutter/material.dart';

import 'package:signals/signals_flutter.dart';

import 'knobs.dart';

typedef NodePort<T> = ({
  String label,
  String key,
  ReadonlySignal<dynamic> source,
});

// TODO: Json Schema
abstract class GraphNode {
  final offset$ = signal<Offset>(Offset.zero);

  late final String id$ = 'graph_node_${label$.globalId}';

  late final rect$ = computed(() {
    return offset$.value & preferredSize$.value;
  });

  static const portSize = Size(200, 40);

  static const previewPadding = EdgeInsets.all(8);

  late final nodeSize$ = computed(() => previewSize$);

  @override
  bool operator ==(Object other) => other is GraphNode && other.id$ == id$;

  @override
  int get hashCode => id$.hashCode;

  @override
  String toString() => label$();

  String get type$;

  final Signal<bool> collapsed$ = signal(false);
  late final ReadonlySignal<String> label$ = signal(type$);

  List<Widget> actions$(BuildContext context) {
    return [];
  }

  Widget preview(BuildContext context) {
    return const SizedBox.shrink();
  }

  static var headerHeight = 30.0;
  static var portHeight = 40.0;
  static var portWidth = 8.0;
  static var nodeWidth = 250.0;
  static var portPadding = 4.0;
  static var previewSizeFallback = Size(nodeWidth, 100);
  static var borderRadius = 12.0;

  final Computed<List<NodeWidgetInput>> inputs = computed(() => []);

  final Computed<List<NodeWidgetOutput>> outputs = computed(() => []);

  late Computed<Size> previewSize$ = computed(() {
    return Size(nodeWidth, 0);
  });

  late Computed<Size> preferredSize$ = computed(() {
    var size = Size(nodeWidth, headerHeight);
    if (collapsed$.value) return size;
    if (hasPreview) {
      size = Size(
        size.width,
        size.height + previewSize$.value.height,
      );
    }
    final count = inputs.value.length + outputs.value.length;
    size = Size(
      size.width,
      size.height + (count * portHeight),
    );
    size = Size(size.width, size.height + (portPadding * 2));
    return size;
  });

  bool get hasPreview => previewSize$.value.height > 0;

  late Computed<List<PortMetadata<NodeWidgetOutput>>> outputsMetadata =
      computed(() {
    final results = <PortMetadata<NodeWidgetOutput>>[];
    var top = headerHeight + previewSize$.value.height + portPadding;
    for (var i = 0; i < outputs.value.length; i++) {
      final connector = Offset(
            collapsed$.value ? nodeWidth + -portWidth : nodeWidth,
            collapsed$.value ? 0 : top + i * portHeight,
          ) &
          Size(portWidth, portHeight);
      final control = Offset(
            0,
            collapsed$.value ? 0 : top + i * portHeight,
          ) &
          Size(nodeWidth, portHeight);
      results.add((
        connector: connector,
        control: control,
        port: outputs.value.elementAt(i),
      ));
    }
    return results;
  });

  late Computed<List<PortMetadata<NodeWidgetInput>>> inputsMetadata =
      computed(() {
    final results = <PortMetadata<NodeWidgetInput>>[];
    final top = headerHeight +
        previewSize$.value.height +
        portPadding +
        (outputs.value.length * portHeight);
    for (var i = 0; i < inputs.value.length; i++) {
      final connector = Offset(
            collapsed$.value ? 0 : -portWidth,
            collapsed$.value ? 0 : top + i * portHeight,
          ) &
          Size(portWidth, portHeight);
      final control = Offset(
            0,
            collapsed$.value ? 0 : top + i * portHeight,
          ) &
          Size(nodeWidth, portHeight);
      results.add((
        connector: connector,
        control: control,
        port: inputs.value.elementAt(i),
      ));
    }
    return results;
  });

  Rect get headerRect => Offset.zero & Size(nodeWidth, headerHeight);

  late Computed<Rect> previewRect = computed(() {
    return Offset(0, headerHeight) &
        Size(
          nodeWidth,
          previewSize$.value.height,
        );
  });
}

class FallbackNode extends GraphNode {
  @override
  Computed<Rect> rect$ = computed(() => Rect.zero);

  @override
  String get type$ => 'fallback_node';

  @override
  ReadonlySignal<String> get label$ => signal('Fallback');
}

typedef PortMetadata<T extends NodeWidgetPort> = ({
  Rect connector,
  Rect control,
  T port,
});

sealed class NodeWidgetPort {
  final String label;
  final String type;
  final bool optional;
  NodeWidgetPort(this.label, this.type, this.optional);
}

class NodeWidgetInput<T> extends NodeWidgetPort {
  final Knob<T> knob;
  NodeWidgetInput(this.knob, String type, bool optional)
      : super(knob.label, type, optional);
}

class NodeWidgetOutput<T> extends NodeWidgetPort {
  final ReadonlySignal<T> source;
  NodeWidgetOutput(super.label, this.source, super.type, super.optional);
}
