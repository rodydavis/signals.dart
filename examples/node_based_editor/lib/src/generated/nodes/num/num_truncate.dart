import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_truncate.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_truncate',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumTruncate extends BaseNode with NumTruncateMappable {
  NumTruncate({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumTruncate.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num Truncate'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<num>('value')!().truncate();
        }),
      };

  static const fromMap = NumTruncateMapper.fromMap;
  static const fromJson = NumTruncateMapper.fromJson;

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
      'value': 'int',
    };
  }
}
