import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_parse.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_parse',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleParse extends BaseNode with DoubleParseMappable {
  DoubleParse({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleParse.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Parse'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('0.0')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return double.parse(input<String>('value')!());
        }),
      };

  static const fromMap = DoubleParseMapper.fromMap;
  static const fromJson = DoubleParseMapper.fromJson;

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
      'value': 'double',
    };
  }
}
