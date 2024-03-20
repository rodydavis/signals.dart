import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_to_radix_string.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_to_radix_string',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntToRadixString extends BaseNode with IntToRadixStringMappable {
  IntToRadixString({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntToRadixString.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int To Radix String'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'radix': (link: null, value: signal<int>(2)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<int>('value')!().toRadixString(input<int>('radix')!());
        }),
      };

  static const fromMap = IntToRadixStringMapper.fromMap;
  static const fromJson = IntToRadixStringMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
      'radix': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
