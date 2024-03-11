// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_is_set.dart';

class ObjectIsSetMapper extends SubClassMapperBase<ObjectIsSet> {
  ObjectIsSetMapper._();

  static ObjectIsSetMapper? _instance;
  static ObjectIsSetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIsSetMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIsSet';

  static int _$id(ObjectIsSet v) => v.id;
  static const Field<ObjectIsSet, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectIsSet v) => v.inputs;
  static const Field<ObjectIsSet, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectIsSet v) => v.offset;
  static const Field<ObjectIsSet, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectIsSet v) => v.label;
  static const Field<ObjectIsSet, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectIsSet v) => v.expanded;
  static const Field<ObjectIsSet, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectIsSet v) => v.getNode;
  static const Field<ObjectIsSet, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectIsSet> fields = const {
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
  final dynamic discriminatorValue = 'object_is_set';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectIsSet _instantiate(DecodingData data) {
    return ObjectIsSet(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIsSet fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIsSet>(map);
  }

  static ObjectIsSet fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIsSet>(json);
  }
}

mixin ObjectIsSetMappable {
  String toJson() {
    return ObjectIsSetMapper.ensureInitialized()
        .encodeJson<ObjectIsSet>(this as ObjectIsSet);
  }

  Map<String, dynamic> toMap() {
    return ObjectIsSetMapper.ensureInitialized()
        .encodeMap<ObjectIsSet>(this as ObjectIsSet);
  }

  ObjectIsSetCopyWith<ObjectIsSet, ObjectIsSet, ObjectIsSet> get copyWith =>
      _ObjectIsSetCopyWithImpl(this as ObjectIsSet, $identity, $identity);
  @override
  String toString() {
    return ObjectIsSetMapper.ensureInitialized()
        .stringifyValue(this as ObjectIsSet);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectIsSetMapper.ensureInitialized()
                .isValueEqual(this as ObjectIsSet, other));
  }

  @override
  int get hashCode {
    return ObjectIsSetMapper.ensureInitialized().hashValue(this as ObjectIsSet);
  }
}

extension ObjectIsSetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIsSet, $Out> {
  ObjectIsSetCopyWith<$R, ObjectIsSet, $Out> get $asObjectIsSet =>
      $base.as((v, t, t2) => _ObjectIsSetCopyWithImpl(v, t, t2));
}

abstract class ObjectIsSetCopyWith<$R, $In extends ObjectIsSet, $Out>
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
  ObjectIsSetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectIsSetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIsSet, $Out>
    implements ObjectIsSetCopyWith<$R, ObjectIsSet, $Out> {
  _ObjectIsSetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIsSet> $mapper =
      ObjectIsSetMapper.ensureInitialized();
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
  ObjectIsSet $make(CopyWithData data) => ObjectIsSet(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectIsSetCopyWith<$R2, ObjectIsSet, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIsSetCopyWithImpl($value, $cast, t);
}
