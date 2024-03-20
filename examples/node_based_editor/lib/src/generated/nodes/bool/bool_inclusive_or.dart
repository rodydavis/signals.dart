import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'bool_inclusive_or.mapper.dart';

@MappableClass(
  discriminatorValue: 'bool_inclusive_or',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class BoolInclusiveOr extends BaseNode with BoolInclusiveOrMappable {
  BoolInclusiveOr({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  BoolInclusiveOr.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Bool Inclusive Or'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<bool>(false)),
            'b': (link: null, value: signal<bool>(false)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<bool>('a')!() | input<bool>('b')!();
        }),
      };

  static const fromMap = BoolInclusiveOrMapper.fromMap;
  static const fromJson = BoolInclusiveOrMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'a': 'bool',
      'b': 'bool',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'bool',
    };
  }
}
