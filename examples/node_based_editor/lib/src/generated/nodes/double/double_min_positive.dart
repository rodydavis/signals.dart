import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_min_positive.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_min_positive',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleMinPositive extends BaseNode with DoubleMinPositiveMappable {
  DoubleMinPositive({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleMinPositive.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Min Positive'),
          expanded: signal(true),
          inputs: {},
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return double.minPositive;
        }),
      };

  static const fromMap = DoubleMinPositiveMapper.fromMap;
  static const fromJson = DoubleMinPositiveMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {};
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double',
    };
  }
}
