import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'optional_int_node.mapper.dart';

@MappableClass(
  discriminatorValue: 'optional_int_node',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class OptionalIntNode extends BaseNode with OptionalIntNodeMappable {
  OptionalIntNode({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  OptionalIntNode.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Optional Int Node'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int?>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int?>(() {
          return input<int?>('value')?.call();
        }),
      };

  static const fromMap = OptionalIntNodeMapper.fromMap;
  static const fromJson = OptionalIntNodeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int?',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int?',
    };
  }
}
