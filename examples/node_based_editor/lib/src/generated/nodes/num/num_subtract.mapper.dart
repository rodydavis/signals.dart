// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_subtract.dart';

class NumSubtractMapper extends SubClassMapperBase<NumSubtract> {
  NumSubtractMapper._();

  static NumSubtractMapper? _instance;
  static NumSubtractMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumSubtractMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumSubtract';

  static int _$id(NumSubtract v) => v.id;
  static const Field<NumSubtract, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumSubtract v) => v.inputs;
  static const Field<NumSubtract, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumSubtract v) => v.offset;
  static const Field<NumSubtract, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumSubtract v) => v.label;
  static const Field<NumSubtract, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumSubtract v) => v.expanded;
  static const Field<NumSubtract, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumSubtract v) => v.getNode;
  static const Field<NumSubtract, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumSubtract> fields = const {
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
  final dynamic discriminatorValue = 'num_subtract';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumSubtract _instantiate(DecodingData data) {
    return NumSubtract(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumSubtract fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumSubtract>(map);
  }

  static NumSubtract fromJson(String json) {
    return ensureInitialized().decodeJson<NumSubtract>(json);
  }
}

mixin NumSubtractMappable {
  String toJson() {
    return NumSubtractMapper.ensureInitialized()
        .encodeJson<NumSubtract>(this as NumSubtract);
  }

  Map<String, dynamic> toMap() {
    return NumSubtractMapper.ensureInitialized()
        .encodeMap<NumSubtract>(this as NumSubtract);
  }

  NumSubtractCopyWith<NumSubtract, NumSubtract, NumSubtract> get copyWith =>
      _NumSubtractCopyWithImpl(this as NumSubtract, $identity, $identity);
  @override
  String toString() {
    return NumSubtractMapper.ensureInitialized()
        .stringifyValue(this as NumSubtract);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumSubtractMapper.ensureInitialized()
                .isValueEqual(this as NumSubtract, other));
  }

  @override
  int get hashCode {
    return NumSubtractMapper.ensureInitialized().hashValue(this as NumSubtract);
  }
}

extension NumSubtractValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumSubtract, $Out> {
  NumSubtractCopyWith<$R, NumSubtract, $Out> get $asNumSubtract =>
      $base.as((v, t, t2) => _NumSubtractCopyWithImpl(v, t, t2));
}

abstract class NumSubtractCopyWith<$R, $In extends NumSubtract, $Out>
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
  NumSubtractCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumSubtractCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumSubtract, $Out>
    implements NumSubtractCopyWith<$R, NumSubtract, $Out> {
  _NumSubtractCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumSubtract> $mapper =
      NumSubtractMapper.ensureInitialized();
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
  NumSubtract $make(CopyWithData data) => NumSubtract(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumSubtractCopyWith<$R2, NumSubtract, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumSubtractCopyWithImpl($value, $cast, t);
}
