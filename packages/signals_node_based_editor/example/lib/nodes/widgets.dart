import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';
import 'package:signals/signals_flutter.dart';

abstract class WidgetNode<T extends Widget> extends GraphNode {
  ReadonlySignal<T> get child$;

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('widget', child$, 'Widget', false),
    ];
  });

  @override
  late Computed<Size> previewSize = computed(() {
    return const Size(200, 200);
  });

  @override
  Widget preview(BuildContext context) {
    return Watch(
      (context) {
        final colors = Theme.of(context).colorScheme;
        return Container(
          foregroundDecoration: BoxDecoration(
            border: Border.all(
              color: colors.outlineVariant,
            ),
          ),
          child: Center(
            child: child$.value,
          ),
        );
      },
    );
  }
}

class WidgetKnob<T extends Widget> extends ObjectKnob<T> {
  WidgetKnob(super.label, super.source);
}

class OptionalWidgetKnob<T extends Widget> extends OptionalObjectKnob<T> {
  OptionalWidgetKnob(super.label, super.source);
}

class TextWidgetNode extends WidgetNode<Text> {
  final StringKnob data;
  final OptionalBoolKnob softWrap;
  final OptionalIntKnob maxLines;

  TextWidgetNode({
    String? data,
    bool? softWrap,
    int? maxLines,
  })  : data = StringKnob('data', data ?? ''),
        softWrap = OptionalBoolKnob('softWrap', softWrap),
        maxLines = OptionalIntKnob('maxLines', maxLines);

  @override
  String get type$ => 'widget_text';

  @override
  late ReadonlySignal<Text> child$ = computed(() {
    return Text(
      data.value,
      maxLines: maxLines.value,
      softWrap: softWrap.value,
    );
  });

  @override
  late ReadonlySignal<String> label$ = signal('Text (Widget)');

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(data, 'String', false),
      NodeWidgetInput(softWrap, 'bool', true),
      NodeWidgetInput(maxLines, 'int', true),
    ];
  });
}

class SizedBoxNode extends WidgetNode<SizedBox> {
  final OptionalWidgetKnob child;
  final OptionalDoubleKnob width;
  final OptionalDoubleKnob height;

  SizedBoxNode({
    Widget? child,
    double? width,
    double? height,
  })  : child = OptionalWidgetKnob('child', null),
        width = OptionalDoubleKnob('width', width),
        height = OptionalDoubleKnob('height', height);

  @override
  late Computed<Size> previewSize = computed(() {
    return Size(width.value ?? 200, height.value ?? 200);
  });

  @override
  String get type$ => 'widget_sized_box';

  @override
  late ReadonlySignal<SizedBox> child$ = computed(() {
    return SizedBox(
      width: width.value,
      height: height.value,
      child: child.value,
    );
  });

  @override
  late ReadonlySignal<String> label$ = signal('SizedBox (Widget)');

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(child, 'Widget', true),
      NodeWidgetInput(width, 'double', true),
      NodeWidgetInput(height, 'double', true),
    ];
  });
}
