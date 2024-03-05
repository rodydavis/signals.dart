import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_code_units.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_code_units',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringCodeUnits extends BaseNode with StringCodeUnitsMappable {
  StringCodeUnits({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringCodeUnits.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Code Units'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<List<int>>(() {
          return input<String>('value')!().codeUnits;
        }),
      };

  static const fromMap = StringCodeUnitsMapper.fromMap;
  static const fromJson = StringCodeUnitsMapper.fromJson;

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
      'value': 'List<int>',
    };
  }
}
