import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'optional_bool_node.mapper.dart';

@MappableClass(
  discriminatorValue: 'optional_bool_node',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class OptionalBoolNode extends BaseNode with OptionalBoolNodeMappable {
  OptionalBoolNode({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  OptionalBoolNode.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Optional Bool Node'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<bool?>(false)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool?>(() {
          return input<bool?>('value')?.call();
        }),
      };

  static const fromMap = OptionalBoolNodeMapper.fromMap;
  static const fromJson = OptionalBoolNodeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'bool?',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'bool?',
    };
  }
}
