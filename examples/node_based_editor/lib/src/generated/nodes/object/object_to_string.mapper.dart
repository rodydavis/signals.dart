// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_to_string.dart';

class ObjectToStringMapper extends SubClassMapperBase<ObjectToString> {
  ObjectToStringMapper._();

  static ObjectToStringMapper? _instance;
  static ObjectToStringMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectToStringMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectToString';

  static int _$id(ObjectToString v) => v.id;
  static const Field<ObjectToString, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectToString v) => v.inputs;
  static const Field<ObjectToString, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectToString v) => v.offset;
  static const Field<ObjectToString, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectToString v) => v.label;
  static const Field<ObjectToString, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectToString v) => v.expanded;
  static const Field<ObjectToString, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectToString v) => v.getNode;
  static const Field<ObjectToString, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectToString> fields = const {
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
  final dynamic discriminatorValue = 'object_to_string';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectToString _instantiate(DecodingData data) {
    return ObjectToString(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectToString fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectToString>(map);
  }

  static ObjectToString fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectToString>(json);
  }
}

mixin ObjectToStringMappable {
  String toJson() {
    return ObjectToStringMapper.ensureInitialized()
        .encodeJson<ObjectToString>(this as ObjectToString);
  }

  Map<String, dynamic> toMap() {
    return ObjectToStringMapper.ensureInitialized()
        .encodeMap<ObjectToString>(this as ObjectToString);
  }

  ObjectToStringCopyWith<ObjectToString, ObjectToString, ObjectToString>
      get copyWith => _ObjectToStringCopyWithImpl(
          this as ObjectToString, $identity, $identity);
  @override
  String toString() {
    return ObjectToStringMapper.ensureInitialized()
        .stringifyValue(this as ObjectToString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectToStringMapper.ensureInitialized()
                .isValueEqual(this as ObjectToString, other));
  }

  @override
  int get hashCode {
    return ObjectToStringMapper.ensureInitialized()
        .hashValue(this as ObjectToString);
  }
}

extension ObjectToStringValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectToString, $Out> {
  ObjectToStringCopyWith<$R, ObjectToString, $Out> get $asObjectToString =>
      $base.as((v, t, t2) => _ObjectToStringCopyWithImpl(v, t, t2));
}

abstract class ObjectToStringCopyWith<$R, $In extends ObjectToString, $Out>
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
  ObjectToStringCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ObjectToStringCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectToString, $Out>
    implements ObjectToStringCopyWith<$R, ObjectToString, $Out> {
  _ObjectToStringCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectToString> $mapper =
      ObjectToStringMapper.ensureInitialized();
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
  ObjectToString $make(CopyWithData data) => ObjectToString(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectToStringCopyWith<$R2, ObjectToString, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectToStringCopyWithImpl($value, $cast, t);
}
