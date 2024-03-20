// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_greater_than_equal.dart';

class IntGreaterThanEqualMapper
    extends SubClassMapperBase<IntGreaterThanEqual> {
  IntGreaterThanEqualMapper._();

  static IntGreaterThanEqualMapper? _instance;
  static IntGreaterThanEqualMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntGreaterThanEqualMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntGreaterThanEqual';

  static int _$id(IntGreaterThanEqual v) => v.id;
  static const Field<IntGreaterThanEqual, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntGreaterThanEqual v) =>
      v.inputs;
  static const Field<IntGreaterThanEqual, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntGreaterThanEqual v) => v.offset;
  static const Field<IntGreaterThanEqual, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntGreaterThanEqual v) => v.label;
  static const Field<IntGreaterThanEqual, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntGreaterThanEqual v) => v.expanded;
  static const Field<IntGreaterThanEqual, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntGreaterThanEqual v) => v.getNode;
  static const Field<IntGreaterThanEqual, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntGreaterThanEqual> fields = const {
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
  final dynamic discriminatorValue = 'int_greater_than_equal';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntGreaterThanEqual _instantiate(DecodingData data) {
    return IntGreaterThanEqual(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntGreaterThanEqual fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntGreaterThanEqual>(map);
  }

  static IntGreaterThanEqual fromJson(String json) {
    return ensureInitialized().decodeJson<IntGreaterThanEqual>(json);
  }
}

mixin IntGreaterThanEqualMappable {
  String toJson() {
    return IntGreaterThanEqualMapper.ensureInitialized()
        .encodeJson<IntGreaterThanEqual>(this as IntGreaterThanEqual);
  }

  Map<String, dynamic> toMap() {
    return IntGreaterThanEqualMapper.ensureInitialized()
        .encodeMap<IntGreaterThanEqual>(this as IntGreaterThanEqual);
  }

  IntGreaterThanEqualCopyWith<IntGreaterThanEqual, IntGreaterThanEqual,
          IntGreaterThanEqual>
      get copyWith => _IntGreaterThanEqualCopyWithImpl(
          this as IntGreaterThanEqual, $identity, $identity);
  @override
  String toString() {
    return IntGreaterThanEqualMapper.ensureInitialized()
        .stringifyValue(this as IntGreaterThanEqual);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntGreaterThanEqualMapper.ensureInitialized()
                .isValueEqual(this as IntGreaterThanEqual, other));
  }

  @override
  int get hashCode {
    return IntGreaterThanEqualMapper.ensureInitialized()
        .hashValue(this as IntGreaterThanEqual);
  }
}

extension IntGreaterThanEqualValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntGreaterThanEqual, $Out> {
  IntGreaterThanEqualCopyWith<$R, IntGreaterThanEqual, $Out>
      get $asIntGreaterThanEqual =>
          $base.as((v, t, t2) => _IntGreaterThanEqualCopyWithImpl(v, t, t2));
}

abstract class IntGreaterThanEqualCopyWith<$R, $In extends IntGreaterThanEqual,
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
  IntGreaterThanEqualCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntGreaterThanEqualCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntGreaterThanEqual, $Out>
    implements IntGreaterThanEqualCopyWith<$R, IntGreaterThanEqual, $Out> {
  _IntGreaterThanEqualCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntGreaterThanEqual> $mapper =
      IntGreaterThanEqualMapper.ensureInitialized();
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
  IntGreaterThanEqual $make(CopyWithData data) => IntGreaterThanEqual(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntGreaterThanEqualCopyWith<$R2, IntGreaterThanEqual, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _IntGreaterThanEqualCopyWithImpl($value, $cast, t);
}
