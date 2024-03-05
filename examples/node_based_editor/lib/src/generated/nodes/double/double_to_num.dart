import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_to_num.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_to_num',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleToNum extends BaseNode with DoubleToNumMappable {
  DoubleToNum({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleToNum.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double To Num'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<num>(() {
          return input<double>('value')!();
        }),
      };

  static const fromMap = DoubleToNumMapper.fromMap;
  static const fromJson = DoubleToNumMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'double',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'num',
    };
  }
}
