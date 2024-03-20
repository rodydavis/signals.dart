import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'regex_to_pattern.mapper.dart';

@MappableClass(
  discriminatorValue: 'regex_to_pattern',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class RegexToPattern extends BaseNode with RegexToPatternMappable {
  RegexToPattern({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  RegexToPattern.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Regex To Pattern'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<RegExp>(RegExp("Regex Here"))),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<Pattern>(() {
          return input<RegExp>('value')!();
        }),
      };

  static const fromMap = RegexToPatternMapper.fromMap;
  static const fromJson = RegexToPatternMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'RegExp',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'Pattern',
    };
  }
}
