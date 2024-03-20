import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'object_node.mapper.dart';

@MappableClass(
  discriminatorValue: 'object_node',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class ObjectNode extends BaseNode with ObjectNodeMappable {
  ObjectNode({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  ObjectNode.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Object Node'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<Object>('Object()')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<Object>(() {
          return input<Object>('value')!();
        }),
      };

  static const fromMap = ObjectNodeMapper.fromMap;
  static const fromJson = ObjectNodeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'Object',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'Object',
    };
  }
}
