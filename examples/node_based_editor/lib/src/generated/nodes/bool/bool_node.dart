import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'bool_node.mapper.dart';

@MappableClass(
  discriminatorValue: 'bool_node',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class BoolNode extends BaseNode with BoolNodeMappable {
  BoolNode({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  BoolNode.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Bool Node'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<bool>(false)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<bool>('value')!();
        }),
      };

  static const fromMap = BoolNodeMapper.fromMap;
  static const fromJson = BoolNodeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'bool',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'bool',
    };
  }
}
