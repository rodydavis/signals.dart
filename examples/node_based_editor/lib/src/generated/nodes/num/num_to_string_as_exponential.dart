import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_to_string_as_exponential.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_to_string_as_exponential',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumToStringAsExponential extends BaseNode
    with NumToStringAsExponentialMappable {
  NumToStringAsExponential({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumToStringAsExponential.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num To String As Exponential'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<num>(0.0)),
            'fraction_digits': (link: null, value: signal<int?>(null)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<num>('value')!()
              .toStringAsExponential(input<int?>('fraction_digits')!());
        }),
      };

  static const fromMap = NumToStringAsExponentialMapper.fromMap;
  static const fromJson = NumToStringAsExponentialMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'num',
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
