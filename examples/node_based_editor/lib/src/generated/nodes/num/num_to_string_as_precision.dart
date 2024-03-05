import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_to_string_as_precision.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_to_string_as_precision',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumToStringAsPrecision extends BaseNode
    with NumToStringAsPrecisionMappable {
  NumToStringAsPrecision({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumToStringAsPrecision.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num To String As Precision'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<num>(0.0)),
            'precision': (link: null, value: signal<int>(2)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<num>('value')!()
              .toStringAsPrecision(input<int>('precision')!());
        }),
      };

  static const fromMap = NumToStringAsPrecisionMapper.fromMap;
  static const fromJson = NumToStringAsPrecisionMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'num',
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
