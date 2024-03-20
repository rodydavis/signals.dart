import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_try_parse.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_try_parse',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntTryParse extends BaseNode with IntTryParseMappable {
  IntTryParse({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntTryParse.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Try Parse'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('0')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int?>(() {
          return int.tryParse(input<String>('value')!());
        }),
      };

  static const fromMap = IntTryParseMapper.fromMap;
  static const fromJson = IntTryParseMapper.fromJson;

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
      'value': 'int?',
    };
  }
}
