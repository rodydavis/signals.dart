// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_is_map.dart';

class ObjectIsMapMapper extends SubClassMapperBase<ObjectIsMap> {
  ObjectIsMapMapper._();

  static ObjectIsMapMapper? _instance;
  static ObjectIsMapMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIsMapMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIsMap';

  static int _$id(ObjectIsMap v) => v.id;
  static const Field<ObjectIsMap, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectIsMap v) => v.inputs;
  static const Field<ObjectIsMap, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectIsMap v) => v.offset;
  static const Field<ObjectIsMap, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectIsMap v) => v.label;
  static const Field<ObjectIsMap, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectIsMap v) => v.expanded;
  static const Field<ObjectIsMap, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectIsMap v) => v.getNode;
  static const Field<ObjectIsMap, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectIsMap> fields = const {
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
  final dynamic discriminatorValue = 'object_is_map';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectIsMap _instantiate(DecodingData data) {
    return ObjectIsMap(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIsMap fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIsMap>(map);
  }

  static ObjectIsMap fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIsMap>(json);
  }
}

mixin ObjectIsMapMappable {
  String toJson() {
    return ObjectIsMapMapper.ensureInitialized()
        .encodeJson<ObjectIsMap>(this as ObjectIsMap);
  }

  Map<String, dynamic> toMap() {
    return ObjectIsMapMapper.ensureInitialized()
        .encodeMap<ObjectIsMap>(this as ObjectIsMap);
  }

  ObjectIsMapCopyWith<ObjectIsMap, ObjectIsMap, ObjectIsMap> get copyWith =>
      _ObjectIsMapCopyWithImpl(this as ObjectIsMap, $identity, $identity);
  @override
  String toString() {
    return ObjectIsMapMapper.ensureInitialized()
        .stringifyValue(this as ObjectIsMap);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectIsMapMapper.ensureInitialized()
                .isValueEqual(this as ObjectIsMap, other));
  }

  @override
  int get hashCode {
    return ObjectIsMapMapper.ensureInitialized().hashValue(this as ObjectIsMap);
  }
}

extension ObjectIsMapValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIsMap, $Out> {
  ObjectIsMapCopyWith<$R, ObjectIsMap, $Out> get $asObjectIsMap =>
      $base.as((v, t, t2) => _ObjectIsMapCopyWithImpl(v, t, t2));
}

abstract class ObjectIsMapCopyWith<$R, $In extends ObjectIsMap, $Out>
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
  ObjectIsMapCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectIsMapCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIsMap, $Out>
    implements ObjectIsMapCopyWith<$R, ObjectIsMap, $Out> {
  _ObjectIsMapCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIsMap> $mapper =
      ObjectIsMapMapper.ensureInitialized();
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
  ObjectIsMap $make(CopyWithData data) => ObjectIsMap(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectIsMapCopyWith<$R2, ObjectIsMap, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIsMapCopyWithImpl($value, $cast, t);
}
