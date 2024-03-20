// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_truncate.dart';

class NumTruncateMapper extends SubClassMapperBase<NumTruncate> {
  NumTruncateMapper._();

  static NumTruncateMapper? _instance;
  static NumTruncateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumTruncateMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumTruncate';

  static int _$id(NumTruncate v) => v.id;
  static const Field<NumTruncate, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumTruncate v) => v.inputs;
  static const Field<NumTruncate, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumTruncate v) => v.offset;
  static const Field<NumTruncate, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumTruncate v) => v.label;
  static const Field<NumTruncate, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumTruncate v) => v.expanded;
  static const Field<NumTruncate, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumTruncate v) => v.getNode;
  static const Field<NumTruncate, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumTruncate> fields = const {
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
  final dynamic discriminatorValue = 'num_truncate';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumTruncate _instantiate(DecodingData data) {
    return NumTruncate(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumTruncate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumTruncate>(map);
  }

  static NumTruncate fromJson(String json) {
    return ensureInitialized().decodeJson<NumTruncate>(json);
  }
}

mixin NumTruncateMappable {
  String toJson() {
    return NumTruncateMapper.ensureInitialized()
        .encodeJson<NumTruncate>(this as NumTruncate);
  }

  Map<String, dynamic> toMap() {
    return NumTruncateMapper.ensureInitialized()
        .encodeMap<NumTruncate>(this as NumTruncate);
  }

  NumTruncateCopyWith<NumTruncate, NumTruncate, NumTruncate> get copyWith =>
      _NumTruncateCopyWithImpl(this as NumTruncate, $identity, $identity);
  @override
  String toString() {
    return NumTruncateMapper.ensureInitialized()
        .stringifyValue(this as NumTruncate);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumTruncateMapper.ensureInitialized()
                .isValueEqual(this as NumTruncate, other));
  }

  @override
  int get hashCode {
    return NumTruncateMapper.ensureInitialized().hashValue(this as NumTruncate);
  }
}

extension NumTruncateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumTruncate, $Out> {
  NumTruncateCopyWith<$R, NumTruncate, $Out> get $asNumTruncate =>
      $base.as((v, t, t2) => _NumTruncateCopyWithImpl(v, t, t2));
}

abstract class NumTruncateCopyWith<$R, $In extends NumTruncate, $Out>
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
  NumTruncateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumTruncateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumTruncate, $Out>
    implements NumTruncateCopyWith<$R, NumTruncate, $Out> {
  _NumTruncateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumTruncate> $mapper =
      NumTruncateMapper.ensureInitialized();
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
  NumTruncate $make(CopyWithData data) => NumTruncate(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumTruncateCopyWith<$R2, NumTruncate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumTruncateCopyWithImpl($value, $cast, t);
}
