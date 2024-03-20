import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

import 'dart:math' as math;

part 'math_sqrt2.mapper.dart';

@MappableClass(
  discriminatorValue: 'math_sqrt2',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class MathSqrt2 extends BaseNode with MathSqrt2Mappable {
  MathSqrt2({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  MathSqrt2.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Math Sqrt2'),
          expanded: signal(true),
          inputs: {},
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return math.sqrt2;
        }),
      };

  static const fromMap = MathSqrt2Mapper.fromMap;
  static const fromJson = MathSqrt2Mapper.fromJson;

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
