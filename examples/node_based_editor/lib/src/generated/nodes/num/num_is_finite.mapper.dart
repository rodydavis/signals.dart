// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_is_finite.dart';

class NumIsFiniteMapper extends SubClassMapperBase<NumIsFinite> {
  NumIsFiniteMapper._();

  static NumIsFiniteMapper? _instance;
  static NumIsFiniteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumIsFiniteMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumIsFinite';

  static int _$id(NumIsFinite v) => v.id;
  static const Field<NumIsFinite, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumIsFinite v) => v.inputs;
  static const Field<NumIsFinite, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumIsFinite v) => v.offset;
  static const Field<NumIsFinite, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumIsFinite v) => v.label;
  static const Field<NumIsFinite, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumIsFinite v) => v.expanded;
  static const Field<NumIsFinite, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumIsFinite v) => v.getNode;
  static const Field<NumIsFinite, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumIsFinite> fields = const {
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
  final dynamic discriminatorValue = 'num_is_finite';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumIsFinite _instantiate(DecodingData data) {
    return NumIsFinite(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumIsFinite fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumIsFinite>(map);
  }

  static NumIsFinite fromJson(String json) {
    return ensureInitialized().decodeJson<NumIsFinite>(json);
  }
}

mixin NumIsFiniteMappable {
  String toJson() {
    return NumIsFiniteMapper.ensureInitialized()
        .encodeJson<NumIsFinite>(this as NumIsFinite);
  }

  Map<String, dynamic> toMap() {
    return NumIsFiniteMapper.ensureInitialized()
        .encodeMap<NumIsFinite>(this as NumIsFinite);
  }

  NumIsFiniteCopyWith<NumIsFinite, NumIsFinite, NumIsFinite> get copyWith =>
      _NumIsFiniteCopyWithImpl(this as NumIsFinite, $identity, $identity);
  @override
  String toString() {
    return NumIsFiniteMapper.ensureInitialized()
        .stringifyValue(this as NumIsFinite);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumIsFiniteMapper.ensureInitialized()
                .isValueEqual(this as NumIsFinite, other));
  }

  @override
  int get hashCode {
    return NumIsFiniteMapper.ensureInitialized().hashValue(this as NumIsFinite);
  }
}

extension NumIsFiniteValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumIsFinite, $Out> {
  NumIsFiniteCopyWith<$R, NumIsFinite, $Out> get $asNumIsFinite =>
      $base.as((v, t, t2) => _NumIsFiniteCopyWithImpl(v, t, t2));
}

abstract class NumIsFiniteCopyWith<$R, $In extends NumIsFinite, $Out>
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
  NumIsFiniteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumIsFiniteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumIsFinite, $Out>
    implements NumIsFiniteCopyWith<$R, NumIsFinite, $Out> {
  _NumIsFiniteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumIsFinite> $mapper =
      NumIsFiniteMapper.ensureInitialized();
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
  NumIsFinite $make(CopyWithData data) => NumIsFinite(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumIsFiniteCopyWith<$R2, NumIsFinite, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumIsFiniteCopyWithImpl($value, $cast, t);
}
