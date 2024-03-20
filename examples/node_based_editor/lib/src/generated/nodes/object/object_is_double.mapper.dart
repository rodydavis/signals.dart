// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_is_double.dart';

class ObjectIsDoubleMapper extends SubClassMapperBase<ObjectIsDouble> {
  ObjectIsDoubleMapper._();

  static ObjectIsDoubleMapper? _instance;
  static ObjectIsDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIsDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIsDouble';

  static int _$id(ObjectIsDouble v) => v.id;
  static const Field<ObjectIsDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectIsDouble v) => v.inputs;
  static const Field<ObjectIsDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectIsDouble v) => v.offset;
  static const Field<ObjectIsDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectIsDouble v) => v.label;
  static const Field<ObjectIsDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectIsDouble v) => v.expanded;
  static const Field<ObjectIsDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectIsDouble v) => v.getNode;
  static const Field<ObjectIsDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectIsDouble> fields = const {
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
  final dynamic discriminatorValue = 'object_is_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectIsDouble _instantiate(DecodingData data) {
    return ObjectIsDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIsDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIsDouble>(map);
  }

  static ObjectIsDouble fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIsDouble>(json);
  }
}

mixin ObjectIsDoubleMappable {
  String toJson() {
    return ObjectIsDoubleMapper.ensureInitialized()
        .encodeJson<ObjectIsDouble>(this as ObjectIsDouble);
  }

  Map<String, dynamic> toMap() {
    return ObjectIsDoubleMapper.ensureInitialized()
        .encodeMap<ObjectIsDouble>(this as ObjectIsDouble);
  }

  ObjectIsDoubleCopyWith<ObjectIsDouble, ObjectIsDouble, ObjectIsDouble>
      get copyWith => _ObjectIsDoubleCopyWithImpl(
          this as ObjectIsDouble, $identity, $identity);
  @override
  String toString() {
    return ObjectIsDoubleMapper.ensureInitialized()
        .stringifyValue(this as ObjectIsDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectIsDoubleMapper.ensureInitialized()
                .isValueEqual(this as ObjectIsDouble, other));
  }

  @override
  int get hashCode {
    return ObjectIsDoubleMapper.ensureInitialized()
        .hashValue(this as ObjectIsDouble);
  }
}

extension ObjectIsDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIsDouble, $Out> {
  ObjectIsDoubleCopyWith<$R, ObjectIsDouble, $Out> get $asObjectIsDouble =>
      $base.as((v, t, t2) => _ObjectIsDoubleCopyWithImpl(v, t, t2));
}

abstract class ObjectIsDoubleCopyWith<$R, $In extends ObjectIsDouble, $Out>
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
  ObjectIsDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ObjectIsDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIsDouble, $Out>
    implements ObjectIsDoubleCopyWith<$R, ObjectIsDouble, $Out> {
  _ObjectIsDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIsDouble> $mapper =
      ObjectIsDoubleMapper.ensureInitialized();
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
  ObjectIsDouble $make(CopyWithData data) => ObjectIsDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectIsDoubleCopyWith<$R2, ObjectIsDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectIsDoubleCopyWithImpl($value, $cast, t);
}
