import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

import 'dart:math' as math;

part 'math_pow.mapper.dart';

@MappableClass(
  discriminatorValue: 'math_pow',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class MathPow extends BaseNode with MathPowMappable {
  MathPow({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  MathPow.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Math Pow'),
          expanded: signal(true),
          inputs: {
            'x': (link: null, value: signal<num>(0.0)),
            'exponent': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<num>(() {
          return math.pow(input<num>('x')!(), input<num>('exponent')!());
        }),
      };

  static const fromMap = MathPowMapper.fromMap;
  static const fromJson = MathPowMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'x': 'num',
      'exponent': 'num',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'num',
    };
  }
}
