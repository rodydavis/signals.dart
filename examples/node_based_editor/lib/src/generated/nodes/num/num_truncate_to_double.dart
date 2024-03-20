import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_truncate_to_double.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_truncate_to_double',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumTruncateToDouble extends BaseNode with NumTruncateToDoubleMappable {
  NumTruncateToDouble({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumTruncateToDouble.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num Truncate To Double'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return input<num>('value')!().truncateToDouble();
        }),
      };

  static const fromMap = NumTruncateToDoubleMapper.fromMap;
  static const fromJson = NumTruncateToDoubleMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'num',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double',
    };
  }
}
