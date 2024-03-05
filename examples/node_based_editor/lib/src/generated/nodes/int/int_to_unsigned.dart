import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_to_unsigned.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_to_unsigned',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntToUnsigned extends BaseNode with IntToUnsignedMappable {
  IntToUnsigned({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntToUnsigned.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int To Unsigned'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'width': (link: null, value: signal<int>(2)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('value')!().toUnsigned(input<int>('width')!());
        }),
      };

  static const fromMap = IntToUnsignedMapper.fromMap;
  static const fromJson = IntToUnsignedMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
      'width': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
