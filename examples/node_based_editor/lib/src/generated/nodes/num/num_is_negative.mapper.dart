// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_is_negative.dart';

class NumIsNegativeMapper extends SubClassMapperBase<NumIsNegative> {
  NumIsNegativeMapper._();

  static NumIsNegativeMapper? _instance;
  static NumIsNegativeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumIsNegativeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumIsNegative';

  static int _$id(NumIsNegative v) => v.id;
  static const Field<NumIsNegative, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumIsNegative v) => v.inputs;
  static const Field<NumIsNegative, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumIsNegative v) => v.offset;
  static const Field<NumIsNegative, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumIsNegative v) => v.label;
  static const Field<NumIsNegative, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumIsNegative v) => v.expanded;
  static const Field<NumIsNegative, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumIsNegative v) => v.getNode;
  static const Field<NumIsNegative, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumIsNegative> fields = const {
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
  final dynamic discriminatorValue = 'num_is_negative';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumIsNegative _instantiate(DecodingData data) {
    return NumIsNegative(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumIsNegative fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumIsNegative>(map);
  }

  static NumIsNegative fromJson(String json) {
    return ensureInitialized().decodeJson<NumIsNegative>(json);
  }
}

mixin NumIsNegativeMappable {
  String toJson() {
    return NumIsNegativeMapper.ensureInitialized()
        .encodeJson<NumIsNegative>(this as NumIsNegative);
  }

  Map<String, dynamic> toMap() {
    return NumIsNegativeMapper.ensureInitialized()
        .encodeMap<NumIsNegative>(this as NumIsNegative);
  }

  NumIsNegativeCopyWith<NumIsNegative, NumIsNegative, NumIsNegative>
      get copyWith => _NumIsNegativeCopyWithImpl(
          this as NumIsNegative, $identity, $identity);
  @override
  String toString() {
    return NumIsNegativeMapper.ensureInitialized()
        .stringifyValue(this as NumIsNegative);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumIsNegativeMapper.ensureInitialized()
                .isValueEqual(this as NumIsNegative, other));
  }

  @override
  int get hashCode {
    return NumIsNegativeMapper.ensureInitialized()
        .hashValue(this as NumIsNegative);
  }
}

extension NumIsNegativeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumIsNegative, $Out> {
  NumIsNegativeCopyWith<$R, NumIsNegative, $Out> get $asNumIsNegative =>
      $base.as((v, t, t2) => _NumIsNegativeCopyWithImpl(v, t, t2));
}

abstract class NumIsNegativeCopyWith<$R, $In extends NumIsNegative, $Out>
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
  NumIsNegativeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumIsNegativeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumIsNegative, $Out>
    implements NumIsNegativeCopyWith<$R, NumIsNegative, $Out> {
  _NumIsNegativeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumIsNegative> $mapper =
      NumIsNegativeMapper.ensureInitialized();
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
  NumIsNegative $make(CopyWithData data) => NumIsNegative(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumIsNegativeCopyWith<$R2, NumIsNegative, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumIsNegativeCopyWithImpl($value, $cast, t);
}
