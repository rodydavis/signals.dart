import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

import 'dart:math' as math;

part 'math_sin.mapper.dart';

@MappableClass(
  discriminatorValue: 'math_sin',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class MathSin extends BaseNode with MathSinMappable {
  MathSin({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  MathSin.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Math Sin'),
          expanded: signal(true),
          inputs: {
            'radians': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return math.sin(input<num>('radians')!());
        }),
      };

  static const fromMap = MathSinMapper.fromMap;
  static const fromJson = MathSinMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'radians': 'num',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double',
    };
  }
}
