import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'object_not_null.mapper.dart';

@MappableClass(
  discriminatorValue: 'object_not_null',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class ObjectNotNull extends BaseNode with ObjectNotNullMappable {
  ObjectNotNull({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  ObjectNotNull.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Object Not Null'),
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

  static const fromMap = ObjectNotNullMapper.fromMap;
  static const fromJson = ObjectNotNullMapper.fromJson;

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
