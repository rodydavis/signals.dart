// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_is_list.dart';

class ObjectIsListMapper extends SubClassMapperBase<ObjectIsList> {
  ObjectIsListMapper._();

  static ObjectIsListMapper? _instance;
  static ObjectIsListMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIsListMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIsList';

  static int _$id(ObjectIsList v) => v.id;
  static const Field<ObjectIsList, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectIsList v) => v.inputs;
  static const Field<ObjectIsList, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectIsList v) => v.offset;
  static const Field<ObjectIsList, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectIsList v) => v.label;
  static const Field<ObjectIsList, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectIsList v) => v.expanded;
  static const Field<ObjectIsList, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectIsList v) => v.getNode;
  static const Field<ObjectIsList, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectIsList> fields = const {
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
  final dynamic discriminatorValue = 'object_is_list';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectIsList _instantiate(DecodingData data) {
    return ObjectIsList(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIsList fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIsList>(map);
  }

  static ObjectIsList fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIsList>(json);
  }
}

mixin ObjectIsListMappable {
  String toJson() {
    return ObjectIsListMapper.ensureInitialized()
        .encodeJson<ObjectIsList>(this as ObjectIsList);
  }

  Map<String, dynamic> toMap() {
    return ObjectIsListMapper.ensureInitialized()
        .encodeMap<ObjectIsList>(this as ObjectIsList);
  }

  ObjectIsListCopyWith<ObjectIsList, ObjectIsList, ObjectIsList> get copyWith =>
      _ObjectIsListCopyWithImpl(this as ObjectIsList, $identity, $identity);
  @override
  String toString() {
    return ObjectIsListMapper.ensureInitialized()
        .stringifyValue(this as ObjectIsList);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectIsListMapper.ensureInitialized()
                .isValueEqual(this as ObjectIsList, other));
  }

  @override
  int get hashCode {
    return ObjectIsListMapper.ensureInitialized()
        .hashValue(this as ObjectIsList);
  }
}

extension ObjectIsListValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIsList, $Out> {
  ObjectIsListCopyWith<$R, ObjectIsList, $Out> get $asObjectIsList =>
      $base.as((v, t, t2) => _ObjectIsListCopyWithImpl(v, t, t2));
}

abstract class ObjectIsListCopyWith<$R, $In extends ObjectIsList, $Out>
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
  ObjectIsListCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectIsListCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIsList, $Out>
    implements ObjectIsListCopyWith<$R, ObjectIsList, $Out> {
  _ObjectIsListCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIsList> $mapper =
      ObjectIsListMapper.ensureInitialized();
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
  ObjectIsList $make(CopyWithData data) => ObjectIsList(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectIsListCopyWith<$R2, ObjectIsList, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIsListCopyWithImpl($value, $cast, t);
}
