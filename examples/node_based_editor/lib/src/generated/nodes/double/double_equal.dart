import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_equal.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_equal',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleEqual extends BaseNode with DoubleEqualMappable {
  DoubleEqual({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleEqual.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Equal'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<double>(0.0)),
            'b': (link: null, value: signal<double>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<double>('a')!() == input<double>('b')!();
        }),
      };

  static const fromMap = DoubleEqualMapper.fromMap;
  static const fromJson = DoubleEqualMapper.fromJson;

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
