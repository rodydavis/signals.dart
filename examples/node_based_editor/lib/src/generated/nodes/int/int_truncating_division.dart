import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_truncating_division.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_truncating_division',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntTruncatingDivision extends BaseNode
    with IntTruncatingDivisionMappable {
  IntTruncatingDivision({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntTruncatingDivision.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Truncating Division'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<int>(0)),
            'b': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('a')!() ~/ input<int>('b')!();
        }),
      };

  static const fromMap = IntTruncatingDivisionMapper.fromMap;
  static const fromJson = IntTruncatingDivisionMapper.fromJson;

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
