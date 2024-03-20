import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

import 'dart:math' as math;

part 'math_tan.mapper.dart';

@MappableClass(
  discriminatorValue: 'math_tan',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class MathTan extends BaseNode with MathTanMappable {
  MathTan({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  MathTan.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Math Tan'),
          expanded: signal(true),
          inputs: {
            'radians': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return math.tan(input<num>('radians')!());
        }),
      };

  static const fromMap = MathTanMapper.fromMap;
  static const fromJson = MathTanMapper.fromJson;

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
