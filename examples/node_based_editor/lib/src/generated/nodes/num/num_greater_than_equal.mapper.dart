// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_greater_than_equal.dart';

class NumGreaterThanEqualMapper
    extends SubClassMapperBase<NumGreaterThanEqual> {
  NumGreaterThanEqualMapper._();

  static NumGreaterThanEqualMapper? _instance;
  static NumGreaterThanEqualMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumGreaterThanEqualMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumGreaterThanEqual';

  static int _$id(NumGreaterThanEqual v) => v.id;
  static const Field<NumGreaterThanEqual, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumGreaterThanEqual v) =>
      v.inputs;
  static const Field<NumGreaterThanEqual, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumGreaterThanEqual v) => v.offset;
  static const Field<NumGreaterThanEqual, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumGreaterThanEqual v) => v.label;
  static const Field<NumGreaterThanEqual, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumGreaterThanEqual v) => v.expanded;
  static const Field<NumGreaterThanEqual, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumGreaterThanEqual v) => v.getNode;
  static const Field<NumGreaterThanEqual, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumGreaterThanEqual> fields = const {
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
  final dynamic discriminatorValue = 'num_greater_than_equal';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumGreaterThanEqual _instantiate(DecodingData data) {
    return NumGreaterThanEqual(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumGreaterThanEqual fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumGreaterThanEqual>(map);
  }

  static NumGreaterThanEqual fromJson(String json) {
    return ensureInitialized().decodeJson<NumGreaterThanEqual>(json);
  }
}

mixin NumGreaterThanEqualMappable {
  String toJson() {
    return NumGreaterThanEqualMapper.ensureInitialized()
        .encodeJson<NumGreaterThanEqual>(this as NumGreaterThanEqual);
  }

  Map<String, dynamic> toMap() {
    return NumGreaterThanEqualMapper.ensureInitialized()
        .encodeMap<NumGreaterThanEqual>(this as NumGreaterThanEqual);
  }

  NumGreaterThanEqualCopyWith<NumGreaterThanEqual, NumGreaterThanEqual,
          NumGreaterThanEqual>
      get copyWith => _NumGreaterThanEqualCopyWithImpl(
          this as NumGreaterThanEqual, $identity, $identity);
  @override
  String toString() {
    return NumGreaterThanEqualMapper.ensureInitialized()
        .stringifyValue(this as NumGreaterThanEqual);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumGreaterThanEqualMapper.ensureInitialized()
                .isValueEqual(this as NumGreaterThanEqual, other));
  }

  @override
  int get hashCode {
    return NumGreaterThanEqualMapper.ensureInitialized()
        .hashValue(this as NumGreaterThanEqual);
  }
}

extension NumGreaterThanEqualValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumGreaterThanEqual, $Out> {
  NumGreaterThanEqualCopyWith<$R, NumGreaterThanEqual, $Out>
      get $asNumGreaterThanEqual =>
          $base.as((v, t, t2) => _NumGreaterThanEqualCopyWithImpl(v, t, t2));
}

abstract class NumGreaterThanEqualCopyWith<$R, $In extends NumGreaterThanEqual,
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
  NumGreaterThanEqualCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumGreaterThanEqualCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumGreaterThanEqual, $Out>
    implements NumGreaterThanEqualCopyWith<$R, NumGreaterThanEqual, $Out> {
  _NumGreaterThanEqualCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumGreaterThanEqual> $mapper =
      NumGreaterThanEqualMapper.ensureInitialized();
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
  NumGreaterThanEqual $make(CopyWithData data) => NumGreaterThanEqual(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumGreaterThanEqualCopyWith<$R2, NumGreaterThanEqual, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _NumGreaterThanEqualCopyWithImpl($value, $cast, t);
}
