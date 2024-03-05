// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_max_finite.dart';

class DoubleMaxFiniteMapper extends SubClassMapperBase<DoubleMaxFinite> {
  DoubleMaxFiniteMapper._();

  static DoubleMaxFiniteMapper? _instance;
  static DoubleMaxFiniteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleMaxFiniteMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleMaxFinite';

  static int _$id(DoubleMaxFinite v) => v.id;
  static const Field<DoubleMaxFinite, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleMaxFinite v) =>
      v.inputs;
  static const Field<DoubleMaxFinite, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleMaxFinite v) => v.offset;
  static const Field<DoubleMaxFinite, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleMaxFinite v) => v.label;
  static const Field<DoubleMaxFinite, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleMaxFinite v) => v.expanded;
  static const Field<DoubleMaxFinite, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleMaxFinite v) => v.getNode;
  static const Field<DoubleMaxFinite, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleMaxFinite> fields = const {
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
  final dynamic discriminatorValue = 'double_max_finite';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleMaxFinite _instantiate(DecodingData data) {
    return DoubleMaxFinite(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleMaxFinite fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleMaxFinite>(map);
  }

  static DoubleMaxFinite fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleMaxFinite>(json);
  }
}

mixin DoubleMaxFiniteMappable {
  String toJson() {
    return DoubleMaxFiniteMapper.ensureInitialized()
        .encodeJson<DoubleMaxFinite>(this as DoubleMaxFinite);
  }

  Map<String, dynamic> toMap() {
    return DoubleMaxFiniteMapper.ensureInitialized()
        .encodeMap<DoubleMaxFinite>(this as DoubleMaxFinite);
  }

  DoubleMaxFiniteCopyWith<DoubleMaxFinite, DoubleMaxFinite, DoubleMaxFinite>
      get copyWith => _DoubleMaxFiniteCopyWithImpl(
          this as DoubleMaxFinite, $identity, $identity);
  @override
  String toString() {
    return DoubleMaxFiniteMapper.ensureInitialized()
        .stringifyValue(this as DoubleMaxFinite);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleMaxFiniteMapper.ensureInitialized()
                .isValueEqual(this as DoubleMaxFinite, other));
  }

  @override
  int get hashCode {
    return DoubleMaxFiniteMapper.ensureInitialized()
        .hashValue(this as DoubleMaxFinite);
  }
}

extension DoubleMaxFiniteValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleMaxFinite, $Out> {
  DoubleMaxFiniteCopyWith<$R, DoubleMaxFinite, $Out> get $asDoubleMaxFinite =>
      $base.as((v, t, t2) => _DoubleMaxFiniteCopyWithImpl(v, t, t2));
}

abstract class DoubleMaxFiniteCopyWith<$R, $In extends DoubleMaxFinite, $Out>
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
  DoubleMaxFiniteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleMaxFiniteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleMaxFinite, $Out>
    implements DoubleMaxFiniteCopyWith<$R, DoubleMaxFinite, $Out> {
  _DoubleMaxFiniteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleMaxFinite> $mapper =
      DoubleMaxFiniteMapper.ensureInitialized();
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
  DoubleMaxFinite $make(CopyWithData data) => DoubleMaxFinite(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleMaxFiniteCopyWith<$R2, DoubleMaxFinite, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleMaxFiniteCopyWithImpl($value, $cast, t);
}
