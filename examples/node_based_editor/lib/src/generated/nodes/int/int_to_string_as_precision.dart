import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_to_string_as_precision.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_to_string_as_precision',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntToStringAsPrecision extends BaseNode
    with IntToStringAsPrecisionMappable {
  IntToStringAsPrecision({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntToStringAsPrecision.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int To String As Precision'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'precision': (link: null, value: signal<int>(2)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<int>('value')!()
              .toStringAsPrecision(input<int>('precision')!());
        }),
      };

  static const fromMap = IntToStringAsPrecisionMapper.fromMap;
  static const fromJson = IntToStringAsPrecisionMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
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
