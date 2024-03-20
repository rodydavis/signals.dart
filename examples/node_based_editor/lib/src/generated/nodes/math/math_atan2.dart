import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

import 'dart:math' as math;

part 'math_atan2.mapper.dart';

@MappableClass(
  discriminatorValue: 'math_atan2',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class MathAtan2 extends BaseNode with MathAtan2Mappable {
  MathAtan2({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  MathAtan2.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Math Atan2'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<num>(0.0)),
            'b': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return math.atan2(input<num>('a')!(), input<num>('b')!());
        }),
      };

  static const fromMap = MathAtan2Mapper.fromMap;
  static const fromJson = MathAtan2Mapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'a': 'num',
      'b': 'num',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double',
    };
  }
}
