import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'pattern_all_matches.mapper.dart';

@MappableClass(
  discriminatorValue: 'pattern_all_matches',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class PatternAllMatches extends BaseNode with PatternAllMatchesMappable {
  PatternAllMatches({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  PatternAllMatches.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Pattern All Matches'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'pattern': (link: null, value: signal<Pattern>('Text Here')),
            'start': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<Iterable<Match>>(() {
          return input<Pattern>('pattern')!()
              .allMatches(input<String>('value')!(), input<int>('start')!());
        }),
      };

  static const fromMap = PatternAllMatchesMapper.fromMap;
  static const fromJson = PatternAllMatchesMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'pattern': 'Pattern',
      'start': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'Iterable<Match>',
    };
  }
}
