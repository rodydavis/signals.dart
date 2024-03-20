// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_truncating_division.dart';

class NumTruncatingDivisionMapper
    extends SubClassMapperBase<NumTruncatingDivision> {
  NumTruncatingDivisionMapper._();

  static NumTruncatingDivisionMapper? _instance;
  static NumTruncatingDivisionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumTruncatingDivisionMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumTruncatingDivision';

  static int _$id(NumTruncatingDivision v) => v.id;
  static const Field<NumTruncatingDivision, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumTruncatingDivision v) =>
      v.inputs;
  static const Field<NumTruncatingDivision, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumTruncatingDivision v) => v.offset;
  static const Field<NumTruncatingDivision, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumTruncatingDivision v) => v.label;
  static const Field<NumTruncatingDivision, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumTruncatingDivision v) => v.expanded;
  static const Field<NumTruncatingDivision, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumTruncatingDivision v) =>
      v.getNode;
  static const Field<NumTruncatingDivision, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumTruncatingDivision> fields = const {
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
  final dynamic discriminatorValue = 'num_truncating_division';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumTruncatingDivision _instantiate(DecodingData data) {
    return NumTruncatingDivision(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumTruncatingDivision fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumTruncatingDivision>(map);
  }

  static NumTruncatingDivision fromJson(String json) {
    return ensureInitialized().decodeJson<NumTruncatingDivision>(json);
  }
}

mixin NumTruncatingDivisionMappable {
  String toJson() {
    return NumTruncatingDivisionMapper.ensureInitialized()
        .encodeJson<NumTruncatingDivision>(this as NumTruncatingDivision);
  }

  Map<String, dynamic> toMap() {
    return NumTruncatingDivisionMapper.ensureInitialized()
        .encodeMap<NumTruncatingDivision>(this as NumTruncatingDivision);
  }

  NumTruncatingDivisionCopyWith<NumTruncatingDivision, NumTruncatingDivision,
          NumTruncatingDivision>
      get copyWith => _NumTruncatingDivisionCopyWithImpl(
          this as NumTruncatingDivision, $identity, $identity);
  @override
  String toString() {
    return NumTruncatingDivisionMapper.ensureInitialized()
        .stringifyValue(this as NumTruncatingDivision);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumTruncatingDivisionMapper.ensureInitialized()
                .isValueEqual(this as NumTruncatingDivision, other));
  }

  @override
  int get hashCode {
    return NumTruncatingDivisionMapper.ensureInitialized()
        .hashValue(this as NumTruncatingDivision);
  }
}

extension NumTruncatingDivisionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumTruncatingDivision, $Out> {
  NumTruncatingDivisionCopyWith<$R, NumTruncatingDivision, $Out>
      get $asNumTruncatingDivision =>
          $base.as((v, t, t2) => _NumTruncatingDivisionCopyWithImpl(v, t, t2));
}

abstract class NumTruncatingDivisionCopyWith<
    $R,
    $In extends NumTruncatingDivision,
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
  NumTruncatingDivisionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumTruncatingDivisionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumTruncatingDivision, $Out>
    implements NumTruncatingDivisionCopyWith<$R, NumTruncatingDivision, $Out> {
  _NumTruncatingDivisionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumTruncatingDivision> $mapper =
      NumTruncatingDivisionMapper.ensureInitialized();
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
  NumTruncatingDivision $make(CopyWithData data) => NumTruncatingDivision(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumTruncatingDivisionCopyWith<$R2, NumTruncatingDivision, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _NumTruncatingDivisionCopyWithImpl($value, $cast, t);
}
