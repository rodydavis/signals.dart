import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_to_lower_case.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_to_lower_case',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringToLowerCase extends BaseNode with StringToLowerCaseMappable {
  StringToLowerCase({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringToLowerCase.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String To Lower Case'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<String>('value')!().toLowerCase();
        }),
      };

  static const fromMap = StringToLowerCaseMapper.fromMap;
  static const fromJson = StringToLowerCaseMapper.fromJson;

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
