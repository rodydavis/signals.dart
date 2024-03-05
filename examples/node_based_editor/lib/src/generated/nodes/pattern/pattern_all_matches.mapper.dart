// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pattern_all_matches.dart';

class PatternAllMatchesMapper extends SubClassMapperBase<PatternAllMatches> {
  PatternAllMatchesMapper._();

  static PatternAllMatchesMapper? _instance;
  static PatternAllMatchesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatternAllMatchesMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'PatternAllMatches';

  static int _$id(PatternAllMatches v) => v.id;
  static const Field<PatternAllMatches, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(PatternAllMatches v) =>
      v.inputs;
  static const Field<PatternAllMatches, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(PatternAllMatches v) => v.offset;
  static const Field<PatternAllMatches, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(PatternAllMatches v) => v.label;
  static const Field<PatternAllMatches, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(PatternAllMatches v) => v.expanded;
  static const Field<PatternAllMatches, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(PatternAllMatches v) => v.getNode;
  static const Field<PatternAllMatches, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<PatternAllMatches> fields = const {
    #id: _f$id,
    #inputs: _f$inputs,
    #offset: _f$offset,
    #label: _f$label,
    #expanded: _f$expanded,
    #getNode: _f$getNode,
  };

  @override
  final String discriminatorKey = '__type';
  @override
  final dynamic discriminatorValue = 'pattern_all_matches';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static PatternAllMatches _instantiate(DecodingData data) {
    return PatternAllMatches(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static PatternAllMatches fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatternAllMatches>(map);
  }

  static PatternAllMatches fromJson(String json) {
    return ensureInitialized().decodeJson<PatternAllMatches>(json);
  }
}

mixin PatternAllMatchesMappable {
  String toJson() {
    return PatternAllMatchesMapper.ensureInitialized()
        .encodeJson<PatternAllMatches>(this as PatternAllMatches);
  }

  Map<String, dynamic> toMap() {
    return PatternAllMatchesMapper.ensureInitialized()
        .encodeMap<PatternAllMatches>(this as PatternAllMatches);
  }

  PatternAllMatchesCopyWith<PatternAllMatches, PatternAllMatches,
          PatternAllMatches>
      get copyWith => _PatternAllMatchesCopyWithImpl(
          this as PatternAllMatches, $identity, $identity);
  @override
  String toString() {
    return PatternAllMatchesMapper.ensureInitialized()
        .stringifyValue(this as PatternAllMatches);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PatternAllMatchesMapper.ensureInitialized()
                .isValueEqual(this as PatternAllMatches, other));
  }

  @override
  int get hashCode {
    return PatternAllMatchesMapper.ensureInitialized()
        .hashValue(this as PatternAllMatches);
  }
}

extension PatternAllMatchesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatternAllMatches, $Out> {
  PatternAllMatchesCopyWith<$R, PatternAllMatches, $Out>
      get $asPatternAllMatches =>
          $base.as((v, t, t2) => _PatternAllMatchesCopyWithImpl(v, t, t2));
}

abstract class PatternAllMatchesCopyWith<$R, $In extends PatternAllMatches,
    $Out> implements BaseNodeCopyWith<$R, $In, $Out> {
  @override
  MapCopyWith<$R, String, NodeInput<dynamic>,
      ObjectCopyWith<$R, NodeInput<dynamic>, NodeInput<dynamic>>> get inputs;
  @override
  $R call(
      {int? id,
      Map<String, NodeInput<dynamic>>? inputs,
      Signal<NodeOffset>? offset,
      Signal<String>? label,
      Signal<bool>? expanded});
  PatternAllMatchesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatternAllMatchesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatternAllMatches, $Out>
    implements PatternAllMatchesCopyWith<$R, PatternAllMatches, $Out> {
  _PatternAllMatchesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatternAllMatches> $mapper =
      PatternAllMatchesMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, NodeInput<dynamic>,
          ObjectCopyWith<$R, NodeInput<dynamic>, NodeInput<dynamic>>>
      get inputs => MapCopyWith($value.inputs,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(inputs: v));
  @override
  $R call(
          {int? id,
          Map<String, NodeInput<dynamic>>? inputs,
          Signal<NodeOffset>? offset,
          Signal<String>? label,
          Signal<bool>? expanded}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (inputs != null) #inputs: inputs,
        if (offset != null) #offset: offset,
        if (label != null) #label: label,
        if (expanded != null) #expanded: expanded
      }));
  @override
  PatternAllMatches $make(CopyWithData data) => PatternAllMatches(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  PatternAllMatchesCopyWith<$R2, PatternAllMatches, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PatternAllMatchesCopyWithImpl($value, $cast, t);
}
