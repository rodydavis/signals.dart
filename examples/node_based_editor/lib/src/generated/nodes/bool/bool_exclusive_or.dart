import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'bool_exclusive_or.mapper.dart';

@MappableClass(
  discriminatorValue: 'bool_exclusive_or',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class BoolExclusiveOr extends BaseNode with BoolExclusiveOrMappable {
  BoolExclusiveOr({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  BoolExclusiveOr.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Bool Exclusive Or'),
          expanded: signal(true),
          inputs: {
            'a': (link: null, value: signal<bool>(false)),
            'b': (link: null, value: signal<bool>(false)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<bool>('a')!() ^ input<bool>('b')!();
        }),
      };

  static const fromMap = BoolExclusiveOrMapper.fromMap;
  static const fromJson = BoolExclusiveOrMapper.fromJson;

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
