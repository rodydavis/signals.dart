// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pattern_match_as_prefix.dart';

class PatternMatchAsPrefixMapper
    extends SubClassMapperBase<PatternMatchAsPrefix> {
  PatternMatchAsPrefixMapper._();

  static PatternMatchAsPrefixMapper? _instance;
  static PatternMatchAsPrefixMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatternMatchAsPrefixMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'PatternMatchAsPrefix';

  static int _$id(PatternMatchAsPrefix v) => v.id;
  static const Field<PatternMatchAsPrefix, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(PatternMatchAsPrefix v) =>
      v.inputs;
  static const Field<PatternMatchAsPrefix, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(PatternMatchAsPrefix v) => v.offset;
  static const Field<PatternMatchAsPrefix, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(PatternMatchAsPrefix v) => v.label;
  static const Field<PatternMatchAsPrefix, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(PatternMatchAsPrefix v) => v.expanded;
  static const Field<PatternMatchAsPrefix, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(PatternMatchAsPrefix v) => v.getNode;
  static const Field<PatternMatchAsPrefix, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<PatternMatchAsPrefix> fields = const {
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
  final dynamic discriminatorValue = 'pattern_match_as_prefix';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static PatternMatchAsPrefix _instantiate(DecodingData data) {
    return PatternMatchAsPrefix(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static PatternMatchAsPrefix fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatternMatchAsPrefix>(map);
  }

  static PatternMatchAsPrefix fromJson(String json) {
    return ensureInitialized().decodeJson<PatternMatchAsPrefix>(json);
  }
}

mixin PatternMatchAsPrefixMappable {
  String toJson() {
    return PatternMatchAsPrefixMapper.ensureInitialized()
        .encodeJson<PatternMatchAsPrefix>(this as PatternMatchAsPrefix);
  }

  Map<String, dynamic> toMap() {
    return PatternMatchAsPrefixMapper.ensureInitialized()
        .encodeMap<PatternMatchAsPrefix>(this as PatternMatchAsPrefix);
  }

  PatternMatchAsPrefixCopyWith<PatternMatchAsPrefix, PatternMatchAsPrefix,
          PatternMatchAsPrefix>
      get copyWith => _PatternMatchAsPrefixCopyWithImpl(
          this as PatternMatchAsPrefix, $identity, $identity);
  @override
  String toString() {
    return PatternMatchAsPrefixMapper.ensureInitialized()
        .stringifyValue(this as PatternMatchAsPrefix);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PatternMatchAsPrefixMapper.ensureInitialized()
                .isValueEqual(this as PatternMatchAsPrefix, other));
  }

  @override
  int get hashCode {
    return PatternMatchAsPrefixMapper.ensureInitialized()
        .hashValue(this as PatternMatchAsPrefix);
  }
}

extension PatternMatchAsPrefixValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatternMatchAsPrefix, $Out> {
  PatternMatchAsPrefixCopyWith<$R, PatternMatchAsPrefix, $Out>
      get $asPatternMatchAsPrefix =>
          $base.as((v, t, t2) => _PatternMatchAsPrefixCopyWithImpl(v, t, t2));
}

abstract class PatternMatchAsPrefixCopyWith<
    $R,
    $In extends PatternMatchAsPrefix,
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
  PatternMatchAsPrefixCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatternMatchAsPrefixCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatternMatchAsPrefix, $Out>
    implements PatternMatchAsPrefixCopyWith<$R, PatternMatchAsPrefix, $Out> {
  _PatternMatchAsPrefixCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatternMatchAsPrefix> $mapper =
      PatternMatchAsPrefixMapper.ensureInitialized();
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
  PatternMatchAsPrefix $make(CopyWithData data) => PatternMatchAsPrefix(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  PatternMatchAsPrefixCopyWith<$R2, PatternMatchAsPrefix, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PatternMatchAsPrefixCopyWithImpl($value, $cast, t);
}
