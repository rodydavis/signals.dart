import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'optional_double_node.mapper.dart';

@MappableClass(
  discriminatorValue: 'optional_double_node',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class OptionalDoubleNode extends BaseNode with OptionalDoubleNodeMappable {
  OptionalDoubleNode({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  OptionalDoubleNode.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Optional Double Node'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double?>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double?>(() {
          return input<double?>('value')?.call();
        }),
      };

  static const fromMap = OptionalDoubleNodeMapper.fromMap;
  static const fromJson = OptionalDoubleNodeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'double?',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double?',
    };
  }
}
