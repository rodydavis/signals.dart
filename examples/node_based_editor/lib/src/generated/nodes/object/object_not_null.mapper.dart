// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_not_null.dart';

class ObjectNotNullMapper extends SubClassMapperBase<ObjectNotNull> {
  ObjectNotNullMapper._();

  static ObjectNotNullMapper? _instance;
  static ObjectNotNullMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectNotNullMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectNotNull';

  static int _$id(ObjectNotNull v) => v.id;
  static const Field<ObjectNotNull, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectNotNull v) => v.inputs;
  static const Field<ObjectNotNull, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectNotNull v) => v.offset;
  static const Field<ObjectNotNull, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectNotNull v) => v.label;
  static const Field<ObjectNotNull, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectNotNull v) => v.expanded;
  static const Field<ObjectNotNull, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectNotNull v) => v.getNode;
  static const Field<ObjectNotNull, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectNotNull> fields = const {
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
  final dynamic discriminatorValue = 'object_not_null';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectNotNull _instantiate(DecodingData data) {
    return ObjectNotNull(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectNotNull fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectNotNull>(map);
  }

  static ObjectNotNull fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectNotNull>(json);
  }
}

mixin ObjectNotNullMappable {
  String toJson() {
    return ObjectNotNullMapper.ensureInitialized()
        .encodeJson<ObjectNotNull>(this as ObjectNotNull);
  }

  Map<String, dynamic> toMap() {
    return ObjectNotNullMapper.ensureInitialized()
        .encodeMap<ObjectNotNull>(this as ObjectNotNull);
  }

  ObjectNotNullCopyWith<ObjectNotNull, ObjectNotNull, ObjectNotNull>
      get copyWith => _ObjectNotNullCopyWithImpl(
          this as ObjectNotNull, $identity, $identity);
  @override
  String toString() {
    return ObjectNotNullMapper.ensureInitialized()
        .stringifyValue(this as ObjectNotNull);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectNotNullMapper.ensureInitialized()
                .isValueEqual(this as ObjectNotNull, other));
  }

  @override
  int get hashCode {
    return ObjectNotNullMapper.ensureInitialized()
        .hashValue(this as ObjectNotNull);
  }
}

extension ObjectNotNullValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectNotNull, $Out> {
  ObjectNotNullCopyWith<$R, ObjectNotNull, $Out> get $asObjectNotNull =>
      $base.as((v, t, t2) => _ObjectNotNullCopyWithImpl(v, t, t2));
}

abstract class ObjectNotNullCopyWith<$R, $In extends ObjectNotNull, $Out>
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
  ObjectNotNullCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectNotNullCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectNotNull, $Out>
    implements ObjectNotNullCopyWith<$R, ObjectNotNull, $Out> {
  _ObjectNotNullCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectNotNull> $mapper =
      ObjectNotNullMapper.ensureInitialized();
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
  ObjectNotNull $make(CopyWithData data) => ObjectNotNull(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectNotNullCopyWith<$R2, ObjectNotNull, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectNotNullCopyWithImpl($value, $cast, t);
}
