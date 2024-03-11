// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_multiply.dart';

class NumMultiplyMapper extends SubClassMapperBase<NumMultiply> {
  NumMultiplyMapper._();

  static NumMultiplyMapper? _instance;
  static NumMultiplyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumMultiplyMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumMultiply';

  static int _$id(NumMultiply v) => v.id;
  static const Field<NumMultiply, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumMultiply v) => v.inputs;
  static const Field<NumMultiply, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumMultiply v) => v.offset;
  static const Field<NumMultiply, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumMultiply v) => v.label;
  static const Field<NumMultiply, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumMultiply v) => v.expanded;
  static const Field<NumMultiply, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumMultiply v) => v.getNode;
  static const Field<NumMultiply, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumMultiply> fields = const {
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
  final dynamic discriminatorValue = 'num_multiply';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumMultiply _instantiate(DecodingData data) {
    return NumMultiply(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumMultiply fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumMultiply>(map);
  }

  static NumMultiply fromJson(String json) {
    return ensureInitialized().decodeJson<NumMultiply>(json);
  }
}

mixin NumMultiplyMappable {
  String toJson() {
    return NumMultiplyMapper.ensureInitialized()
        .encodeJson<NumMultiply>(this as NumMultiply);
  }

  Map<String, dynamic> toMap() {
    return NumMultiplyMapper.ensureInitialized()
        .encodeMap<NumMultiply>(this as NumMultiply);
  }

  NumMultiplyCopyWith<NumMultiply, NumMultiply, NumMultiply> get copyWith =>
      _NumMultiplyCopyWithImpl(this as NumMultiply, $identity, $identity);
  @override
  String toString() {
    return NumMultiplyMapper.ensureInitialized()
        .stringifyValue(this as NumMultiply);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumMultiplyMapper.ensureInitialized()
                .isValueEqual(this as NumMultiply, other));
  }

  @override
  int get hashCode {
    return NumMultiplyMapper.ensureInitialized().hashValue(this as NumMultiply);
  }
}

extension NumMultiplyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumMultiply, $Out> {
  NumMultiplyCopyWith<$R, NumMultiply, $Out> get $asNumMultiply =>
      $base.as((v, t, t2) => _NumMultiplyCopyWithImpl(v, t, t2));
}

abstract class NumMultiplyCopyWith<$R, $In extends NumMultiply, $Out>
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
  NumMultiplyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumMultiplyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumMultiply, $Out>
    implements NumMultiplyCopyWith<$R, NumMultiply, $Out> {
  _NumMultiplyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumMultiply> $mapper =
      NumMultiplyMapper.ensureInitialized();
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
  NumMultiply $make(CopyWithData data) => NumMultiply(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumMultiplyCopyWith<$R2, NumMultiply, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumMultiplyCopyWithImpl($value, $cast, t);
}
