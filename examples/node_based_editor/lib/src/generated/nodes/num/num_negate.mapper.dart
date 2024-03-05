// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_negate.dart';

class NumNegateMapper extends SubClassMapperBase<NumNegate> {
  NumNegateMapper._();

  static NumNegateMapper? _instance;
  static NumNegateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumNegateMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumNegate';

  static int _$id(NumNegate v) => v.id;
  static const Field<NumNegate, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumNegate v) => v.inputs;
  static const Field<NumNegate, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumNegate v) => v.offset;
  static const Field<NumNegate, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumNegate v) => v.label;
  static const Field<NumNegate, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumNegate v) => v.expanded;
  static const Field<NumNegate, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumNegate v) => v.getNode;
  static const Field<NumNegate, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumNegate> fields = const {
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
  final dynamic discriminatorValue = 'num_negate';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumNegate _instantiate(DecodingData data) {
    return NumNegate(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumNegate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumNegate>(map);
  }

  static NumNegate fromJson(String json) {
    return ensureInitialized().decodeJson<NumNegate>(json);
  }
}

mixin NumNegateMappable {
  String toJson() {
    return NumNegateMapper.ensureInitialized()
        .encodeJson<NumNegate>(this as NumNegate);
  }

  Map<String, dynamic> toMap() {
    return NumNegateMapper.ensureInitialized()
        .encodeMap<NumNegate>(this as NumNegate);
  }

  NumNegateCopyWith<NumNegate, NumNegate, NumNegate> get copyWith =>
      _NumNegateCopyWithImpl(this as NumNegate, $identity, $identity);
  @override
  String toString() {
    return NumNegateMapper.ensureInitialized()
        .stringifyValue(this as NumNegate);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumNegateMapper.ensureInitialized()
                .isValueEqual(this as NumNegate, other));
  }

  @override
  int get hashCode {
    return NumNegateMapper.ensureInitialized().hashValue(this as NumNegate);
  }
}

extension NumNegateValueCopy<$R, $Out> on ObjectCopyWith<$R, NumNegate, $Out> {
  NumNegateCopyWith<$R, NumNegate, $Out> get $asNumNegate =>
      $base.as((v, t, t2) => _NumNegateCopyWithImpl(v, t, t2));
}

abstract class NumNegateCopyWith<$R, $In extends NumNegate, $Out>
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
  NumNegateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumNegateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumNegate, $Out>
    implements NumNegateCopyWith<$R, NumNegate, $Out> {
  _NumNegateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumNegate> $mapper =
      NumNegateMapper.ensureInitialized();
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
  NumNegate $make(CopyWithData data) => NumNegate(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumNegateCopyWith<$R2, NumNegate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumNegateCopyWithImpl($value, $cast, t);
}
