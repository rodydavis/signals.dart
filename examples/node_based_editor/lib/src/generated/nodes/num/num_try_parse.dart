import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_try_parse.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_try_parse',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumTryParse extends BaseNode with NumTryParseMappable {
  NumTryParse({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumTryParse.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num Try Parse'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('0.0')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<num?>(() {
          return num.tryParse(input<String>('value')!());
        }),
      };

  static const fromMap = NumTryParseMapper.fromMap;
  static const fromJson = NumTryParseMapper.fromJson;

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
      'value': 'num?',
    };
  }
}
