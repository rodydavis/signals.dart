// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_is_finite.dart';

class DoubleIsFiniteMapper extends SubClassMapperBase<DoubleIsFinite> {
  DoubleIsFiniteMapper._();

  static DoubleIsFiniteMapper? _instance;
  static DoubleIsFiniteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleIsFiniteMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleIsFinite';

  static int _$id(DoubleIsFinite v) => v.id;
  static const Field<DoubleIsFinite, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleIsFinite v) => v.inputs;
  static const Field<DoubleIsFinite, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleIsFinite v) => v.offset;
  static const Field<DoubleIsFinite, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleIsFinite v) => v.label;
  static const Field<DoubleIsFinite, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleIsFinite v) => v.expanded;
  static const Field<DoubleIsFinite, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleIsFinite v) => v.getNode;
  static const Field<DoubleIsFinite, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleIsFinite> fields = const {
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
  final dynamic discriminatorValue = 'double_is_finite';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleIsFinite _instantiate(DecodingData data) {
    return DoubleIsFinite(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleIsFinite fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleIsFinite>(map);
  }

  static DoubleIsFinite fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleIsFinite>(json);
  }
}

mixin DoubleIsFiniteMappable {
  String toJson() {
    return DoubleIsFiniteMapper.ensureInitialized()
        .encodeJson<DoubleIsFinite>(this as DoubleIsFinite);
  }

  Map<String, dynamic> toMap() {
    return DoubleIsFiniteMapper.ensureInitialized()
        .encodeMap<DoubleIsFinite>(this as DoubleIsFinite);
  }

  DoubleIsFiniteCopyWith<DoubleIsFinite, DoubleIsFinite, DoubleIsFinite>
      get copyWith => _DoubleIsFiniteCopyWithImpl(
          this as DoubleIsFinite, $identity, $identity);
  @override
  String toString() {
    return DoubleIsFiniteMapper.ensureInitialized()
        .stringifyValue(this as DoubleIsFinite);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleIsFiniteMapper.ensureInitialized()
                .isValueEqual(this as DoubleIsFinite, other));
  }

  @override
  int get hashCode {
    return DoubleIsFiniteMapper.ensureInitialized()
        .hashValue(this as DoubleIsFinite);
  }
}

extension DoubleIsFiniteValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleIsFinite, $Out> {
  DoubleIsFiniteCopyWith<$R, DoubleIsFinite, $Out> get $asDoubleIsFinite =>
      $base.as((v, t, t2) => _DoubleIsFiniteCopyWithImpl(v, t, t2));
}

abstract class DoubleIsFiniteCopyWith<$R, $In extends DoubleIsFinite, $Out>
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
  DoubleIsFiniteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleIsFiniteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleIsFinite, $Out>
    implements DoubleIsFiniteCopyWith<$R, DoubleIsFinite, $Out> {
  _DoubleIsFiniteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleIsFinite> $mapper =
      DoubleIsFiniteMapper.ensureInitialized();
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
  DoubleIsFinite $make(CopyWithData data) => DoubleIsFinite(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleIsFiniteCopyWith<$R2, DoubleIsFinite, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleIsFiniteCopyWithImpl($value, $cast, t);
}
