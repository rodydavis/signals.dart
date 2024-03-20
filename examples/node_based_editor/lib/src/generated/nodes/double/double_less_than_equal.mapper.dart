// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_less_than_equal.dart';

class DoubleLessThanEqualMapper
    extends SubClassMapperBase<DoubleLessThanEqual> {
  DoubleLessThanEqualMapper._();

  static DoubleLessThanEqualMapper? _instance;
  static DoubleLessThanEqualMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleLessThanEqualMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleLessThanEqual';

  static int _$id(DoubleLessThanEqual v) => v.id;
  static const Field<DoubleLessThanEqual, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleLessThanEqual v) =>
      v.inputs;
  static const Field<DoubleLessThanEqual, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleLessThanEqual v) => v.offset;
  static const Field<DoubleLessThanEqual, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleLessThanEqual v) => v.label;
  static const Field<DoubleLessThanEqual, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleLessThanEqual v) => v.expanded;
  static const Field<DoubleLessThanEqual, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleLessThanEqual v) => v.getNode;
  static const Field<DoubleLessThanEqual, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleLessThanEqual> fields = const {
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
  final dynamic discriminatorValue = 'double_less_than_equal';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleLessThanEqual _instantiate(DecodingData data) {
    return DoubleLessThanEqual(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleLessThanEqual fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleLessThanEqual>(map);
  }

  static DoubleLessThanEqual fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleLessThanEqual>(json);
  }
}

mixin DoubleLessThanEqualMappable {
  String toJson() {
    return DoubleLessThanEqualMapper.ensureInitialized()
        .encodeJson<DoubleLessThanEqual>(this as DoubleLessThanEqual);
  }

  Map<String, dynamic> toMap() {
    return DoubleLessThanEqualMapper.ensureInitialized()
        .encodeMap<DoubleLessThanEqual>(this as DoubleLessThanEqual);
  }

  DoubleLessThanEqualCopyWith<DoubleLessThanEqual, DoubleLessThanEqual,
          DoubleLessThanEqual>
      get copyWith => _DoubleLessThanEqualCopyWithImpl(
          this as DoubleLessThanEqual, $identity, $identity);
  @override
  String toString() {
    return DoubleLessThanEqualMapper.ensureInitialized()
        .stringifyValue(this as DoubleLessThanEqual);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleLessThanEqualMapper.ensureInitialized()
                .isValueEqual(this as DoubleLessThanEqual, other));
  }

  @override
  int get hashCode {
    return DoubleLessThanEqualMapper.ensureInitialized()
        .hashValue(this as DoubleLessThanEqual);
  }
}

extension DoubleLessThanEqualValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleLessThanEqual, $Out> {
  DoubleLessThanEqualCopyWith<$R, DoubleLessThanEqual, $Out>
      get $asDoubleLessThanEqual =>
          $base.as((v, t, t2) => _DoubleLessThanEqualCopyWithImpl(v, t, t2));
}

abstract class DoubleLessThanEqualCopyWith<$R, $In extends DoubleLessThanEqual,
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
  DoubleLessThanEqualCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleLessThanEqualCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleLessThanEqual, $Out>
    implements DoubleLessThanEqualCopyWith<$R, DoubleLessThanEqual, $Out> {
  _DoubleLessThanEqualCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleLessThanEqual> $mapper =
      DoubleLessThanEqualMapper.ensureInitialized();
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
  DoubleLessThanEqual $make(CopyWithData data) => DoubleLessThanEqual(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleLessThanEqualCopyWith<$R2, DoubleLessThanEqual, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DoubleLessThanEqualCopyWithImpl($value, $cast, t);
}
