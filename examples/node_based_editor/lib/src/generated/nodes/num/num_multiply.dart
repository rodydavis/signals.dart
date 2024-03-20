import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_multiply.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_multiply',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumMultiply extends BaseNode with NumMultiplyMappable {
  NumMultiply({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumMultiply.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num Multiply'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<num>(0.0)),
            'b': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<num>(() {
          return input<num>('a')!() * input<num>('b')!();
        }),
      };

  static const fromMap = NumMultiplyMapper.fromMap;
  static const fromJson = NumMultiplyMapper.fromJson;

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
      'value': 'num',
    };
  }
}
