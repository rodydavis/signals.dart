import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_to_double.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_to_double',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntToDouble extends BaseNode with IntToDoubleMappable {
  IntToDouble({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntToDouble.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int To Double'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return input<int>('value')!().toDouble();
        }),
      };

  static const fromMap = IntToDoubleMapper.fromMap;
  static const fromJson = IntToDoubleMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double',
    };
  }
}
