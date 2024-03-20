import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_to_string_as_precision.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_to_string_as_precision',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleToStringAsPrecision extends BaseNode
    with DoubleToStringAsPrecisionMappable {
  DoubleToStringAsPrecision({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleToStringAsPrecision.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double To String As Precision'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double>(0.0)),
            'precision': (link: null, value: signal<int>(2)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<double>('value')!()
              .toStringAsPrecision(input<int>('precision')!());
        }),
      };

  static const fromMap = DoubleToStringAsPrecisionMapper.fromMap;
  static const fromJson = DoubleToStringAsPrecisionMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'double',
      'precision': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
