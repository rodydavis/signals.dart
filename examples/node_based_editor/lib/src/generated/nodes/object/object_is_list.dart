import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'object_is_list.mapper.dart';

@MappableClass(
  discriminatorValue: 'object_is_list',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class ObjectIsList extends BaseNode with ObjectIsListMappable {
  ObjectIsList({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  ObjectIsList.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Object Is List'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<Object?>('Object()')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<Object?>('value')!() is List;
        }),
      };

  static const fromMap = ObjectIsListMapper.fromMap;
  static const fromJson = ObjectIsListMapper.fromJson;

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
