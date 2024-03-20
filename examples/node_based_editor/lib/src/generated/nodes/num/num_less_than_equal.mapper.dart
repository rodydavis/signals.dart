// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_less_than_equal.dart';

class NumLessThanEqualMapper extends SubClassMapperBase<NumLessThanEqual> {
  NumLessThanEqualMapper._();

  static NumLessThanEqualMapper? _instance;
  static NumLessThanEqualMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumLessThanEqualMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumLessThanEqual';

  static int _$id(NumLessThanEqual v) => v.id;
  static const Field<NumLessThanEqual, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumLessThanEqual v) =>
      v.inputs;
  static const Field<NumLessThanEqual, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumLessThanEqual v) => v.offset;
  static const Field<NumLessThanEqual, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumLessThanEqual v) => v.label;
  static const Field<NumLessThanEqual, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumLessThanEqual v) => v.expanded;
  static const Field<NumLessThanEqual, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumLessThanEqual v) => v.getNode;
  static const Field<NumLessThanEqual, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumLessThanEqual> fields = const {
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
  final dynamic discriminatorValue = 'num_less_than_equal';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumLessThanEqual _instantiate(DecodingData data) {
    return NumLessThanEqual(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumLessThanEqual fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumLessThanEqual>(map);
  }

  static NumLessThanEqual fromJson(String json) {
    return ensureInitialized().decodeJson<NumLessThanEqual>(json);
  }
}

mixin NumLessThanEqualMappable {
  String toJson() {
    return NumLessThanEqualMapper.ensureInitialized()
        .encodeJson<NumLessThanEqual>(this as NumLessThanEqual);
  }

  Map<String, dynamic> toMap() {
    return NumLessThanEqualMapper.ensureInitialized()
        .encodeMap<NumLessThanEqual>(this as NumLessThanEqual);
  }

  NumLessThanEqualCopyWith<NumLessThanEqual, NumLessThanEqual, NumLessThanEqual>
      get copyWith => _NumLessThanEqualCopyWithImpl(
          this as NumLessThanEqual, $identity, $identity);
  @override
  String toString() {
    return NumLessThanEqualMapper.ensureInitialized()
        .stringifyValue(this as NumLessThanEqual);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumLessThanEqualMapper.ensureInitialized()
                .isValueEqual(this as NumLessThanEqual, other));
  }

  @override
  int get hashCode {
    return NumLessThanEqualMapper.ensureInitialized()
        .hashValue(this as NumLessThanEqual);
  }
}

extension NumLessThanEqualValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumLessThanEqual, $Out> {
  NumLessThanEqualCopyWith<$R, NumLessThanEqual, $Out>
      get $asNumLessThanEqual =>
          $base.as((v, t, t2) => _NumLessThanEqualCopyWithImpl(v, t, t2));
}

abstract class NumLessThanEqualCopyWith<$R, $In extends NumLessThanEqual, $Out>
    implements BaseNodeCopyWith<$R, $In, $Out> {
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
  NumLessThanEqualCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumLessThanEqualCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumLessThanEqual, $Out>
    implements NumLessThanEqualCopyWith<$R, NumLessThanEqual, $Out> {
  _NumLessThanEqualCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumLessThanEqual> $mapper =
      NumLessThanEqualMapper.ensureInitialized();
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
  NumLessThanEqual $make(CopyWithData data) => NumLessThanEqual(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumLessThanEqualCopyWith<$R2, NumLessThanEqual, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumLessThanEqualCopyWithImpl($value, $cast, t);
}
