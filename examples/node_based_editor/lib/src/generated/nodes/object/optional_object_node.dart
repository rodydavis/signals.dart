import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'optional_object_node.mapper.dart';

@MappableClass(
  discriminatorValue: 'optional_object_node',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class OptionalObjectNode extends BaseNode with OptionalObjectNodeMappable {
  OptionalObjectNode({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  OptionalObjectNode.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Optional Object Node'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<Object?>(false)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<Object?>(() {
          return input<Object?>('value')?.call();
        }),
      };

  static const fromMap = OptionalObjectNodeMapper.fromMap;
  static const fromJson = OptionalObjectNodeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'Object?',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'Object?',
    };
  }
}
