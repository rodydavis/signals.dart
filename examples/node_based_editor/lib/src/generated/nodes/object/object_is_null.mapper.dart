// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_is_null.dart';

class ObjectIsNullMapper extends SubClassMapperBase<ObjectIsNull> {
  ObjectIsNullMapper._();

  static ObjectIsNullMapper? _instance;
  static ObjectIsNullMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIsNullMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIsNull';

  static int _$id(ObjectIsNull v) => v.id;
  static const Field<ObjectIsNull, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectIsNull v) => v.inputs;
  static const Field<ObjectIsNull, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectIsNull v) => v.offset;
  static const Field<ObjectIsNull, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectIsNull v) => v.label;
  static const Field<ObjectIsNull, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectIsNull v) => v.expanded;
  static const Field<ObjectIsNull, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectIsNull v) => v.getNode;
  static const Field<ObjectIsNull, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectIsNull> fields = const {
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
  final dynamic discriminatorValue = 'object_is_null';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectIsNull _instantiate(DecodingData data) {
    return ObjectIsNull(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIsNull fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIsNull>(map);
  }

  static ObjectIsNull fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIsNull>(json);
  }
}

mixin ObjectIsNullMappable {
  String toJson() {
    return ObjectIsNullMapper.ensureInitialized()
        .encodeJson<ObjectIsNull>(this as ObjectIsNull);
  }

  Map<String, dynamic> toMap() {
    return ObjectIsNullMapper.ensureInitialized()
        .encodeMap<ObjectIsNull>(this as ObjectIsNull);
  }

  ObjectIsNullCopyWith<ObjectIsNull, ObjectIsNull, ObjectIsNull> get copyWith =>
      _ObjectIsNullCopyWithImpl(this as ObjectIsNull, $identity, $identity);
  @override
  String toString() {
    return ObjectIsNullMapper.ensureInitialized()
        .stringifyValue(this as ObjectIsNull);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectIsNullMapper.ensureInitialized()
                .isValueEqual(this as ObjectIsNull, other));
  }

  @override
  int get hashCode {
    return ObjectIsNullMapper.ensureInitialized()
        .hashValue(this as ObjectIsNull);
  }
}

extension ObjectIsNullValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIsNull, $Out> {
  ObjectIsNullCopyWith<$R, ObjectIsNull, $Out> get $asObjectIsNull =>
      $base.as((v, t, t2) => _ObjectIsNullCopyWithImpl(v, t, t2));
}

abstract class ObjectIsNullCopyWith<$R, $In extends ObjectIsNull, $Out>
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
  ObjectIsNullCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectIsNullCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIsNull, $Out>
    implements ObjectIsNullCopyWith<$R, ObjectIsNull, $Out> {
  _ObjectIsNullCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIsNull> $mapper =
      ObjectIsNullMapper.ensureInitialized();
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
  ObjectIsNull $make(CopyWithData data) => ObjectIsNull(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectIsNullCopyWith<$R2, ObjectIsNull, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIsNullCopyWithImpl($value, $cast, t);
}
