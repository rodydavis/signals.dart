import 'package:signals/signals.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

import 'base.dart';

class AddKnob extends Knob<Object> {
  AddKnob() : super('+', Object());
}

abstract class ListNode<T> extends BaseNode {
  final int? maxLength, minLength;
  final bool canRemove;
  final ListSignal<Knob<T>> items;
  final AddKnob? addKnob;
  final bool optional;
  final String listType;

  late Computed<String> listType$ = computed(() {
    if (items.isNotEmpty) {
      final types = items.map((e) => e.label).toSet();
      if (types.length == 1) return types.first;
    }
    return listType;
  });

  ListNode(
    this.items, {
    this.listType = 'Object',
    this.addKnob,
    this.maxLength,
    this.minLength,
    this.canRemove = true,
    this.optional = false,
  }) : super('List<$listType${optional ? '?' : ''}>');

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      for (var i = 0; i < items.length; i++)
        NodeWidgetInput(items[i], listType$.value, optional),
      if (addKnob != null) NodeWidgetInput(addKnob!, listType$.value, optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('List', items, listType$.value, false),
    ];
  });
}

class StringList extends ListNode<String> {
  StringList({
    List<String> items = const [],
    super.optional,
  }) : super(
          listSignal([
            for (var i = 0; i < items.length; i++) StringKnob('$i', items[i])
          ]),
          listType: 'String',
          addKnob: AddKnob(),
          maxLength: null,
          minLength: null,
          canRemove: true,
        );

  factory StringList.fromJson(Map<String, dynamic> json, bool optional) {
    return StringList(
      items: (json['items'] as List).cast<String>(),
      optional: optional,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'listType': listType,
      'items': items.map((e) => e.value).toList(),
    };
  }
}
