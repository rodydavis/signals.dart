// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_is.dart';

class ObjectIsMapper extends SubClassMapperBase<ObjectIs> {
  ObjectIsMapper._();

  static ObjectIsMapper? _instance;
  static ObjectIsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIsMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIs';

  static int _$id(ObjectIs v) => v.id;
  static const Field<ObjectIs, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectIs v) => v.inputs;
  static const Field<ObjectIs, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectIs v) => v.offset;
  static const Field<ObjectIs, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectIs v) => v.label;
  static const Field<ObjectIs, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectIs v) => v.expanded;
  static const Field<ObjectIs, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectIs v) => v.getNode;
  static const Field<ObjectIs, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectIs> fields = const {
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
  final dynamic discriminatorValue = 'object_is';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectIs _instantiate(DecodingData data) {
    return ObjectIs(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIs fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIs>(map);
  }

  static ObjectIs fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIs>(json);
  }
}

mixin ObjectIsMappable {
  String toJson() {
    return ObjectIsMapper.ensureInitialized()
        .encodeJson<ObjectIs>(this as ObjectIs);
  }

  Map<String, dynamic> toMap() {
    return ObjectIsMapper.ensureInitialized()
        .encodeMap<ObjectIs>(this as ObjectIs);
  }

  ObjectIsCopyWith<ObjectIs, ObjectIs, ObjectIs> get copyWith =>
      _ObjectIsCopyWithImpl(this as ObjectIs, $identity, $identity);
  @override
  String toString() {
    return ObjectIsMapper.ensureInitialized().stringifyValue(this as ObjectIs);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectIsMapper.ensureInitialized()
                .isValueEqual(this as ObjectIs, other));
  }

  @override
  int get hashCode {
    return ObjectIsMapper.ensureInitialized().hashValue(this as ObjectIs);
  }
}

extension ObjectIsValueCopy<$R, $Out> on ObjectCopyWith<$R, ObjectIs, $Out> {
  ObjectIsCopyWith<$R, ObjectIs, $Out> get $asObjectIs =>
      $base.as((v, t, t2) => _ObjectIsCopyWithImpl(v, t, t2));
}

abstract class ObjectIsCopyWith<$R, $In extends ObjectIs, $Out>
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
  ObjectIsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectIsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIs, $Out>
    implements ObjectIsCopyWith<$R, ObjectIs, $Out> {
  _ObjectIsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIs> $mapper =
      ObjectIsMapper.ensureInitialized();
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
  ObjectIs $make(CopyWithData data) => ObjectIs(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectIsCopyWith<$R2, ObjectIs, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIsCopyWithImpl($value, $cast, t);
}
