import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_parse.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_parse',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumParse extends BaseNode with NumParseMappable {
  NumParse({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumParse.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num Parse'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('0.0')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<num>(() {
          return num.parse(input<String>('value')!());
        }),
      };

  static const fromMap = NumParseMapper.fromMap;
  static const fromJson = NumParseMapper.fromJson;

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
      'value': 'num',
    };
  }
}
