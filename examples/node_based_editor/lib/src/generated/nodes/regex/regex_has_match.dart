import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'regex_has_match.mapper.dart';

@MappableClass(
  discriminatorValue: 'regex_has_match',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class RegexHasMatch extends BaseNode with RegexHasMatchMappable {
  RegexHasMatch({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  RegexHasMatch.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Regex Has Match'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<RegExp>(RegExp("Regex Here"))),
            'input': (link: null, value: signal<String>('Text Here')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<RegExp>('value')!().hasMatch(input<String>('input')!());
        }),
      };

  static const fromMap = RegexHasMatchMapper.fromMap;
  static const fromJson = RegexHasMatchMapper.fromJson;

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
      'value': 'bool',
    };
  }
}
