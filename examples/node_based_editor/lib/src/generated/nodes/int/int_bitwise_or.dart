import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_bitwise_or.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_bitwise_or',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntBitwiseOr extends BaseNode with IntBitwiseOrMappable {
  IntBitwiseOr({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntBitwiseOr.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Bitwise Or'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<int>(0)),
            'b': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('a')!() | input<int>('b')!();
        }),
      };

  static const fromMap = IntBitwiseOrMapper.fromMap;
  static const fromJson = IntBitwiseOrMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'a': 'int',
      'b': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
