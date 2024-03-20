import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_bitwise_exclusive_or.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_bitwise_exclusive_or',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntBitwiseExclusiveOr extends BaseNode
    with IntBitwiseExclusiveOrMappable {
  IntBitwiseExclusiveOr({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntBitwiseExclusiveOr.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Bitwise Exclusive Or'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<int>(0)),
            'b': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('a')!() ^ input<int>('b')!();
        }),
      };

  static const fromMap = IntBitwiseExclusiveOrMapper.fromMap;
  static const fromJson = IntBitwiseExclusiveOrMapper.fromJson;

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
