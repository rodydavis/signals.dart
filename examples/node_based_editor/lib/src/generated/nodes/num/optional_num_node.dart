import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'optional_num_node.mapper.dart';

@MappableClass(
  discriminatorValue: 'optional_num_node',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class OptionalNumNode extends BaseNode with OptionalNumNodeMappable {
  OptionalNumNode({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  OptionalNumNode.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Optional Num Node'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<num?>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<num?>(() {
          return input<num?>('value')?.call();
        }),
      };

  static const fromMap = OptionalNumNodeMapper.fromMap;
  static const fromJson = OptionalNumNodeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'num?',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'num?',
    };
  }
}
