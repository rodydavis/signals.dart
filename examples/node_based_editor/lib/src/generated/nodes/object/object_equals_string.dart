import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'object_equals_string.mapper.dart';

@MappableClass(
  discriminatorValue: 'object_equals_string',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class ObjectEqualsString extends BaseNode with ObjectEqualsStringMappable {
  ObjectEqualsString({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  ObjectEqualsString.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Object Equals String'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<Object>('Object()')),
            'b': (link: null, value: signal<Object>('Object()')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<Object>('a')!() == input<Object>('b')!();
        }),
      };

  static const fromMap = ObjectEqualsStringMapper.fromMap;
  static const fromJson = ObjectEqualsStringMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'a': 'Object',
      'b': 'Object',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'bool',
    };
  }
}
