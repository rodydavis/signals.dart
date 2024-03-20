import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_equal.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_equal',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumEqual extends BaseNode with NumEqualMappable {
  NumEqual({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumEqual.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num Equal'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<num>(0.0)),
            'b': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<num>('a')!() == input<num>('b')!();
        }),
      };

  static const fromMap = NumEqualMapper.fromMap;
  static const fromJson = NumEqualMapper.fromJson;

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
      'value': 'bool',
    };
  }
}
