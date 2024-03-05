import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_negative_infinity.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_negative_infinity',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleNegativeInfinity extends BaseNode
    with DoubleNegativeInfinityMappable {
  DoubleNegativeInfinity({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleNegativeInfinity.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Negative Infinity'),
          expanded: signal(true),
          inputs: {},
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return double.negativeInfinity;
        }),
      };

  static const fromMap = DoubleNegativeInfinityMapper.fromMap;
  static const fromJson = DoubleNegativeInfinityMapper.fromJson;

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
