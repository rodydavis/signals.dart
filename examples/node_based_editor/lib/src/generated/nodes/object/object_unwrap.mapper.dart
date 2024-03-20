// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_unwrap.dart';

class ObjectUnwrapMapper extends SubClassMapperBase<ObjectUnwrap> {
  ObjectUnwrapMapper._();

  static ObjectUnwrapMapper? _instance;
  static ObjectUnwrapMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectUnwrapMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectUnwrap';

  static int _$id(ObjectUnwrap v) => v.id;
  static const Field<ObjectUnwrap, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectUnwrap v) => v.inputs;
  static const Field<ObjectUnwrap, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectUnwrap v) => v.offset;
  static const Field<ObjectUnwrap, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectUnwrap v) => v.label;
  static const Field<ObjectUnwrap, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectUnwrap v) => v.expanded;
  static const Field<ObjectUnwrap, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectUnwrap v) => v.getNode;
  static const Field<ObjectUnwrap, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectUnwrap> fields = const {
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
  final dynamic discriminatorValue = 'object_unwrap';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectUnwrap _instantiate(DecodingData data) {
    return ObjectUnwrap(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectUnwrap fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectUnwrap>(map);
  }

  static ObjectUnwrap fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectUnwrap>(json);
  }
}

mixin ObjectUnwrapMappable {
  String toJson() {
    return ObjectUnwrapMapper.ensureInitialized()
        .encodeJson<ObjectUnwrap>(this as ObjectUnwrap);
  }

  Map<String, dynamic> toMap() {
    return ObjectUnwrapMapper.ensureInitialized()
        .encodeMap<ObjectUnwrap>(this as ObjectUnwrap);
  }

  ObjectUnwrapCopyWith<ObjectUnwrap, ObjectUnwrap, ObjectUnwrap> get copyWith =>
      _ObjectUnwrapCopyWithImpl(this as ObjectUnwrap, $identity, $identity);
  @override
  String toString() {
    return ObjectUnwrapMapper.ensureInitialized()
        .stringifyValue(this as ObjectUnwrap);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectUnwrapMapper.ensureInitialized()
                .isValueEqual(this as ObjectUnwrap, other));
  }

  @override
  int get hashCode {
    return ObjectUnwrapMapper.ensureInitialized()
        .hashValue(this as ObjectUnwrap);
  }
}

extension ObjectUnwrapValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectUnwrap, $Out> {
  ObjectUnwrapCopyWith<$R, ObjectUnwrap, $Out> get $asObjectUnwrap =>
      $base.as((v, t, t2) => _ObjectUnwrapCopyWithImpl(v, t, t2));
}

abstract class ObjectUnwrapCopyWith<$R, $In extends ObjectUnwrap, $Out>
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
  ObjectUnwrapCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectUnwrapCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectUnwrap, $Out>
    implements ObjectUnwrapCopyWith<$R, ObjectUnwrap, $Out> {
  _ObjectUnwrapCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectUnwrap> $mapper =
      ObjectUnwrapMapper.ensureInitialized();
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
  ObjectUnwrap $make(CopyWithData data) => ObjectUnwrap(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectUnwrapCopyWith<$R2, ObjectUnwrap, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectUnwrapCopyWithImpl($value, $cast, t);
}
