// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_equal.dart';

class NumEqualMapper extends SubClassMapperBase<NumEqual> {
  NumEqualMapper._();

  static NumEqualMapper? _instance;
  static NumEqualMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumEqualMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumEqual';

  static int _$id(NumEqual v) => v.id;
  static const Field<NumEqual, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumEqual v) => v.inputs;
  static const Field<NumEqual, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumEqual v) => v.offset;
  static const Field<NumEqual, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumEqual v) => v.label;
  static const Field<NumEqual, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumEqual v) => v.expanded;
  static const Field<NumEqual, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumEqual v) => v.getNode;
  static const Field<NumEqual, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumEqual> fields = const {
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
  final dynamic discriminatorValue = 'num_equal';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumEqual _instantiate(DecodingData data) {
    return NumEqual(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumEqual fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumEqual>(map);
  }

  static NumEqual fromJson(String json) {
    return ensureInitialized().decodeJson<NumEqual>(json);
  }
}

mixin NumEqualMappable {
  String toJson() {
    return NumEqualMapper.ensureInitialized()
        .encodeJson<NumEqual>(this as NumEqual);
  }

  Map<String, dynamic> toMap() {
    return NumEqualMapper.ensureInitialized()
        .encodeMap<NumEqual>(this as NumEqual);
  }

  NumEqualCopyWith<NumEqual, NumEqual, NumEqual> get copyWith =>
      _NumEqualCopyWithImpl(this as NumEqual, $identity, $identity);
  @override
  String toString() {
    return NumEqualMapper.ensureInitialized().stringifyValue(this as NumEqual);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumEqualMapper.ensureInitialized()
                .isValueEqual(this as NumEqual, other));
  }

  @override
  int get hashCode {
    return NumEqualMapper.ensureInitialized().hashValue(this as NumEqual);
  }
}

extension NumEqualValueCopy<$R, $Out> on ObjectCopyWith<$R, NumEqual, $Out> {
  NumEqualCopyWith<$R, NumEqual, $Out> get $asNumEqual =>
      $base.as((v, t, t2) => _NumEqualCopyWithImpl(v, t, t2));
}

abstract class NumEqualCopyWith<$R, $In extends NumEqual, $Out>
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
  NumEqualCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumEqualCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumEqual, $Out>
    implements NumEqualCopyWith<$R, NumEqual, $Out> {
  _NumEqualCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumEqual> $mapper =
      NumEqualMapper.ensureInitialized();
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
  NumEqual $make(CopyWithData data) => NumEqual(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumEqualCopyWith<$R2, NumEqual, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumEqualCopyWithImpl($value, $cast, t);
}
