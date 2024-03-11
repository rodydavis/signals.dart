// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_is_infinite.dart';

class DoubleIsInfiniteMapper extends SubClassMapperBase<DoubleIsInfinite> {
  DoubleIsInfiniteMapper._();

  static DoubleIsInfiniteMapper? _instance;
  static DoubleIsInfiniteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleIsInfiniteMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleIsInfinite';

  static int _$id(DoubleIsInfinite v) => v.id;
  static const Field<DoubleIsInfinite, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleIsInfinite v) =>
      v.inputs;
  static const Field<DoubleIsInfinite, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleIsInfinite v) => v.offset;
  static const Field<DoubleIsInfinite, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleIsInfinite v) => v.label;
  static const Field<DoubleIsInfinite, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleIsInfinite v) => v.expanded;
  static const Field<DoubleIsInfinite, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleIsInfinite v) => v.getNode;
  static const Field<DoubleIsInfinite, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleIsInfinite> fields = const {
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
  final dynamic discriminatorValue = 'double_is_infinite';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleIsInfinite _instantiate(DecodingData data) {
    return DoubleIsInfinite(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleIsInfinite fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleIsInfinite>(map);
  }

  static DoubleIsInfinite fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleIsInfinite>(json);
  }
}

mixin DoubleIsInfiniteMappable {
  String toJson() {
    return DoubleIsInfiniteMapper.ensureInitialized()
        .encodeJson<DoubleIsInfinite>(this as DoubleIsInfinite);
  }

  Map<String, dynamic> toMap() {
    return DoubleIsInfiniteMapper.ensureInitialized()
        .encodeMap<DoubleIsInfinite>(this as DoubleIsInfinite);
  }

  DoubleIsInfiniteCopyWith<DoubleIsInfinite, DoubleIsInfinite, DoubleIsInfinite>
      get copyWith => _DoubleIsInfiniteCopyWithImpl(
          this as DoubleIsInfinite, $identity, $identity);
  @override
  String toString() {
    return DoubleIsInfiniteMapper.ensureInitialized()
        .stringifyValue(this as DoubleIsInfinite);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleIsInfiniteMapper.ensureInitialized()
                .isValueEqual(this as DoubleIsInfinite, other));
  }

  @override
  int get hashCode {
    return DoubleIsInfiniteMapper.ensureInitialized()
        .hashValue(this as DoubleIsInfinite);
  }
}

extension DoubleIsInfiniteValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleIsInfinite, $Out> {
  DoubleIsInfiniteCopyWith<$R, DoubleIsInfinite, $Out>
      get $asDoubleIsInfinite =>
          $base.as((v, t, t2) => _DoubleIsInfiniteCopyWithImpl(v, t, t2));
}

abstract class DoubleIsInfiniteCopyWith<$R, $In extends DoubleIsInfinite, $Out>
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
  DoubleIsInfiniteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleIsInfiniteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleIsInfinite, $Out>
    implements DoubleIsInfiniteCopyWith<$R, DoubleIsInfinite, $Out> {
  _DoubleIsInfiniteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleIsInfinite> $mapper =
      DoubleIsInfiniteMapper.ensureInitialized();
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
  DoubleIsInfinite $make(CopyWithData data) => DoubleIsInfinite(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleIsInfiniteCopyWith<$R2, DoubleIsInfinite, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleIsInfiniteCopyWithImpl($value, $cast, t);
}
