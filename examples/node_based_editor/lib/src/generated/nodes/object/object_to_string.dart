import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'object_to_string.mapper.dart';

@MappableClass(
  discriminatorValue: 'object_to_string',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class ObjectToString extends BaseNode with ObjectToStringMappable {
  ObjectToString({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  ObjectToString.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Object To String'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<Object>('Object()')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<Object>('value')!().toString();
        }),
      };

  static const fromMap = ObjectToStringMapper.fromMap;
  static const fromJson = ObjectToStringMapper.fromJson;

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
      'value': 'String',
    };
  }
}
