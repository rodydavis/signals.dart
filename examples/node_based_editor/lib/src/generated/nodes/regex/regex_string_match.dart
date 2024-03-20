import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'regex_string_match.mapper.dart';

@MappableClass(
  discriminatorValue: 'regex_string_match',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class RegexStringMatch extends BaseNode with RegexStringMatchMappable {
  RegexStringMatch({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  RegexStringMatch.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Regex String Match'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<RegExp>(RegExp("Regex Here"))),
            'input': (link: null, value: signal<String>('Text Here')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String?>(() {
          return input<RegExp>('value')!()
              .stringMatch(input<String>('input')!());
        }),
      };

  static const fromMap = RegexStringMatchMapper.fromMap;
  static const fromJson = RegexStringMatchMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'RegExp',
      'input': 'String',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String?',
    };
  }
}
