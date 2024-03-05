import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_to_string_as_fixed.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_to_string_as_fixed',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleToStringAsFixed extends BaseNode
    with DoubleToStringAsFixedMappable {
  DoubleToStringAsFixed({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleToStringAsFixed.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double To String As Fixed'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double>(0.0)),
            'fraction_digits': (link: null, value: signal<int>(2)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<double>('value')!()
              .toStringAsFixed(input<int>('fraction_digits')!());
        }),
      };

  static const fromMap = DoubleToStringAsFixedMapper.fromMap;
  static const fromJson = DoubleToStringAsFixedMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'double',
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
