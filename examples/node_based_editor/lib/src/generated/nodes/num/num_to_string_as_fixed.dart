import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_to_string_as_fixed.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_to_string_as_fixed',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumToStringAsFixed extends BaseNode with NumToStringAsFixedMappable {
  NumToStringAsFixed({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumToStringAsFixed.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num To String As Fixed'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<num>(0.0)),
            'fraction_digits': (link: null, value: signal<int>(2)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<num>('value')!()
              .toStringAsFixed(input<int>('fraction_digits')!());
        }),
      };

  static const fromMap = NumToStringAsFixedMapper.fromMap;
  static const fromJson = NumToStringAsFixedMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'num',
      'fraction_digits': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
