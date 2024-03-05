// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_greater_than_equal.dart';

class DoubleGreaterThanEqualMapper
    extends SubClassMapperBase<DoubleGreaterThanEqual> {
  DoubleGreaterThanEqualMapper._();

  static DoubleGreaterThanEqualMapper? _instance;
  static DoubleGreaterThanEqualMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleGreaterThanEqualMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleGreaterThanEqual';

  static int _$id(DoubleGreaterThanEqual v) => v.id;
  static const Field<DoubleGreaterThanEqual, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleGreaterThanEqual v) =>
      v.inputs;
  static const Field<DoubleGreaterThanEqual, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleGreaterThanEqual v) => v.offset;
  static const Field<DoubleGreaterThanEqual, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleGreaterThanEqual v) => v.label;
  static const Field<DoubleGreaterThanEqual, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleGreaterThanEqual v) => v.expanded;
  static const Field<DoubleGreaterThanEqual, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleGreaterThanEqual v) =>
      v.getNode;
  static const Field<DoubleGreaterThanEqual, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleGreaterThanEqual> fields = const {
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
  final dynamic discriminatorValue = 'double_greater_than_equal';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleGreaterThanEqual _instantiate(DecodingData data) {
    return DoubleGreaterThanEqual(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleGreaterThanEqual fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleGreaterThanEqual>(map);
  }

  static DoubleGreaterThanEqual fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleGreaterThanEqual>(json);
  }
}

mixin DoubleGreaterThanEqualMappable {
  String toJson() {
    return DoubleGreaterThanEqualMapper.ensureInitialized()
        .encodeJson<DoubleGreaterThanEqual>(this as DoubleGreaterThanEqual);
  }

  Map<String, dynamic> toMap() {
    return DoubleGreaterThanEqualMapper.ensureInitialized()
        .encodeMap<DoubleGreaterThanEqual>(this as DoubleGreaterThanEqual);
  }

  DoubleGreaterThanEqualCopyWith<DoubleGreaterThanEqual, DoubleGreaterThanEqual,
          DoubleGreaterThanEqual>
      get copyWith => _DoubleGreaterThanEqualCopyWithImpl(
          this as DoubleGreaterThanEqual, $identity, $identity);
  @override
  String toString() {
    return DoubleGreaterThanEqualMapper.ensureInitialized()
        .stringifyValue(this as DoubleGreaterThanEqual);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleGreaterThanEqualMapper.ensureInitialized()
                .isValueEqual(this as DoubleGreaterThanEqual, other));
  }

  @override
  int get hashCode {
    return DoubleGreaterThanEqualMapper.ensureInitialized()
        .hashValue(this as DoubleGreaterThanEqual);
  }
}

extension DoubleGreaterThanEqualValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleGreaterThanEqual, $Out> {
  DoubleGreaterThanEqualCopyWith<$R, DoubleGreaterThanEqual, $Out>
      get $asDoubleGreaterThanEqual =>
          $base.as((v, t, t2) => _DoubleGreaterThanEqualCopyWithImpl(v, t, t2));
}

abstract class DoubleGreaterThanEqualCopyWith<
    $R,
    $In extends DoubleGreaterThanEqual,
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
  DoubleGreaterThanEqualCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleGreaterThanEqualCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleGreaterThanEqual, $Out>
    implements
        DoubleGreaterThanEqualCopyWith<$R, DoubleGreaterThanEqual, $Out> {
  _DoubleGreaterThanEqualCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleGreaterThanEqual> $mapper =
      DoubleGreaterThanEqualMapper.ensureInitialized();
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
  DoubleGreaterThanEqual $make(CopyWithData data) => DoubleGreaterThanEqual(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleGreaterThanEqualCopyWith<$R2, DoubleGreaterThanEqual, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DoubleGreaterThanEqualCopyWithImpl($value, $cast, t);
}
