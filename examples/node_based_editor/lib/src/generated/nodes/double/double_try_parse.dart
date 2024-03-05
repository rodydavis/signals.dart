import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_try_parse.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_try_parse',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleTryParse extends BaseNode with DoubleTryParseMappable {
  DoubleTryParse({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleTryParse.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Try Parse'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('0.0')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double?>(() {
          return double.tryParse(input<String>('value')!());
        }),
      };

  static const fromMap = DoubleTryParseMapper.fromMap;
  static const fromJson = DoubleTryParseMapper.fromJson;

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
      'value': 'double?',
    };
  }
}
