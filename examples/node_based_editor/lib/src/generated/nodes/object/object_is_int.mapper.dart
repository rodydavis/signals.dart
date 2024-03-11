// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_is_int.dart';

class ObjectIsIntMapper extends SubClassMapperBase<ObjectIsInt> {
  ObjectIsIntMapper._();

  static ObjectIsIntMapper? _instance;
  static ObjectIsIntMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIsIntMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIsInt';

  static int _$id(ObjectIsInt v) => v.id;
  static const Field<ObjectIsInt, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectIsInt v) => v.inputs;
  static const Field<ObjectIsInt, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectIsInt v) => v.offset;
  static const Field<ObjectIsInt, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectIsInt v) => v.label;
  static const Field<ObjectIsInt, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectIsInt v) => v.expanded;
  static const Field<ObjectIsInt, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectIsInt v) => v.getNode;
  static const Field<ObjectIsInt, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectIsInt> fields = const {
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
  final dynamic discriminatorValue = 'object_is_int';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectIsInt _instantiate(DecodingData data) {
    return ObjectIsInt(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIsInt fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIsInt>(map);
  }

  static ObjectIsInt fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIsInt>(json);
  }
}

mixin ObjectIsIntMappable {
  String toJson() {
    return ObjectIsIntMapper.ensureInitialized()
        .encodeJson<ObjectIsInt>(this as ObjectIsInt);
  }

  Map<String, dynamic> toMap() {
    return ObjectIsIntMapper.ensureInitialized()
        .encodeMap<ObjectIsInt>(this as ObjectIsInt);
  }

  ObjectIsIntCopyWith<ObjectIsInt, ObjectIsInt, ObjectIsInt> get copyWith =>
      _ObjectIsIntCopyWithImpl(this as ObjectIsInt, $identity, $identity);
  @override
  String toString() {
    return ObjectIsIntMapper.ensureInitialized()
        .stringifyValue(this as ObjectIsInt);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectIsIntMapper.ensureInitialized()
                .isValueEqual(this as ObjectIsInt, other));
  }

  @override
  int get hashCode {
    return ObjectIsIntMapper.ensureInitialized().hashValue(this as ObjectIsInt);
  }
}

extension ObjectIsIntValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIsInt, $Out> {
  ObjectIsIntCopyWith<$R, ObjectIsInt, $Out> get $asObjectIsInt =>
      $base.as((v, t, t2) => _ObjectIsIntCopyWithImpl(v, t, t2));
}

abstract class ObjectIsIntCopyWith<$R, $In extends ObjectIsInt, $Out>
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
  ObjectIsIntCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectIsIntCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIsInt, $Out>
    implements ObjectIsIntCopyWith<$R, ObjectIsInt, $Out> {
  _ObjectIsIntCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIsInt> $mapper =
      ObjectIsIntMapper.ensureInitialized();
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
  ObjectIsInt $make(CopyWithData data) => ObjectIsInt(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectIsIntCopyWith<$R2, ObjectIsInt, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIsIntCopyWithImpl($value, $cast, t);
}
