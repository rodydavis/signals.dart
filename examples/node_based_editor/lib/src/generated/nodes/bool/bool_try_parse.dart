import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'bool_try_parse.mapper.dart';

@MappableClass(
  discriminatorValue: 'bool_try_parse',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class BoolTryParse extends BaseNode with BoolTryParseMappable {
  BoolTryParse({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  BoolTryParse.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Bool Try Parse'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('false')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool?>(() {
          return bool.tryParse(input<String>('value')!());
        }),
      };

  static const fromMap = BoolTryParseMapper.fromMap;
  static const fromJson = BoolTryParseMapper.fromJson;

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
      'value': 'bool?',
    };
  }
}
