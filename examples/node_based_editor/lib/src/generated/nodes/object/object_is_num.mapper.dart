// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_is_num.dart';

class ObjectIsNumMapper extends SubClassMapperBase<ObjectIsNum> {
  ObjectIsNumMapper._();

  static ObjectIsNumMapper? _instance;
  static ObjectIsNumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIsNumMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIsNum';

  static int _$id(ObjectIsNum v) => v.id;
  static const Field<ObjectIsNum, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectIsNum v) => v.inputs;
  static const Field<ObjectIsNum, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectIsNum v) => v.offset;
  static const Field<ObjectIsNum, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectIsNum v) => v.label;
  static const Field<ObjectIsNum, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectIsNum v) => v.expanded;
  static const Field<ObjectIsNum, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectIsNum v) => v.getNode;
  static const Field<ObjectIsNum, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectIsNum> fields = const {
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
  final dynamic discriminatorValue = 'object_is_num';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectIsNum _instantiate(DecodingData data) {
    return ObjectIsNum(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIsNum fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIsNum>(map);
  }

  static ObjectIsNum fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIsNum>(json);
  }
}

mixin ObjectIsNumMappable {
  String toJson() {
    return ObjectIsNumMapper.ensureInitialized()
        .encodeJson<ObjectIsNum>(this as ObjectIsNum);
  }

  Map<String, dynamic> toMap() {
    return ObjectIsNumMapper.ensureInitialized()
        .encodeMap<ObjectIsNum>(this as ObjectIsNum);
  }

  ObjectIsNumCopyWith<ObjectIsNum, ObjectIsNum, ObjectIsNum> get copyWith =>
      _ObjectIsNumCopyWithImpl(this as ObjectIsNum, $identity, $identity);
  @override
  String toString() {
    return ObjectIsNumMapper.ensureInitialized()
        .stringifyValue(this as ObjectIsNum);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectIsNumMapper.ensureInitialized()
                .isValueEqual(this as ObjectIsNum, other));
  }

  @override
  int get hashCode {
    return ObjectIsNumMapper.ensureInitialized().hashValue(this as ObjectIsNum);
  }
}

extension ObjectIsNumValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIsNum, $Out> {
  ObjectIsNumCopyWith<$R, ObjectIsNum, $Out> get $asObjectIsNum =>
      $base.as((v, t, t2) => _ObjectIsNumCopyWithImpl(v, t, t2));
}

abstract class ObjectIsNumCopyWith<$R, $In extends ObjectIsNum, $Out>
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
  ObjectIsNumCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectIsNumCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIsNum, $Out>
    implements ObjectIsNumCopyWith<$R, ObjectIsNum, $Out> {
  _ObjectIsNumCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIsNum> $mapper =
      ObjectIsNumMapper.ensureInitialized();
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
  ObjectIsNum $make(CopyWithData data) => ObjectIsNum(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectIsNumCopyWith<$R2, ObjectIsNum, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIsNumCopyWithImpl($value, $cast, t);
}
