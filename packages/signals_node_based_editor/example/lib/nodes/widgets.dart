import 'package:flutter/material.dart';
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
  })  : child = OptionalWidgetKnob('child', child),
        width = OptionalDoubleKnob('width', width),
        height = OptionalDoubleKnob('height', height);

  @override
  late Computed<Size> previewSize = computed(() {
    return Size(width.value ?? 200, height.value ?? 200);
  });

  @override
  late ReadonlySignal<SizedBox> child$ = computed(() {
    return SizedBox(
      width: width.value,
      height: height.value,
      child: child.value,
    );
  });

  @override
  String get type$ => 'widget_sized_box';

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

class ButtonWidgetNode extends WidgetNode<FilledButton> {
  final OptionalWidgetKnob child;
  final VoidFunctionKnob onPressed;

  ButtonWidgetNode({
    Widget? child,
  })  : child = OptionalWidgetKnob('child', child),
        onPressed = VoidFunctionKnob('onPressed');

  @override
  late ReadonlySignal<FilledButton> child$ = computed(() {
    return FilledButton(
      onPressed: onPressed.call,
      child: child.value,
    );
  });

  @override
  String get type$ => 'button_node';

  @override
  late ReadonlySignal<String> label$ = signal('Button (Widget)');

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(child, 'Widget', false),
      NodeWidgetInput(onPressed, 'void Function()', false),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('onPressed', onPressed.source, 'void Function()', false),
    ];
  });
}

class IncrementNode extends GraphNode {
  final IntKnob amount;
  final IntKnob value;
  final VoidFunctionKnob action;

  IncrementNode({
    int? amount,
    int? value,
  })  : amount = IntKnob('amount', amount ?? 1),
        value = IntKnob('value', value ?? 0),
        action = VoidFunctionKnob('action');

  late final result = computed<int>(() {
    action.value;
    final val = value.source.peek();
    final amount = this.amount.value;
    return untracked(() => value.value = val + amount);
  });

  @override
  String get type$ => 'inc_node';

  @override
  late ReadonlySignal<String> label$ = signal('Increment');

  // @override
  // Computed<Size> previewSize = computed(() => const Size(double.infinity, 100));

  // @override
  // Widget preview(BuildContext context) {
  //   return Center(
  //     child: OutlinedButton(
  //       onPressed: result.recompute,
  //       child: const Text('Increment'),
  //     ),
  //   );
  // }

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(amount, 'int', false),
      NodeWidgetInput(value, 'int', false),
      NodeWidgetInput(action, 'void Function()', false),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('result', result, 'int', false),
      NodeWidgetOutput('action', action.source, 'void Function()', false),
    ];
  });
}
