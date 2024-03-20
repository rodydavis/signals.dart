import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_greater_than_equal.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_greater_than_equal',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleGreaterThanEqual extends BaseNode
    with DoubleGreaterThanEqualMappable {
  DoubleGreaterThanEqual({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleGreaterThanEqual.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Greater Than Equal'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<double>(0.0)),
            'b': (link: null, value: signal<double>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<double>('a')!() >= input<double>('b')!();
        }),
      };

  static const fromMap = DoubleGreaterThanEqualMapper.fromMap;
  static const fromJson = DoubleGreaterThanEqualMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'a': 'double',
      'b': 'double',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'bool',
    };
  }
}
