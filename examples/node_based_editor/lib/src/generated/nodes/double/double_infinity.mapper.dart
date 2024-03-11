// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_infinity.dart';

class DoubleInfinityMapper extends SubClassMapperBase<DoubleInfinity> {
  DoubleInfinityMapper._();

  static DoubleInfinityMapper? _instance;
  static DoubleInfinityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleInfinityMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleInfinity';

  static int _$id(DoubleInfinity v) => v.id;
  static const Field<DoubleInfinity, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleInfinity v) => v.inputs;
  static const Field<DoubleInfinity, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleInfinity v) => v.offset;
  static const Field<DoubleInfinity, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleInfinity v) => v.label;
  static const Field<DoubleInfinity, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleInfinity v) => v.expanded;
  static const Field<DoubleInfinity, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleInfinity v) => v.getNode;
  static const Field<DoubleInfinity, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleInfinity> fields = const {
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
  final dynamic discriminatorValue = 'double_infinity';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleInfinity _instantiate(DecodingData data) {
    return DoubleInfinity(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleInfinity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleInfinity>(map);
  }

  static DoubleInfinity fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleInfinity>(json);
  }
}

mixin DoubleInfinityMappable {
  String toJson() {
    return DoubleInfinityMapper.ensureInitialized()
        .encodeJson<DoubleInfinity>(this as DoubleInfinity);
  }

  Map<String, dynamic> toMap() {
    return DoubleInfinityMapper.ensureInitialized()
        .encodeMap<DoubleInfinity>(this as DoubleInfinity);
  }

  DoubleInfinityCopyWith<DoubleInfinity, DoubleInfinity, DoubleInfinity>
      get copyWith => _DoubleInfinityCopyWithImpl(
          this as DoubleInfinity, $identity, $identity);
  @override
  String toString() {
    return DoubleInfinityMapper.ensureInitialized()
        .stringifyValue(this as DoubleInfinity);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleInfinityMapper.ensureInitialized()
                .isValueEqual(this as DoubleInfinity, other));
  }

  @override
  int get hashCode {
    return DoubleInfinityMapper.ensureInitialized()
        .hashValue(this as DoubleInfinity);
  }
}

extension DoubleInfinityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleInfinity, $Out> {
  DoubleInfinityCopyWith<$R, DoubleInfinity, $Out> get $asDoubleInfinity =>
      $base.as((v, t, t2) => _DoubleInfinityCopyWithImpl(v, t, t2));
}

abstract class DoubleInfinityCopyWith<$R, $In extends DoubleInfinity, $Out>
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
  DoubleInfinityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleInfinityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleInfinity, $Out>
    implements DoubleInfinityCopyWith<$R, DoubleInfinity, $Out> {
  _DoubleInfinityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleInfinity> $mapper =
      DoubleInfinityMapper.ensureInitialized();
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
  DoubleInfinity $make(CopyWithData data) => DoubleInfinity(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleInfinityCopyWith<$R2, DoubleInfinity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleInfinityCopyWithImpl($value, $cast, t);
}
