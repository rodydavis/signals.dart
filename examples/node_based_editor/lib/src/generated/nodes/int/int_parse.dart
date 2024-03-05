import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_parse.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_parse',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntParse extends BaseNode with IntParseMappable {
  IntParse({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntParse.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Parse'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('0')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return int.parse(input<String>('value')!());
        }),
      };

  static const fromMap = IntParseMapper.fromMap;
  static const fromJson = IntParseMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
