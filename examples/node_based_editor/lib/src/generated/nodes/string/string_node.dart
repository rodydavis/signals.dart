import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_node.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_node',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringNode extends BaseNode with StringNodeMappable {
  StringNode({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringNode.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Node'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<String>('value')!();
        }),
      };

  static const fromMap = StringNodeMapper.fromMap;
  static const fromJson = StringNodeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
