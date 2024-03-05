// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_less_than_equal.dart';

class IntLessThanEqualMapper extends SubClassMapperBase<IntLessThanEqual> {
  IntLessThanEqualMapper._();

  static IntLessThanEqualMapper? _instance;
  static IntLessThanEqualMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntLessThanEqualMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntLessThanEqual';

  static int _$id(IntLessThanEqual v) => v.id;
  static const Field<IntLessThanEqual, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntLessThanEqual v) =>
      v.inputs;
  static const Field<IntLessThanEqual, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntLessThanEqual v) => v.offset;
  static const Field<IntLessThanEqual, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntLessThanEqual v) => v.label;
  static const Field<IntLessThanEqual, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntLessThanEqual v) => v.expanded;
  static const Field<IntLessThanEqual, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntLessThanEqual v) => v.getNode;
  static const Field<IntLessThanEqual, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntLessThanEqual> fields = const {
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
  final dynamic discriminatorValue = 'int_less_than_equal';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntLessThanEqual _instantiate(DecodingData data) {
    return IntLessThanEqual(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntLessThanEqual fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntLessThanEqual>(map);
  }

  static IntLessThanEqual fromJson(String json) {
    return ensureInitialized().decodeJson<IntLessThanEqual>(json);
  }
}

mixin IntLessThanEqualMappable {
  String toJson() {
    return IntLessThanEqualMapper.ensureInitialized()
        .encodeJson<IntLessThanEqual>(this as IntLessThanEqual);
  }

  Map<String, dynamic> toMap() {
    return IntLessThanEqualMapper.ensureInitialized()
        .encodeMap<IntLessThanEqual>(this as IntLessThanEqual);
  }

  IntLessThanEqualCopyWith<IntLessThanEqual, IntLessThanEqual, IntLessThanEqual>
      get copyWith => _IntLessThanEqualCopyWithImpl(
          this as IntLessThanEqual, $identity, $identity);
  @override
  String toString() {
    return IntLessThanEqualMapper.ensureInitialized()
        .stringifyValue(this as IntLessThanEqual);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntLessThanEqualMapper.ensureInitialized()
                .isValueEqual(this as IntLessThanEqual, other));
  }

  @override
  int get hashCode {
    return IntLessThanEqualMapper.ensureInitialized()
        .hashValue(this as IntLessThanEqual);
  }
}

extension IntLessThanEqualValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntLessThanEqual, $Out> {
  IntLessThanEqualCopyWith<$R, IntLessThanEqual, $Out>
      get $asIntLessThanEqual =>
          $base.as((v, t, t2) => _IntLessThanEqualCopyWithImpl(v, t, t2));
}

abstract class IntLessThanEqualCopyWith<$R, $In extends IntLessThanEqual, $Out>
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
  IntLessThanEqualCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntLessThanEqualCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntLessThanEqual, $Out>
    implements IntLessThanEqualCopyWith<$R, IntLessThanEqual, $Out> {
  _IntLessThanEqualCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntLessThanEqual> $mapper =
      IntLessThanEqualMapper.ensureInitialized();
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
  IntLessThanEqual $make(CopyWithData data) => IntLessThanEqual(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntLessThanEqualCopyWith<$R2, IntLessThanEqual, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntLessThanEqualCopyWithImpl($value, $cast, t);
}
