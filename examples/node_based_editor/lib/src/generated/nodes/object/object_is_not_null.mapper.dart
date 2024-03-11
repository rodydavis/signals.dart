// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_is_not_null.dart';

class ObjectIsNotNullMapper extends SubClassMapperBase<ObjectIsNotNull> {
  ObjectIsNotNullMapper._();

  static ObjectIsNotNullMapper? _instance;
  static ObjectIsNotNullMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIsNotNullMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIsNotNull';

  static int _$id(ObjectIsNotNull v) => v.id;
  static const Field<ObjectIsNotNull, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectIsNotNull v) =>
      v.inputs;
  static const Field<ObjectIsNotNull, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectIsNotNull v) => v.offset;
  static const Field<ObjectIsNotNull, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectIsNotNull v) => v.label;
  static const Field<ObjectIsNotNull, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectIsNotNull v) => v.expanded;
  static const Field<ObjectIsNotNull, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectIsNotNull v) => v.getNode;
  static const Field<ObjectIsNotNull, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectIsNotNull> fields = const {
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
  final dynamic discriminatorValue = 'object_is_not_null';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectIsNotNull _instantiate(DecodingData data) {
    return ObjectIsNotNull(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIsNotNull fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIsNotNull>(map);
  }

  static ObjectIsNotNull fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIsNotNull>(json);
  }
}

mixin ObjectIsNotNullMappable {
  String toJson() {
    return ObjectIsNotNullMapper.ensureInitialized()
        .encodeJson<ObjectIsNotNull>(this as ObjectIsNotNull);
  }

  Map<String, dynamic> toMap() {
    return ObjectIsNotNullMapper.ensureInitialized()
        .encodeMap<ObjectIsNotNull>(this as ObjectIsNotNull);
  }

  ObjectIsNotNullCopyWith<ObjectIsNotNull, ObjectIsNotNull, ObjectIsNotNull>
      get copyWith => _ObjectIsNotNullCopyWithImpl(
          this as ObjectIsNotNull, $identity, $identity);
  @override
  String toString() {
    return ObjectIsNotNullMapper.ensureInitialized()
        .stringifyValue(this as ObjectIsNotNull);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectIsNotNullMapper.ensureInitialized()
                .isValueEqual(this as ObjectIsNotNull, other));
  }

  @override
  int get hashCode {
    return ObjectIsNotNullMapper.ensureInitialized()
        .hashValue(this as ObjectIsNotNull);
  }
}

extension ObjectIsNotNullValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIsNotNull, $Out> {
  ObjectIsNotNullCopyWith<$R, ObjectIsNotNull, $Out> get $asObjectIsNotNull =>
      $base.as((v, t, t2) => _ObjectIsNotNullCopyWithImpl(v, t, t2));
}

abstract class ObjectIsNotNullCopyWith<$R, $In extends ObjectIsNotNull, $Out>
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
  ObjectIsNotNullCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ObjectIsNotNullCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIsNotNull, $Out>
    implements ObjectIsNotNullCopyWith<$R, ObjectIsNotNull, $Out> {
  _ObjectIsNotNullCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIsNotNull> $mapper =
      ObjectIsNotNullMapper.ensureInitialized();
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
  ObjectIsNotNull $make(CopyWithData data) => ObjectIsNotNull(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectIsNotNullCopyWith<$R2, ObjectIsNotNull, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIsNotNullCopyWithImpl($value, $cast, t);
}
