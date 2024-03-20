import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_is_infinite.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_is_infinite',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleIsInfinite extends BaseNode with DoubleIsInfiniteMappable {
  DoubleIsInfinite({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleIsInfinite.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Is Infinite'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<double>('value')!().isInfinite;
        }),
      };

  static const fromMap = DoubleIsInfiniteMapper.fromMap;
  static const fromJson = DoubleIsInfiniteMapper.fromJson;

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
      'value': 'bool',
    };
  }
}
