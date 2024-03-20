import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_is_finite.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_is_finite',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntIsFinite extends BaseNode with IntIsFiniteMappable {
  IntIsFinite({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntIsFinite.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Is Finite'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<int>('value')!().isFinite;
        }),
      };

  static const fromMap = IntIsFiniteMapper.fromMap;
  static const fromJson = IntIsFiniteMapper.fromJson;

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
      'value': 'bool',
    };
  }
}
