// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_negative_infinity.dart';

class DoubleNegativeInfinityMapper
    extends SubClassMapperBase<DoubleNegativeInfinity> {
  DoubleNegativeInfinityMapper._();

  static DoubleNegativeInfinityMapper? _instance;
  static DoubleNegativeInfinityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleNegativeInfinityMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleNegativeInfinity';

  static int _$id(DoubleNegativeInfinity v) => v.id;
  static const Field<DoubleNegativeInfinity, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleNegativeInfinity v) =>
      v.inputs;
  static const Field<DoubleNegativeInfinity, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleNegativeInfinity v) => v.offset;
  static const Field<DoubleNegativeInfinity, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleNegativeInfinity v) => v.label;
  static const Field<DoubleNegativeInfinity, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleNegativeInfinity v) => v.expanded;
  static const Field<DoubleNegativeInfinity, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleNegativeInfinity v) =>
      v.getNode;
  static const Field<DoubleNegativeInfinity, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleNegativeInfinity> fields = const {
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
  final dynamic discriminatorValue = 'double_negative_infinity';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleNegativeInfinity _instantiate(DecodingData data) {
    return DoubleNegativeInfinity(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleNegativeInfinity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleNegativeInfinity>(map);
  }

  static DoubleNegativeInfinity fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleNegativeInfinity>(json);
  }
}

mixin DoubleNegativeInfinityMappable {
  String toJson() {
    return DoubleNegativeInfinityMapper.ensureInitialized()
        .encodeJson<DoubleNegativeInfinity>(this as DoubleNegativeInfinity);
  }

  Map<String, dynamic> toMap() {
    return DoubleNegativeInfinityMapper.ensureInitialized()
        .encodeMap<DoubleNegativeInfinity>(this as DoubleNegativeInfinity);
  }

  DoubleNegativeInfinityCopyWith<DoubleNegativeInfinity, DoubleNegativeInfinity,
          DoubleNegativeInfinity>
      get copyWith => _DoubleNegativeInfinityCopyWithImpl(
          this as DoubleNegativeInfinity, $identity, $identity);
  @override
  String toString() {
    return DoubleNegativeInfinityMapper.ensureInitialized()
        .stringifyValue(this as DoubleNegativeInfinity);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleNegativeInfinityMapper.ensureInitialized()
                .isValueEqual(this as DoubleNegativeInfinity, other));
  }

  @override
  int get hashCode {
    return DoubleNegativeInfinityMapper.ensureInitialized()
        .hashValue(this as DoubleNegativeInfinity);
  }
}

extension DoubleNegativeInfinityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleNegativeInfinity, $Out> {
  DoubleNegativeInfinityCopyWith<$R, DoubleNegativeInfinity, $Out>
      get $asDoubleNegativeInfinity =>
          $base.as((v, t, t2) => _DoubleNegativeInfinityCopyWithImpl(v, t, t2));
}

abstract class DoubleNegativeInfinityCopyWith<
    $R,
    $In extends DoubleNegativeInfinity,
    $Out> implements BaseNodeCopyWith<$R, $In, $Out> {
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
  DoubleNegativeInfinityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleNegativeInfinityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleNegativeInfinity, $Out>
    implements
        DoubleNegativeInfinityCopyWith<$R, DoubleNegativeInfinity, $Out> {
  _DoubleNegativeInfinityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleNegativeInfinity> $mapper =
      DoubleNegativeInfinityMapper.ensureInitialized();
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
  DoubleNegativeInfinity $make(CopyWithData data) => DoubleNegativeInfinity(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleNegativeInfinityCopyWith<$R2, DoubleNegativeInfinity, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DoubleNegativeInfinityCopyWithImpl($value, $cast, t);
}
