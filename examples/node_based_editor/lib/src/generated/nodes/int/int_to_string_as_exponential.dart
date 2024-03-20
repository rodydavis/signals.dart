import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_to_string_as_exponential.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_to_string_as_exponential',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntToStringAsExponential extends BaseNode
    with IntToStringAsExponentialMappable {
  IntToStringAsExponential({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntToStringAsExponential.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int To String As Exponential'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'fraction_digits': (link: null, value: signal<int?>(null)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<int>('value')!()
              .toStringAsExponential(input<int?>('fraction_digits')!());
        }),
      };

  static const fromMap = IntToStringAsExponentialMapper.fromMap;
  static const fromJson = IntToStringAsExponentialMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
      'fraction_digits': 'int?',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
