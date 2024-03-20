import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

import 'dart:math' as math;

part 'math_acos.mapper.dart';

@MappableClass(
  discriminatorValue: 'math_acos',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class MathAcos extends BaseNode with MathAcosMappable {
  MathAcos({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  MathAcos.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Math Acos'),
          expanded: signal(true),
          inputs: {
            'x': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return math.acos(input<num>('x')!());
        }),
      };

  static const fromMap = MathAcosMapper.fromMap;
  static const fromJson = MathAcosMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'x': 'num',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double',
    };
  }
}
