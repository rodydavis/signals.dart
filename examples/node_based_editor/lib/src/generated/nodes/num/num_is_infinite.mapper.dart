// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_is_infinite.dart';

class NumIsInfiniteMapper extends SubClassMapperBase<NumIsInfinite> {
  NumIsInfiniteMapper._();

  static NumIsInfiniteMapper? _instance;
  static NumIsInfiniteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumIsInfiniteMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumIsInfinite';

  static int _$id(NumIsInfinite v) => v.id;
  static const Field<NumIsInfinite, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumIsInfinite v) => v.inputs;
  static const Field<NumIsInfinite, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumIsInfinite v) => v.offset;
  static const Field<NumIsInfinite, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumIsInfinite v) => v.label;
  static const Field<NumIsInfinite, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumIsInfinite v) => v.expanded;
  static const Field<NumIsInfinite, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumIsInfinite v) => v.getNode;
  static const Field<NumIsInfinite, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumIsInfinite> fields = const {
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
  final dynamic discriminatorValue = 'num_is_infinite';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumIsInfinite _instantiate(DecodingData data) {
    return NumIsInfinite(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumIsInfinite fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumIsInfinite>(map);
  }

  static NumIsInfinite fromJson(String json) {
    return ensureInitialized().decodeJson<NumIsInfinite>(json);
  }
}

mixin NumIsInfiniteMappable {
  String toJson() {
    return NumIsInfiniteMapper.ensureInitialized()
        .encodeJson<NumIsInfinite>(this as NumIsInfinite);
  }

  Map<String, dynamic> toMap() {
    return NumIsInfiniteMapper.ensureInitialized()
        .encodeMap<NumIsInfinite>(this as NumIsInfinite);
  }

  NumIsInfiniteCopyWith<NumIsInfinite, NumIsInfinite, NumIsInfinite>
      get copyWith => _NumIsInfiniteCopyWithImpl(
          this as NumIsInfinite, $identity, $identity);
  @override
  String toString() {
    return NumIsInfiniteMapper.ensureInitialized()
        .stringifyValue(this as NumIsInfinite);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumIsInfiniteMapper.ensureInitialized()
                .isValueEqual(this as NumIsInfinite, other));
  }

  @override
  int get hashCode {
    return NumIsInfiniteMapper.ensureInitialized()
        .hashValue(this as NumIsInfinite);
  }
}

extension NumIsInfiniteValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumIsInfinite, $Out> {
  NumIsInfiniteCopyWith<$R, NumIsInfinite, $Out> get $asNumIsInfinite =>
      $base.as((v, t, t2) => _NumIsInfiniteCopyWithImpl(v, t, t2));
}

abstract class NumIsInfiniteCopyWith<$R, $In extends NumIsInfinite, $Out>
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
  NumIsInfiniteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumIsInfiniteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumIsInfinite, $Out>
    implements NumIsInfiniteCopyWith<$R, NumIsInfinite, $Out> {
  _NumIsInfiniteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumIsInfinite> $mapper =
      NumIsInfiniteMapper.ensureInitialized();
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
  NumIsInfinite $make(CopyWithData data) => NumIsInfinite(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumIsInfiniteCopyWith<$R2, NumIsInfinite, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumIsInfiniteCopyWithImpl($value, $cast, t);
}
