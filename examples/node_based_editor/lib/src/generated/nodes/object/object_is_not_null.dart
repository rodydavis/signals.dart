import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'object_is_not_null.mapper.dart';

@MappableClass(
  discriminatorValue: 'object_is_not_null',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class ObjectIsNotNull extends BaseNode with ObjectIsNotNullMappable {
  ObjectIsNotNull({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  ObjectIsNotNull.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Object Is Not Null'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<Object?>('Object()')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<Object?>('value')!() != null;
        }),
      };

  static const fromMap = ObjectIsNotNullMapper.fromMap;
  static const fromJson = ObjectIsNotNullMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'Object?',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'bool',
    };
  }
}
