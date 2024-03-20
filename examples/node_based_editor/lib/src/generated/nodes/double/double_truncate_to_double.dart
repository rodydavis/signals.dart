import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_truncate_to_double.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_truncate_to_double',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleTruncateToDouble extends BaseNode
    with DoubleTruncateToDoubleMappable {
  DoubleTruncateToDouble({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleTruncateToDouble.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Truncate To Double'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return input<double>('value')!().truncateToDouble();
        }),
      };

  static const fromMap = DoubleTruncateToDoubleMapper.fromMap;
  static const fromJson = DoubleTruncateToDoubleMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'double',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double',
    };
  }
}
