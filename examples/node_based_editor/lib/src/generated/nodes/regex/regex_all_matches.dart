import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'regex_all_matches.mapper.dart';

@MappableClass(
  discriminatorValue: 'regex_all_matches',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class RegexAllMatches extends BaseNode with RegexAllMatchesMappable {
  RegexAllMatches({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  RegexAllMatches.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Regex All Matches'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<RegExp>(RegExp("Regex Here"))),
            'input': (link: null, value: signal<String>('Text Here')),
            'start': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<Iterable<RegExpMatch>>(() {
          return input<RegExp>('value')!()
              .allMatches(input<String>('input')!(), input<int>('start')!());
        }),
      };

  static const fromMap = RegexAllMatchesMapper.fromMap;
  static const fromJson = RegexAllMatchesMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'RegExp',
      'input': 'String',
      'start': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'Iterable<RegExpMatch>',
    };
  }
}
