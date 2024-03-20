import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

import 'dart:math' as math;

part 'math_sqrt1_2.mapper.dart';

@MappableClass(
  discriminatorValue: 'math_sqrt1_2',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class MathSqrt12 extends BaseNode with MathSqrt12Mappable {
  MathSqrt12({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  MathSqrt12.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Math Sqrt1 2'),
          expanded: signal(true),
          inputs: {},
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return math.sqrt1_2;
        }),
      };

  static const fromMap = MathSqrt12Mapper.fromMap;
  static const fromJson = MathSqrt12Mapper.fromJson;

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
