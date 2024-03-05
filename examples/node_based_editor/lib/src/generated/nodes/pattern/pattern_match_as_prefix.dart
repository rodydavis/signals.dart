import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'pattern_match_as_prefix.mapper.dart';

@MappableClass(
  discriminatorValue: 'pattern_match_as_prefix',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class PatternMatchAsPrefix extends BaseNode with PatternMatchAsPrefixMappable {
  PatternMatchAsPrefix({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  PatternMatchAsPrefix.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Pattern Match As Prefix'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'pattern': (link: null, value: signal<Pattern>('Text Here')),
            'start': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<Match?>(() {
          return input<Pattern>('pattern')!()
              .matchAsPrefix(input<String>('value')!(), input<int>('start')!());
        }),
      };

  static const fromMap = PatternMatchAsPrefixMapper.fromMap;
  static const fromJson = PatternMatchAsPrefixMapper.fromJson;

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
      'value': 'Match?',
    };
  }
}
